import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:logger/logger.dart';

abstract class LocationsLocalDataSource {
  Future<LocationModel?> getLocation(String name);

  Future<LocationModel?> updateLocationCoordinates(
      {required String location,
      required double latitude,
      required double longitude});
}

class LocationsLocalDataSourceImpl implements LocationsLocalDataSource {
  final String fileName;
  final String coordinatesFileName;
  List<LocationModel> locations = [];
  final List<String> locationsArray;
  final List<String> locationCoordinatesArray;

  LocationsLocalDataSourceImpl({
    required this.fileName,
    required this.coordinatesFileName,
    required this.locationsArray,
    required this.locationCoordinatesArray,
  }) {
    // loadLocations();
  }

  @override
  Future<LocationModel?> getLocation(String name) async {
    String coordinates = locationCoordinatesArray.firstWhere(
        (element) => element.toString().startsWith("$name|"),
        orElse: () => "");
    var location = LocationModel.fromString(name, coordinates);
    location.ancestors = getLocationAncestors(location);
    location.subrings = getLocationSubrings(location);
    location.children = getLocationChildren(location);
    return location;
  }

  List<String> getLocationAncestors(Location location) {
    List array = location.fullName.split("/");
    var ancestors = <String>[];
    for (var i = 1; i < array.length; i++) {
      ancestors.add(array.sublist(0, i).toList().join("/"));
    }
    return ancestors;
  }

  List<String> getLocationSubrings(Location location) {
    if (location.parent != null) {
      return locationsArray
          .where((element) =>
              element.startsWith(location.parent!) &&
              element.split("/").length == location.level)
          .toList();
    } else {
      return locationsArray
          .where((element) => element.split("/").length == 1)
          .toList();
    }
  }

  List<String> getLocationChildren(Location location) {
    return locationsArray
        .where((element) =>
            element.startsWith(location.fullName) &&
            element.split("/").length == location.level + 1)
        .toList();
  }

  @override
  Future<LocationModel?> updateLocationCoordinates(
      {required String location,
      required double latitude,
      required double longitude}) async {
    Logger().d(locationCoordinatesArray);
    locationCoordinatesArray
        .removeWhere((element) => element.startsWith("$location|"));
    Logger().d(locationCoordinatesArray);
    locationCoordinatesArray.add("$location|$latitude,$longitude");
    Logger().d(locationCoordinatesArray);
    return await getLocation(location);
  }
}
