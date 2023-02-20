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
    on<LoadDB>(_onLoadRoutine);
    on<DeleteRoutine>(_onDeleteRoutine);
    on<UpdateRoutine>(_onUpdateRoutine);
    on<AddCategory>(_onAddCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<ClearDB>(_onClearDB);
  }

  FutureOr<void> _onAddRoutine(
      AddRoutine event, Emitter<IsarBlocState> emit) async {
    IsarServices().addRoutine(event.routine);
    await loadAndEmit(emit);
  }

  FutureOr<void> _onLoadRoutine(
      LoadDB event, Emitter<IsarBlocState> emit) async {
    await loadAndEmit(emit);
  }

  FutureOr<void> _onDeleteRoutine(
      DeleteRoutine event, Emitter<IsarBlocState> emit) async {
    IsarServices().removeRoutine(event.routine);
    await loadAndEmit(emit);
  }

  FutureOr<void> _onUpdateRoutine(
      UpdateRoutine event, Emitter<IsarBlocState> emit) async {
    IsarServices().updateRoutine(event.routine);
    await loadAndEmit(emit);
  }

  FutureOr<void> _onAddCategory(
      AddCategory event, Emitter<IsarBlocState> emit) async {
    IsarServices().addCategory(event.category);
    await loadAndEmit(emit);
  }

  FutureOr<void> _onDeleteCategory(
      DeleteCategory event, Emitter<IsarBlocState> emit) async {
    IsarServices().removeCategory(event.category);
    await loadAndEmit(emit);
  }

  FutureOr<void> loadAndEmit(Emitter<IsarBlocState> emit) async {
    List<Routine> allRoutes = await IsarServices().getRoutines();
    List<Category> allCat = await IsarServices().getCategories();

    emit(IsarBlocState(allCategories: allCat, allRoutines: allRoutes));
  }

  FutureOr<void> _onClearDB(ClearDB event, Emitter<IsarBlocState> emit) async {
    IsarServices().cleanDB();
    await loadAndEmit(emit);
  }
}
