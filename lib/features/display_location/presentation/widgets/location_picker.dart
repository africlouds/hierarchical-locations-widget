import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_dropdown_widget.dart';
import 'package:logger/logger.dart';

import 'text_field_container.dart';

class LocationPicker extends StatefulWidget {
  final String locationName;
  final ValueChanged<Location> onChanged;

  const LocationPicker(
      {super.key, required this.locationName, required this.onChanged});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Location? location;
  @override
  void initState() {
    BlocProvider.of<LocationsBloc>(context)
        .add(GetLocationEvent(fullName: widget.locationName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state is GetLocationSuccessful) {
          setState(() {
            location = state.location;
          });
          widget.onChanged(state.location);
        }
      },
      builder: (context, state) {
        if (location != null) Logger().d(location!.children);
        return location == null
            ? const LoadingIndicator()
            : Column(
                children: [
                  for (var ancestor in location!.ancestors)
                    LocationDropdownWidget(
                        location: ancestor,
                        fieldValue: ancestor,
                        fieldName: '',
                        onChanged: (value) {
                          setState(() {
                            location = value;
                          });
                          widget.onChanged(value);
                          BlocProvider.of<LocationsBloc>(context)
                              .add(GetLocationEvent(fullName: value.fullName));
                        }),
                  LocationDropdownWidget(
                      location: location!.fullName,
                      fieldValue: location!.fullName,
                      fieldName: '',
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                        widget.onChanged(value);
                        BlocProvider.of<LocationsBloc>(context)
                            .add(GetLocationEvent(fullName: value.fullName));
                      }),
                  if (location!.children.isNotEmpty)
                    InkWell(
                      onTap: () {},
                      child: TextFieldContainer(
                        label: 'Village',
                        child: DropdownButton<String>(
                            underline: const SizedBox(),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: const TextStyle(color: Colors.black),
                            items: location!.children.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString().split("/").last),
                                );
                              },
                            ).toList(),
                            onChanged: (value) async {
                              BlocProvider.of<LocationsBloc>(context)
                                  .add(GetLocationEvent(fullName: value!));
                            }),
                      ),
                    )
                ],
              );
      },
    );
  }
}
