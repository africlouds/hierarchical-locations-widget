import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

abstract class LocationsLocalDataSource {
  Future<List<LocationModel>> loadLocations();
  Future<LocationModel?> getLocation(String name);
}

class LocationsLocalDataSourceImpl implements LocationsLocalDataSource {
  final String fileName;
  List<LocationModel> locations = [];
  final Database db;
  StoreRef store;

  LocationsLocalDataSourceImpl(
      {required this.fileName, required this.store, required this.db}) {
    loadLocations();
  }
  @override
  Future<List<LocationModel>> loadLocations() async {
    String locationString = await rootBundle.loadString(fileName);
    var locationsArray = locationString.split("\n");

    await db.transaction((txn) async {
      for (var locationName in locationsArray) {
        var location = LocationModel.fromString(
            locationName.toString().replaceAll('\r', ''));
        //await store.add(db, location.toJson());
        var locationJson = location.toJson();
        Logger().d(locationJson);
        await store.record(location.fullName).put(txn, location.toJson());
      }
    });
    return locations;
  }

  @override
  Future<LocationModel?> getLocation(String name) async {
    var finder = Finder(
      filter: Filter.equals('full_name', name),
    );
    var records = await store.find(db, finder: finder);
    if (records.isNotEmpty) {
      var locationJson = records[0].value as Map;
      Logger().d(locationJson);
      var location = LocationModel.fromJson(records[0].value as Map);
      location.ancestors = getLocationAncestors(location);
      /*
    location.subrings = await getLocationSubrings(location);
    location.children = await getLocationChildren(location);
    */
      return location;
    }
    return null;
  }

  List<String> getLocationAncestors(Location location) {
    List array = location.fullName.split("/");
    var ancestors = <String>[];
    for (var i = 0; i < array.length; i++) {
      ancestors.add(array.sublist(0, i).toList().join("/"));
    }
    return ancestors;
  }

  Future<List<LocationModel>> getLocationSubrings(Location location) {
    return Future.value(locations
        .where((element) => element.parent == location.parent)
        .toList());
  }

  Future<List<LocationModel>> getLocationChildren(Location location) {
    return Future.value(locations
        .where((element) => element.parent == location.fullName)
        .toList());
  }
}
