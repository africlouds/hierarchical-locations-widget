import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsLocalDataSource locationsLocalDataSource;

  LocationsRepositoryImpl({required this.locationsLocalDataSource});

  @override
  Future<Either<Failure, Location>> getLocation(String name) async {
    final response = await locationsLocalDataSource.getLocation(name);
    if (response != null) {
      return Right(response);
    } else {
      return Left(ServerFailure());
    }
  }
}
