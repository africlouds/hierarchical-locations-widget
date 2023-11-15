import 'package:get_it/get_it.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/repositories/locations_repository_impl.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory(() => LocationsBloc(
        getLocation: getIt(),
      ));

  getIt.registerLazySingleton(() => GetLocation(locationsRepository: getIt()));

  getIt.registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(locationsLocalDataSource: getIt()));

  StoreRef store = stringMapStoreFactory.store('locations');
  var factory = databaseFactoryWeb;

  // Open the database
  var db = await factory.openDatabase('locations');
  getIt.registerLazySingleton<LocationsLocalDataSource>(() =>
      LocationsLocalDataSourceImpl(
          fileName: "assets/locations.csv", store: store, db: db));
}
