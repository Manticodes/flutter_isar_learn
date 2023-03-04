part of 'isar_bloc_bloc.dart';

@immutable
class IsarBlocState extends Equatable {
  final List<Category> allCategories;
  final List<Routine> allRoutines;

  const IsarBlocState({
    required this.allCategories,
    required this.allRoutines,
  });

  @override
  List<Object?> get props => [
        allCategories,
        allRoutines,
      ];
}

class IsarBlocInitial extends IsarBlocState {
  const IsarBlocInitial(
      {required super.allCategories, required super.allRoutines});
}
