import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/core/presentation/utils.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_picker.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/rounded_input_field.dart';

class LocationWidget extends StatefulWidget {
  //nice
  final String defaultLocation;
  const LocationWidget({super.key, required this.defaultLocation});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Location? location;
  @override
  void initState() {
    BlocProvider.of<LocationsBloc>(context)
        .add(LoadLocationEvent(fullName: widget.defaultLocation));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
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
    );
  }
}
