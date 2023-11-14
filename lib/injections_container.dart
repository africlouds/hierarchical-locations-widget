import 'package:get_it/get_it.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/repositories/locations_repository_impl.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_ancestors.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_children.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_subrings.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(() => LocationsBloc(
      loadLocation: getIt(),
      getLocationAncestors: getIt(),
      getLocationChildren: getIt(),
      getLocationSubrings: getIt()));

  getIt.registerLazySingleton(() => GetLocation(locationsRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetLocationAncestors(locationsRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetLocationChildren(locationsRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetLocationSubrings(locationsRepository: getIt()));

  getIt.registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(locationsLocalDataSource: getIt()));

  getIt.registerLazySingleton<LocationsLocalDataSource>(
      () => LocationsLocalDataSourceImpl(fileName: "assets/locations.csv"));
}
