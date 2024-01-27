part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {
  const LocationsState();

  @override
  List<Object> get props => [];
}

class LocationsInitial extends LocationsState {}

class GetLocationSuccessful extends LocationsState {
  final Location location;

  const GetLocationSuccessful({required this.location});
  @override
  List<Object> get props => [location];
}

class LocationsLoading extends LocationsState {}

class LocationLoadingFailed extends LocationsState {
  final String name;

  const LocationLoadingFailed({required this.name});
}

class UpdateLocationCoordinatesSuccessful extends LocationsState {
  final Location location;

  const UpdateLocationCoordinatesSuccessful({
    required this.location,
  });
}

class UpdateLocationCoordinatesFailed extends LocationsState {
  final String location;
  final double latitude, longitude;

  const UpdateLocationCoordinatesFailed(
      {required this.location,
      required this.latitude,
      required this.longitude});
}
