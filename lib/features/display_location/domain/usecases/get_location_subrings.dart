import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class GetLocationSubrings
    implements UseCase<List<Location>, LocationSubringsParams> {
  final LocationsRepository locationsRepository;

  GetLocationSubrings({required this.locationsRepository});
  @override
  Future<Either<Failure, List<Location>>> call(params) async {
    final subrings =
        await locationsRepository.getLocationSubrings(params.location);
    return subrings;
  }
}

class LocationSubringsParams {
  final Location location;

  LocationSubringsParams({required this.location});
}
