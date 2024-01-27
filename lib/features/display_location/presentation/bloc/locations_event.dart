part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends LocationsEvent {
  final String fullName;

  GetLocationEvent({required this.fullName});
}

class UpdateLocationCoordinatesEvent extends LocationsEvent {
  final String location;
  final double latitude, longitude;

  UpdateLocationCoordinatesEvent(
      {required this.location,
      required this.latitude,
      required this.longitude});
}
