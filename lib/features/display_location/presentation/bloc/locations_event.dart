part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class LoadLocationEvent extends LocationsEvent {
  final String fullName;

  LoadLocationEvent({required this.fullName});
}

class GetLocationSubringsEvent extends LocationsEvent {
  final Location location;

  GetLocationSubringsEvent({required this.location});
}

class GetLocationAncestorsEvent extends LocationsEvent {
  final Location location;

  GetLocationAncestorsEvent({required this.location});
}

class GetLocationChildrenEvent extends LocationsEvent {
  final Location location;

  GetLocationChildrenEvent({required this.location});
}
