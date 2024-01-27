import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/repositories/locations_repository_impl.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/update_location_coordinates.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(() =>
      LocationsBloc(getLocation: getIt(), updateLocationCoordinates: getIt()));

  getIt.registerLazySingleton(() => GetLocation(locationsRepository: getIt()));
  getIt.registerLazySingleton(
      () => UpdateLocationCoordinates(locationsRepository: getIt()));

  getIt.registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(locationsLocalDataSource: getIt()));

  // Open the database
  var fileName = "assets/locations.csv";
  String locationString = await rootBundle.loadString(fileName);
  var coordinatesFileName = "assets/locations_coordinates.csv";
  String locationsCoordinatesString =
      await rootBundle.loadString(coordinatesFileName);
  var locationsArray = locationString.split("\r\n");
  var locationCoordinatesArray = locationsCoordinatesString.split("\r\n");

  getIt.registerLazySingleton<LocationsLocalDataSource>(
      () => LocationsLocalDataSourceImpl(
            fileName: "assets/locations.csv",
            coordinatesFileName: "assets/locations_coordinates.csv",
            locationsArray: locationsArray,
            locationCoordinatesArray: locationCoordinatesArray,
          ));
}
