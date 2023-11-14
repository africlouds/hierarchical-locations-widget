import 'package:flutter/material.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/location_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hierarchical Location Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hierarchical Location Widget",
              style: TextStyle(fontSize: 18),
            ),
          ),
          LocationWidget(
              defaultLocation:
                  "Rwanda/CITY OF KIGALI/Kicukiro/Nyarugunga/Kamashashi/Mulindi"),
        ],
      )),
    );
  }
}
