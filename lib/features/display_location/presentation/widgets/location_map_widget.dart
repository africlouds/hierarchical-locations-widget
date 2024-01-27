import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/location.dart';
import '../bloc/locations_bloc.dart';

class LocationMapWidget extends StatefulWidget {
  const LocationMapWidget(
      {super.key,
      required this.markers,
      required this.width,
      required this.height,
      required this.location});
  final List<Marker> markers;
  final double width, height;
  final String location;

  @override
  State<LocationMapWidget> createState() => _LocationMapWidgetState();
}

class _LocationMapWidgetState extends State<LocationMapWidget> {
  List<Marker> markers = [];
  bool editMode = false;
  LatLng? selectedPoint;

  Location? location;
  MapController mapController = MapController();
  @override
  void initState() {
    BlocProvider.of<LocationsBloc>(context)
        .add(GetLocationEvent(fullName: widget.location));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationsBloc, LocationsState>(
      listener: (context, state) {
        if (state is GetLocationSuccessful) {
          setState(() {
            location = state.location;
            if (location != null &&
                location!.latitude != null &&
                location!.longitude != null) {
              var point = LatLng(location!.latitude!, location!.longitude!);
              markers = [];
              markers.add((Marker(
                width: 80.0,
                height: 80.0,
                point: point,
                builder: (ctx) => IconButton(
                  icon: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location!.shortName,
                                  style: const TextStyle(fontSize: 26),
                                ),
                                Text("${location!.type}"),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text("${location!.parent}")
                              ],
                            ),
                          ));
                        });
                  },
                ),
              )));
              mapController.move(point, 14);
            }
          });
        }
        if (state is UpdateLocationCoordinatesSuccessful) {
          setState(() {
            location = state.location;
            if (location != null &&
                location!.latitude != null &&
                location!.longitude != null) {
              var point = LatLng(location!.latitude!, location!.longitude!);
              markers = [];
              markers.add((Marker(
                width: 80.0,
                height: 80.0,
                point: point,
                builder: (ctx) => IconButton(
                  icon: const Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location!.shortName,
                                  style: const TextStyle(fontSize: 26),
                                ),
                                Text("${location!.type}"),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text("${location!.parent}")
                              ],
                            ),
                          ));
                        });
                  },
                ),
              )));
              mapController.move(point, 14);
            }
          });
        }
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                maxZoom: 15,
                minZoom: 9,
                center: markers.isNotEmpty
                    ? markers[0].point
                    : const LatLng(-1.9859123887827823, 29.92491208595452),
                zoom: 9.5,
                onTap: (tapPosition, point) {
                  Logger().d(tapPosition);
                  Logger().d(point);
                  setState(() {
                    selectedPoint = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markers)
              ],
            ),
            Positioned(
                top: 20,
                right: 20,
                child: Column(
                  children: [
                    if (location != null && !editMode)
                      ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              editMode = true;
                            });
                          },
                          icon: const Icon(Icons.edit),
                          label:
                              Text("Edit location for ${location!.shortName}")),
                    if (editMode)
                      selectedPoint != null
                          ? Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Latitude: ${selectedPoint!.latitude}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Longitude: ${selectedPoint!.longitude}"),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (selectedPoint != null)
                                        BlocProvider.of<LocationsBloc>(context)
                                            .add(UpdateLocationCoordinatesEvent(
                                                location: location!.fullName,
                                                latitude:
                                                    selectedPoint!.latitude,
                                                longitude:
                                                    selectedPoint!.longitude));
                                      setState(() {
                                        editMode = false;
                                      });
                                    },
                                    icon: const Icon(Icons.save),
                                    label: const Text("Save"),
                                  )
                                ],
                              ),
                            )
                          : const Text("Click on the map to select a location")
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
