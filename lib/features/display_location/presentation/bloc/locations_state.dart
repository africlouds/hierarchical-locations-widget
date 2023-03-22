part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {
  const LocationsState();

  @override
  List<Object> get props => [];
}

class LocationsInitial extends LocationsState {}

class LocationLoaded extends LocationsState {
  final Location location;

  const LocationLoaded({required this.location});
}

class LocationLoadingFailed extends LocationsState {
  final String name;

  const LocationLoadingFailed({required this.name});
}

class LocationSubringsLoaded extends LocationsState {
  final Location location;
  final List<Location> subrings;

  const LocationSubringsLoaded(
      {required this.location, required this.subrings});
}

class LocationAncestorsLoaded extends LocationsState {
  final Location location;
  final List<Location> ancestors;

  const LocationAncestorsLoaded(
      {required this.location, required this.ancestors});
}

class LocationChildrenLoaded extends LocationsState {
  final Location location;
  final List<Location> children;

  const LocationChildrenLoaded(
      {required this.location, required this.children});
}
