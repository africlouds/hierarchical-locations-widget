import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/models/location_model.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_ancestors.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_children.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_subrings.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final GetLocation getLocation;
  final GetLocationAncestors getLocationAncestors;
  final GetLocationSubrings getLocationSubrings;
  final GetLocationChildren getLocationChildren;
  LocationsBloc(
      {required this.getLocation,
      required this.getLocationAncestors,
      required this.getLocationSubrings,
      required this.getLocationChildren})
      : super(LocationsInitial()) {
    on<LocationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadLocationEvent>((event, emit) async {
      emit(LocationsLoading());
      final response =
          await getLocation(GetLocationParams(name: event.fullName));
      response.fold((l) => emit(LocationLoadingFailed(name: event.fullName)),
          (r) => emit(LocationLoaded(location: r)));
    });
  }
}
