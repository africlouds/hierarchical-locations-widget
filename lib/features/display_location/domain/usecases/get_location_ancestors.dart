import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class GetLocationAncestors
    implements UseCase<List<Location>, LocationAncestorsParams> {
  final LocationsRepository locationsRepository;

  GetLocationAncestors({required this.locationsRepository});
  @override
  Future<Either<Failure, List<Location>>> call(params) async {
    final subrings =
        await locationsRepository.getLocationAncestors(params.location);
    return subrings;
  }
}

class LocationAncestorsParams {
  final Location location;

  LocationAncestorsParams({required this.location});
}
