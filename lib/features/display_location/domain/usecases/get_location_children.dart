import 'package:hierarchical_locations_widget/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hierarchical_locations_widget/core/usecases/usecase.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';

class GetLocationChildren
    implements UseCase<List<Location>, LocationChildrenParams> {
  final LocationsRepository locationsRepository;

  GetLocationChildren({required this.locationsRepository});
  @override
  Future<Either<Failure, List<Location>>> call(params) async {
    final children =
        await locationsRepository.getLocationChildren(params.location);
    return children;
  }
}

class LocationChildrenParams {
  final Location location;

  LocationChildrenParams({required this.location});
}
