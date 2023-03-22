import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_dropdown_widget.dart';

class LocationPicker extends StatefulWidget {
  final Location location;
  final LocationsBloc bloc;
  const LocationPicker({super.key, required this.location, required this.bloc});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  void initState() {
    super.initState();
  }

  var locations = <Location>[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<LocationsBloc, LocationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LocationLoaded) {
            return Column(
              children: [
                for (var ancestor in state.location.ancestors)
                  LocationDropdownWidget(
                      location: ancestor,
                      fieldValue: ancestor.shortName,
                      fieldName: '',
                      onChanged: (value) {}),
                LocationDropdownWidget(
                    location: widget.location,
                    fieldValue: widget.location.shortName,
                    fieldName: '',
                    onChanged: (value) {}),
                if (widget.location.children.isNotEmpty)
                  LocationDropdownWidget(
                      location: widget.location,
                      fieldValue: "",
                      showChildren: true,
                      fieldName: '',
                      onChanged: (value) {}),
              ],
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
