import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String fullName;
  final String shortName;
  final int level;
  final String? parent;
  String? type;
  double? latitude, longitude;
  List<String> ancestors = [];
  List<String> subrings = [];
  List<String> children = [];

  Location(
      {required this.fullName,
      required this.shortName,
      required this.level,
      this.latitude,
      this.longitude,
      this.parent});

  @override
  List<Object?> get props => [fullName];
}
