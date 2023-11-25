import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/core/presentation/utils.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_picker.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/rounded_input_field.dart';

class LocationWidget extends StatefulWidget {
  //nice
  final String defaultLocation;
  ValueChanged<String> locationChanged;
  LocationWidget(
      {super.key,
      required this.defaultLocation,
      required this.locationChanged});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showClosableDialog(
            context,
            LocationPicker(
              locationName: widget.defaultLocation,
              onChanged: (Location value) {
                widget.locationChanged(value.fullName);
              },
            ),
            250,
            400,
            "");
      },
      child: RoundedInputField(
        value: widget.defaultLocation,
        width: 600,
        enabled: false,
      ),
    );
  }
}
