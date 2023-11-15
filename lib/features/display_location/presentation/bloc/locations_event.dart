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
