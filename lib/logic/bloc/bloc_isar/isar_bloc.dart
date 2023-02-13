import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'isar_event.dart';
part 'isar_state.dart';

class IsarBloc extends Bloc<IsarEvent, IsarState> {
  IsarBloc() : super(const IsarState(isarList: <Isar>[])) {
    on<AddIsar>(_onAddIsar);
  }

  void _onAddIsar(AddIsar event, Emitter<IsarState> emit) async {
    List<Isar> listofIsar = state.isarList;
    Isar firstIsar = event.isar;
    listofIsar[0] = firstIsar;

    emit(IsarState(isarList: listofIsar));
  }
}
