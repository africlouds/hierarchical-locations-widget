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
  final GetLocation loadLocation;
  final GetLocationAncestors getLocationAncestors;
  final GetLocationSubrings getLocationSubrings;
  final GetLocationChildren getLocationChildren;
  LocationsBloc(
      {required this.loadLocation,
      required this.getLocationAncestors,
      required this.getLocationSubrings,
      required this.getLocationChildren})
      : super(LocationsInitial()) {
    on<LocationsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadLocationEvent>((event, emit) async {
      final response =
          await loadLocation(GetLocationParams(name: event.fullName));
      response.fold((l) => emit(LocationLoadingFailed(name: event.fullName)),
          (r) => emit(LocationLoaded(location: r)));
    });
    on<GetLocationAncestorsEvent>((event, emit) async {
      // emit(LocationAncestorsLoaded(
      //    location: event.location, ancestors: ancestors));
      final response = await getLocationAncestors(
          LocationAncestorsParams(location: event.location));
      response.fold((l) => null,
          (r) => emit(LocationLoaded(location: event.location..ancestors = r)));
    });
    on<GetLocationSubringsEvent>((event, emit) async {
      final response = await getLocationSubrings(
          LocationSubringsParams(location: event.location));
      response.fold((l) => null, (r) {
        emit(LocationLoaded(location: event.location..subrings = r));
        // emit(LocationSubringsLoaded(
        //   location: event.location..subrings = r, subrings: r));
      });
    });
    on<GetLocationChildrenEvent>((event, emit) async {
      final response = await getLocationChildren(
          LocationChildrenParams(location: event.location));
      response.fold((l) => null, (r) {
        emit(LocationLoaded(location: event.location..children = r));
        // emit(LocationSubringsLoaded(
        //   location: event.location..subrings = r, subrings: r));
      });
    });
  }
}
