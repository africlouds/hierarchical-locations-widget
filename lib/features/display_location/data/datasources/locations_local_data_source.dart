import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

abstract class LocationsLocalDataSource {
  Future<LocationModel?> getLocation(String name);
}

class LocationsLocalDataSourceImpl implements LocationsLocalDataSource {
  final String fileName;
  List<LocationModel> locations = [];
  final List<String> locationsArray;

  LocationsLocalDataSourceImpl({
    required this.fileName,
    required this.locationsArray,
  }) {
    // loadLocations();
  }

  @override
  Future<LocationModel?> getLocation(String name) async {
    var location = LocationModel.fromString(name);
    location.ancestors = getLocationAncestors(location);
    location.subrings = getLocationSubrings(location);
    location.children = getLocationChildren(location);
    Logger().d(location.toJson());
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
    Logger().d(
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    Logger().d(location);
    if (location.parent != null)
      return locationsArray
          .where((element) =>
              element.startsWith(location.parent!) &&
              element.split("/").length == location.level)
          .toList();
    else
      return locationsArray
          .where((element) => element.split("/").length == 1)
          .toList();
  }

  List<String> getLocationChildren(Location location) {
    return locationsArray
        .where((element) =>
            element.startsWith(location.fullName) &&
            element.split("/").length == location.level + 1)
        .toList();
  }
}
