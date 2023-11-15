import 'package:hierarchical_locations_widget/features/display_location/domain/entities/location.dart';
import 'package:logger/logger.dart';

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

    var location = LocationModel(
        fullName: fullName,
        shortName: shortName,
        level: level,
        parent: parentName);

    return location;
  }

  factory LocationModel.fromJson(Map json) {
    var location = LocationModel(
        fullName: json['full_name'],
        shortName: json['short_name'],
        level: json['level'],
        parent: json['parent']);
    Logger().d(json['ancestors']);
    location.ancestors = json['ancestors'] as List<String>;
    return location;
  }
  Map<String, dynamic> toJson() {
    var location = {
      'full_name': fullName,
      'short_name': shortName,
      'level': level,
      'parent': parent,
      'ancestors': ancestors
    };
    return location;
  }

  @override
  List<Object?> get props => [fullName];
}
