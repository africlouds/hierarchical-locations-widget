import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/repositories/locations_repository_impl.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(() => LocationsBloc(
        getLocation: getIt(),
      ));

  getIt.registerLazySingleton(() => GetLocation(locationsRepository: getIt()));

  getIt.registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(locationsLocalDataSource: getIt()));

  // Open the database
  var fileName = "assets/locations.csv";
  String locationString = await rootBundle.loadString(fileName);
  var locationsArray = locationString.split("\r\n");

  getIt.registerLazySingleton<LocationsLocalDataSource>(
      () => LocationsLocalDataSourceImpl(
            fileName: "assets/locations.csv",
            locationsArray: locationsArray,
          ));
}
