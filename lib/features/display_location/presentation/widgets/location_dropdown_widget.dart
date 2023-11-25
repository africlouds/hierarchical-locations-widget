import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/constants.dart';
import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/bloc/locations_bloc.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/loading_indicator.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/text_field_container.dart';
import 'package:logger/logger.dart';

class LocationDropdownWidget extends StatefulWidget {
  final String? fieldLabel;
  final String fieldName;
  final String? fieldValue;
  final String location;
  final ValueChanged<Location> onChanged;
  final String mode;

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
      this.mode = 'Subrings',
      this.enabled = true,
      this.showChildren = false,
      this.width})
      : super(key: key);

  @override
  State<LocationDropdownWidget> createState() => _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState extends State<LocationDropdownWidget> {
  Location? location;
  Location? selectedLocation;
  @override
  void initState() {
    getLocation(widget.location);
    BlocProvider.of<LocationsBloc>(context)
        .add(GetLocationEvent(fullName: widget.location));
    // TODO: implement initState
    super.initState();
  }

  void getLocation(String name) async {
    var locationObj =
        await BlocProvider.of<LocationsBloc>(context).getLocationSync(name);
    setState(() {
      location = locationObj;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state is LocationLoaded &&
            state.location.fullName != widget.location) {
          //    Logger().d(state.location.fullName);
          //   Logger().d(widget.location);
        }
        if (state is LocationLoaded &&
            state.location.fullName == widget.location) {
          setState(() {
            location = state.location;
            selectedLocation = location;
          });
        }
        ;
      },
      builder: (context, state) {
        var options = [];
        if (location != null) {
          if (widget.mode == 'Subrings') {
            options = location!.subrings;
          } else {
            options = location!.children;
          }
        }
        return selectedLocation == null
            ? const LoadingIndicator()
            : SizedBox(
                width: widget.width,
                child: InkWell(
                  onTap: () {},
                  child: TextFieldContainer(
                    label: widget.fieldLabel,
                    backgroundColor: widget.enabled ? editableColor : bgColor,
                    child: DropdownButton<String>(
                        underline: const SizedBox(),
                        hint: widget.showChildren
                            ? null
                            : Text(
                                location!.shortName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black),
                        items: options.toList().map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val.toString().split("/").last),
                            );
                          },
                        ).toList(),
                        onChanged: (location) async {
                          /*
                    BlocProvider.of<LocationsBloc>(context)
                        .add(GetLocationAncestorsEvent(location: location!));
                    BlocProvider.of<LocationsBloc>(context)
                        .add(GetLocationChildrenEvent(location: location));
                    */
                          var locationObj =
                              await BlocProvider.of<LocationsBloc>(context)
                                  .getLocationSync(location!);
                          widget.onChanged(locationObj!);
                        }),
                  ),
                ),
              );
      },
    );
  }
}
