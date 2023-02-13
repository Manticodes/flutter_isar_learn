part of 'isar_bloc.dart';

abstract class IsarEvent extends Equatable {
  const IsarEvent();

  @override
  List<Object> get props => [];
}

class AddIsar extends IsarEvent {
  final Isar isar;

  const AddIsar({required this.isar});
  @override
  List<Object> get props => [isar];
}
