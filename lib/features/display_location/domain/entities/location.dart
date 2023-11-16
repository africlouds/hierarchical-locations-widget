import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String fullName;
  final String shortName;
  final int level;
  final String? parent;
  List<String> ancestors = [];
  List<String> subrings = [];
  List<String> children = [];

  Location(
      {required this.fullName,
      required this.shortName,
      required this.level,
      this.parent});

  @override
  List<Object?> get props => [fullName];
}
