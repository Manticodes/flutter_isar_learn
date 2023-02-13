part of 'isar_bloc.dart';

class IsarState extends Equatable {
  final List<Isar> isarList;
  const IsarState({
    required this.isarList,
  });

  @override
  List<Object> get props => [isarList];
}

class IsarInitial extends IsarState {
  const IsarInitial({required super.isarList});
}
