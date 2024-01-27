import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/update_location_coordinates.dart';

abstract class LocationsRepository {
  Future<Either<Failure, Location>> getLocation(String name);
  Future<Either<Failure, Location>> updateLocationCoordinates(
      {required String location,
      required double latitude,
      required double longitude});
}
