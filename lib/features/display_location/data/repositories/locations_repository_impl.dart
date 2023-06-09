import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final LocationsLocalDataSource locationsLocalDataSource;

  LocationsRepositoryImpl({required this.locationsLocalDataSource});

  @override
  Future<Either<Failure, Location>> loadLocation(String name) async {
    final response = await locationsLocalDataSource.loadLocation(name);
    return Right(response);
  }

  @override
  Future<Either<Failure, List<Location>>> getLocationAncestors(
      Location location) async {
    final response =
        await locationsLocalDataSource.getLocationAncestors(location);
    return Right(response);
  }

  @override
  Future<Either<Failure, List<Location>>> getLocationSubrings(
      Location location) async {
    final response =
        await locationsLocalDataSource.getLocationSubrings(location);
    return Right(response);
  }

  @override
  Future<Either<Failure, List<Location>>> getLocationChildren(
      Location location) async {
    final response =
        await locationsLocalDataSource.getLocationChildren(location);
    return Right(response);
    // TODO: implement getLocationChildren
  }
}
