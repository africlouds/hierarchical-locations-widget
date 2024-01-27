import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';

import '../../domain/usecases/update_location_coordinates.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final GetLocation getLocation;
  final UpdateLocationCoordinates updateLocationCoordinates;
  LocationsBloc({
    required this.getLocation,
    required this.updateLocationCoordinates,
  }) : super(LocationsInitial()) {
    on<LocationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetLocationEvent>((event, emit) async {
      emit(LocationsLoading());
      final response =
          await getLocation(GetLocationParams(name: event.fullName));
      response.fold((l) => emit(LocationLoadingFailed(name: event.fullName)),
          (r) => emit(GetLocationSuccessful(location: r)));
    });
    on<UpdateLocationCoordinatesEvent>((event, emit) async {
      emit(LocationsLoading());
      final response = await updateLocationCoordinates(
          UpdateLocationCoordinatesParams(
              location: event.location,
              latitude: event.latitude,
              longitude: event.longitude));
      response.fold(
          (l) => emit(UpdateLocationCoordinatesFailed(
              location: event.location,
              latitude: event.latitude,
              longitude: event.longitude)),
          (r) => emit(UpdateLocationCoordinatesSuccessful(location: r)));
    });
  }
  Future<Location?> getLocationSync(String name) async {
    final response = await getLocation(GetLocationParams(name: name));
    var location = response.fold((l) => null, (r) => r);
    return location;
  }
}
