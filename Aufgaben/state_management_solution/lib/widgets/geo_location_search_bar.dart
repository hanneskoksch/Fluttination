import 'package:flutter/material.dart';
import 'package:state_management/data/api.dart';
import 'package:state_management/utils/debouncer.dart';

import '../models/geo_location.dart';

// A search bar that displays city suggestions based on the user's input.
class GeoLocationSearchBar extends StatefulWidget {
  const GeoLocationSearchBar({
    super.key,
    required this.onLocationSelected,
  });

  final void Function(GeoLocation?) onLocationSelected;

  @override
  State<GeoLocationSearchBar> createState() => _GeoLocationSearchBarState();
}

typedef _GeoLocationSearchDebounder = Debouncer<List<GeoLocation>?>;
typedef _GeoLocationSearch = Future<List<GeoLocation>?>;

class _GeoLocationSearchBarState extends State<GeoLocationSearchBar> {
  final SearchController _controller = SearchController();
  final _GeoLocationSearchDebounder _debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  _GeoLocationSearch? _search;

  @override
  void dispose() {
    _debouncer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      isFullScreen: MediaQuery.of(context).size.width < 600,
      searchController: _controller,
      viewOnChanged: (input) => _searchChanged(input),
      builder: (context, controller) => _SearchBar(
        controller: _controller,
      ),
      viewBuilder: (suggestions) => _SuggestionsBuilder(
        search: _search,
        suggestions: suggestions,
      ),
      viewTrailing: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => _clearSelection(),
        ),
      ],
      suggestionsBuilder: (context, controller) async {
        final locations = await _search;
        if (locations == null) return const [];

        return [
          for (final location in locations)
            ListTile(
              title: Text(location.name),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => _selectLocation(location),
            ),
        ];
      },
    );
  }

  /// Selects the location and closes the suggestions view.
  void _selectLocation(GeoLocation location) {
    _controller.closeView(location.name);
    widget.onLocationSelected(location);
  }

  /// Sets the selection to none
  void _clearSelection() {
    _controller.closeView("");
    widget.onLocationSelected(null);
  }

  /// Closes the suggestions view when its empty.
  /// Otherwise it will set the search future after
  /// debouncing subsequent requests.
  void _searchChanged(input) {
    if (input.isEmpty && _controller.isOpen) {
      return _clearSelection();
    }

    setState(() {
      _debouncer.debounce(() => Api.getGeoLocations(input));
      _search = _debouncer.future;
    });
  }
}

/// A FutureBuilder that displays the search suggestions.
///
/// It will display a loading indicator while the search is in progress.
/// If the search is done and there are no suggestions, it will display a message.
/// If the search is done and there are suggestions, it will display them.
/// If the search has failed, it will display an error message.
class _SuggestionsBuilder extends StatelessWidget {
  const _SuggestionsBuilder({
    required this.search,
    required this.suggestions,
  });

  final _GeoLocationSearch? search;
  final Iterable<Widget> suggestions;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: search,
      builder: (context, snapshot) => switch (snapshot.connectionState) {
        // No future yet/not loading
        ConnectionState.none =>
          const Center(child: Text("Start typing to get suggestions...")),
        // Suggestions loaded but empty
        ConnectionState.done when snapshot.hasData & suggestions.isEmpty =>
          const Center(child: Text("No suggestions found...")),
        // Suggestions loaded
        ConnectionState.done when snapshot.hasData =>
          ListView(children: [...suggestions]),
        // Errored
        ConnectionState.done when snapshot.hasError =>
          const Center(child: Text("Error while getting suggestions...")),
        // Loading
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

/// A SearchBar that opens the suggestions view when tapped.
class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: "Enter a city...",
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => switch (states) {
          _ when states.contains(MaterialState.selected) => Colors.white,
          _ => Colors.white.withOpacity(.40),
        },
      ),
      leading: const Icon(Icons.search),
      onTap: () => controller.openView(),
      onChanged: (_) => controller.openView(),
    );
  }
}
