import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String fullName;
  final String shortName;
  final int level;
  final Location? parent;
  List<Location> ancestors = [];
  List<Location> subrings = [];
  List<Location> children = [];

  Location(
      {required this.fullName,
      required this.shortName,
      required this.level,
      this.parent});

  @override
  List<Object?> get props => [fullName];
}
