import 'package:isar/isar.dart';

import '../collections/category.dart';
import '../collections/routine.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices() {
    db = openDB();
  }

//! 1
  Future<void> addRoutine(Routine routine) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.routines.putSync(routine));
    await routine.category.save();
  }

//! 2
  Future<void> removeRoutine(Routine routine) async {
    final isar = await db;
    await isar.writeTxn(() => isar.routines.delete(routine.id));
  }

//! 3
  Future<void> addCategory(Category category) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.categorys.putSync(category));
  }

//! 4
  Future<void> removeCategory(Category category) async {
    final isar = await db;
    await isar.writeTxn(() => isar.routines.delete(category.id));
  }

//! 5
  Future<List<Category>> getCategories() async {
    final isar = await db;
    return await isar.categorys.where().findAll();
  }

//! 6
  Future<List<Routine>> getRoutines() async {
    final isar = await db;
    Future.value();

    return await isar.routines.where().findAll();
  }

//!7
  Future<void> cleanRoutineDB() async {
    final isar = await db;
    isar.writeTxnSync(() => isar.routines.clearSync());
  }

//! 8
  Future<void> updateRoutine(Routine routine) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.routines.putSync(routine));
    await routine.category.save();
  }

//! 9
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([RoutineSchema, CategorySchema]);
    } else {
      return Future.value(Isar.getInstance());
    }
  }

  //! 10
  Future<void> cleanCategoryDB() async {
    final isar = await db;
    isar.writeTxnSync(() => isar.categorys.clearSync());
  }
}
