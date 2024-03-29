import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class GetLocation implements UseCase<Location, GetLocationParams> {
  final LocationsRepository locationsRepository;

  GetLocation({required this.locationsRepository});
  @override
  Future<Either<Failure, Location>> call(params) async {
    final location = await locationsRepository.getLocation(params.name);
    return location;
  }
}

class GetLocationParams {
  final String name;

  GetLocationParams({required this.name});
}
