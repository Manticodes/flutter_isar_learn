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

class LoadDB extends IsarBlocEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateRoutine extends IsarBlocEvent {
  final Routine routine;
  const UpdateRoutine({
    required this.routine,
  });
  @override
  List<Object> get props => [routine];
}

class DeleteRoutine extends IsarBlocEvent {
  final Routine routine;
  const DeleteRoutine({
    required this.routine,
  });
  @override
  List<Object> get props => [routine];
}

class ClearRoutineDB extends IsarBlocEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClearCategoryDB extends IsarBlocEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCategory extends IsarBlocEvent {
  final Category category;
  const DeleteCategory({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}

class AddCategory extends IsarBlocEvent {
  final Category category;
  const AddCategory({
    required this.category,
  });
  @override
  List<Object> get props => [category];
}
