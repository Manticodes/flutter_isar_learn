import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_learn/collections/category.dart';
import 'package:flutter_isar_learn/services/isar_services.dart';

import '../../collections/routine.dart';

part 'isar_bloc_event.dart';
part 'isar_bloc_state.dart';

class IsarBlocBloc extends Bloc<IsarBlocEvent, IsarBlocState> {
  IsarBlocBloc()
      : super(const IsarBlocInitial(
            allCategories: <Category>[], allRoutines: <Routine>[])) {
    on<AddRoutine>(_onAddRoutine);
    on<LoadRoutine>(_onLoadRoutine);
  }

  FutureOr<void> _onAddRoutine(
      AddRoutine event, Emitter<IsarBlocState> emit) async {
    IsarServices().addRoutine(event.routine);
    List<Routine> allRoutes = await IsarServices().getRoutines();
    List<Category> allCat = await IsarServices().getCategories();

    emit(IsarBlocState(allCategories: allCat, allRoutines: allRoutes));
  }

  FutureOr<void> _onLoadRoutine(
      LoadRoutine event, Emitter<IsarBlocState> emit) async {
    List<Routine> allRoutes = await IsarServices().getRoutines();
    List<Category> allCat = await IsarServices().getCategories();
    emit(IsarBlocState(allCategories: allCat, allRoutines: allRoutes));
  }
}
