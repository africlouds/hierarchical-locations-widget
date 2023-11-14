import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/constants.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/text_field_container.dart';
import 'package:logger/logger.dart';

class LocationDropdownWidget extends StatefulWidget {
  final String? fieldLabel;
  final String fieldName;
  final String? fieldValue;
  final Location location;
  final ValueChanged<Location> onChanged;

  final double? width;
  final bool enabled;
  bool showChildren;

  LocationDropdownWidget(
      {Key? key,
      this.fieldLabel,
      required this.location,
      required this.fieldName,
      required this.onChanged,
      this.fieldValue,
      this.enabled = true,
      this.showChildren = false,
      this.width})
      : super(key: key);

  @override
  State<LocationDropdownWidget> createState() => _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState extends State<LocationDropdownWidget> {
  late Location location;
  late Location selectedLocation;
  @override
  void initState() {
    location = widget.location;
    selectedLocation = widget.location;
    BlocProvider.of<LocationsBloc>(context)
        .add(GetLocationSubringsEvent(location: location));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          Logger().d("KKKKKKK");
          if (state.location == selectedLocation) {
            setState(() {
              location = state.location;
            });
          }
        }
        ;
      },
      builder: (context, state) {
        var locations =
            widget.showChildren ? location.subrings : location.subrings;
        return SizedBox(
          width: widget.width,
          child: InkWell(
            onTap: () {},
            child: TextFieldContainer(
              label: widget.fieldLabel,
              backgroundColor: widget.enabled ? editableColor : bgColor,
              child: DropdownButton<Location>(
                  underline: const SizedBox(),
                  hint: widget.showChildren
                      ? null
                      : Text(
                          location.shortName,
                          style: const TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.black),
                  items: locations.toList().map(
                    (val) {
                      return DropdownMenuItem<Location>(
                        value: val,
                        child: Text(val.shortName.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (location) {
                    Logger().d(location);
                    /*
                    BlocProvider.of<LocationsBloc>(context)
                        .add(GetLocationAncestorsEvent(location: location!));
                    BlocProvider.of<LocationsBloc>(context)
                        .add(GetLocationChildrenEvent(location: location));
                    */
                    widget.onChanged(location!);
                  }),
            ),
          ),
        );
      },
    );
  }
}
