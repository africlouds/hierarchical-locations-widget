import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_dropdown_widget.dart';
import 'package:logger/logger.dart';

class LocationPicker extends StatefulWidget {
  final Location location;
  final ValueChanged<Location> onChanged;

  const LocationPicker(
      {super.key, required this.location, required this.onChanged});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  void initState() {
    BlocProvider.of<LocationsBloc>(context)
      ..add(GetLocationAncestorsEvent(location: widget.location))
      ..add(GetLocationChildrenEvent(location: widget.location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          Logger().d(state.location.fullName);
          widget.onChanged(state.location);
        }
      },
      builder: (context, state) {
        if (state is LocationLoaded) {
          return Column(
            children: [
              for (var ancestor in state.location.ancestors)
                LocationDropdownWidget(
                    location: ancestor,
                    fieldValue: ancestor.shortName,
                    fieldName: '',
                    onChanged: (value) {
                      BlocProvider.of<LocationsBloc>(context)
                          .add(LoadLocationEvent(fullName: value.fullName));
                    }),
              LocationDropdownWidget(
                  location: widget.location,
                  fieldValue: widget.location.shortName,
                  fieldName: '',
                  onChanged: (value) {
                    BlocProvider.of<LocationsBloc>(context)
                        .add(LoadLocationEvent(fullName: value.fullName));
                  }),
              if (widget.location.children.isNotEmpty)
                LocationDropdownWidget(
                    location: widget.location,
                    fieldValue: "",
                    showChildren: true,
                    fieldName: '',
                    onChanged: (value) {
                      BlocProvider.of<LocationsBloc>(context)
                          .add(LoadLocationEvent(fullName: value.fullName));
                    }),
            ],
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
