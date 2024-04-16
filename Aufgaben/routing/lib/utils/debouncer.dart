// A wrapper around Timer used for debouncing.
import 'dart:async';

class Debouncer<T> {
  final Duration duration;

  Debouncer({required this.duration});

  Timer? _timer;
  Completer<T?>? _completer;

  Future<T?>? get future => _completer?.future;

  void debounce(FutureOr<T> Function() action) async {
    if (_timer != null && _completer!.isCompleted == false) {
      cancel();
    }

    _completer = Completer();
    _timer = Timer(duration, () {
      _completer!.complete(action());
      cancel();
    });
  }

  void cancel() {
    _timer?.cancel();
    if (_completer?.isCompleted == false) {
      _completer?.complete();
    }
  }
}
