import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';

abstract class LocationsRepository {
  Future<Either<Failure, Location>> getLocation(String name);
  Future<Either<Failure, List<Location>>> getLocationAncestors(
      Location location);
  Future<Either<Failure, List<Location>>> getLocationSubrings(
      Location location);
  Future<Either<Failure, List<Location>>> getLocationChildren(
      Location location);
}
