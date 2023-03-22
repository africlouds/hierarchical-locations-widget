import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class LoadLocation implements UseCase<Location, LocationParams> {
  final LocationsRepository locationsRepository;

  LoadLocation({required this.locationsRepository});
  @override
  Future<Either<Failure, Location>> call(params) async {
    final location = await locationsRepository.loadLocation(params.name);
    return location;
  }
}

class LocationParams {
  final String name;

  LocationParams({required this.name});
}
