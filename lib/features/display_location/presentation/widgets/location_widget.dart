import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/core/presentation/utils.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/datasources/locations_local_data_source.dart';
import 'package:hierarchical_locations_widget/features/display_location/data/repositories/locations_repository_impl.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/repositories/locations_repository.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_ancestors.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_children.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/get_location_subrings.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/usecases/load_location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_picker.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/rounded_input_field.dart';

class LocationWidget extends StatefulWidget {
  //nice
  final String fileName;
  final String defaultLocation;
  const LocationWidget(
      {super.key, required this.fileName, required this.defaultLocation});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late LocationsBloc bloc;
  late LoadLocation loadLocation;
  late GetLocationAncestors getLocationAncestors;
  late GetLocationSubrings getLocationSubrings;
  late GetLocationChildren getLocationChildren;
  late LocationsRepository locationsRepository;
  late LocationsLocalDataSource locationsLocalDataSource;
  Location? location;
  @override
  void initState() {
    locationsLocalDataSource =
        LocationsLocalDataSourceImpl(fileName: widget.fileName);
    locationsRepository = LocationsRepositoryImpl(
        locationsLocalDataSource: locationsLocalDataSource);
    loadLocation = LoadLocation(locationsRepository: locationsRepository);
    getLocationAncestors =
        GetLocationAncestors(locationsRepository: locationsRepository);
    getLocationSubrings =
        GetLocationSubrings(locationsRepository: locationsRepository);
    getLocationChildren =
        GetLocationChildren(locationsRepository: locationsRepository);
    bloc = LocationsBloc(
        loadLocation: loadLocation,
        getLocationAncestors: getLocationAncestors,
        getLocationSubrings: getLocationSubrings,
        getLocationChildren: getLocationChildren);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc..add(LoadLocationEvent(fullName: widget.defaultLocation)),
      child: BlocConsumer<LocationsBloc, LocationsState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            setState(() {
              location = state.location;
            });
          }
        },
        builder: (context, state) {
          return location != null
              ? InkWell(
                  onTap: () {
                    showClosableDialog(
                        context,
                        LocationPicker(
                          location: location!,
                          bloc: bloc
                            ..add(
                                GetLocationAncestorsEvent(location: location!))
                            ..add(
                                GetLocationChildrenEvent(location: location!)),
                          onChanged: (Location value) {},
                        ),
                        200,
                        300,
                        "");
                  },
                  child: RoundedInputField(
                    value: location!.fullName,
                    width: 600,
                    enabled: false,
                  ),
                )
              : const LoadingIndicator();
        },
      ),
    );
  }
}
