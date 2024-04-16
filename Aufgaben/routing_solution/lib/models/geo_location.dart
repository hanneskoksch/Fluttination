class GeoLocation {
  final String name;
  final double latitude;
  final double longitude;

  const GeoLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory GeoLocation.fromJson({required Map<String, dynamic> json}) {
    return GeoLocation(
      name: json['display_name'],
      latitude: double.parse(json['lat']),
      longitude: double.parse(json['lon']),
    );
  }
}
