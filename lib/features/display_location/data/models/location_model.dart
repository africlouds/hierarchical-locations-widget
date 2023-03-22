import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(
      {required super.fullName,
      required super.shortName,
      required super.level,
      super.parent});
  factory LocationModel.fromString(String fullName) {
    var fullNameArray = fullName.split("/");
    var shortName = fullNameArray.last;
    int level = fullNameArray.length;
    String? parentName = fullNameArray.length > 1
        ? fullNameArray.sublist(0, fullNameArray.length - 1).join("/")
        : null;
    final parent =
        parentName != null ? LocationModel.fromString(parentName) : null;

    var location = LocationModel(
        fullName: fullName, shortName: shortName, level: level, parent: parent);
    return location;
  }

  @override
  List<Object?> get props => [fullName];
}
