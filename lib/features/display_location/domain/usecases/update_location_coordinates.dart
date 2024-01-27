import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class UpdateLocationCoordinates
    implements UseCase<Location, UpdateLocationCoordinatesParams> {
  final LocationsRepository locationsRepository;

  UpdateLocationCoordinates({required this.locationsRepository});
  @override
  Future<Either<Failure, Location>> call(params) async {
    final location = await locationsRepository.updateLocationCoordinates(
        location: params.location,
        latitude: params.latitude,
        longitude: params.longitude);
    return location;
  }
}

class UpdateLocationCoordinatesParams {
  final String location;
  final double latitude, longitude;

  UpdateLocationCoordinatesParams(
      {required this.location,
      required this.latitude,
      required this.longitude});
}
