import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:flutter/services.dart';

abstract class LocationsLocalDataSource {
  Future<List<LocationModel>> loadLocations();
  Future<LocationModel> getLocation(String name);
  Future<List<Location>> getLocationAncestors(Location location);
  Future<List<LocationModel>> getLocationSubrings(Location location);
  Future<List<LocationModel>> getLocationChildren(Location location);
}

class LocationsLocalDataSourceImpl implements LocationsLocalDataSource {
  final String fileName;
  List<LocationModel> locations = [];

  LocationsLocalDataSourceImpl({required this.fileName}) {
    loadLocations();
  }
  @override
  Future<List<LocationModel>> loadLocations() async {
    String locationString = await rootBundle.loadString(fileName);
    var locationsArray = locationString.split("\n");
    locations = <LocationModel>[];
    for (var locationName in locationsArray) {
      locations.add(LocationModel.fromString(locationName));
    }
    return locations;
  }

  @override
  Future<LocationModel> getLocation(String name) async {
    return LocationModel.fromString(name);
  }

  @override
  Future<List<Location>> getLocationAncestors(Location location) {
    final array = location.fullName.split("/");
    var ancestors = <Location>[];
    var currentLocation = location.parent;
    while (currentLocation!.parent != null) {
      ancestors.insert(0, currentLocation);
      currentLocation = currentLocation.parent!;
      if (currentLocation!.parent == null) break;
    }
    return Future.value(ancestors);
  }

  @override
  Future<List<LocationModel>> getLocationSubrings(Location location) {
    return Future.value(locations
        .where((element) => element.parent == location.parent)
        .toList());
  }

  @override
  Future<List<LocationModel>> getLocationChildren(Location location) {
    return Future.value(
        locations.where((element) => element.parent == location).toList());
  }
}
