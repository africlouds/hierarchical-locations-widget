import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
