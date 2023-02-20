part of 'isar_bloc_bloc.dart';

@immutable
abstract class IsarBlocEvent extends Equatable {
  const IsarBlocEvent();
}

class AddRoutine extends IsarBlocEvent {
  final Routine routine;
  const AddRoutine({
    required this.routine,
  });
  @override
  List<Object> get props => [routine];
}

class LoadRoutine extends IsarBlocEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
