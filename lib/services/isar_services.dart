import 'package:isar/isar.dart';

import '../collections/category.dart';
import '../collections/routine.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices() {
    db = openDB();
  }

  Future<void> addRoutine(Routine routine) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.routines.putSync(routine));
    await routine.category.save();
  }

  Future<void> addCategory(Category category) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.categorys.putSync(category));
  }

  Future<List<Category>> getCategories() async {
    final isar = await db;
    return await isar.categorys.where().findAll();
  }

  Future<List<Routine>> getRoutines() async {
    final isar = await db;
    Future.value();

    return await isar.routines.where().findAll();
  }

  Future<void> cleanDB() async {
    final isar = await db;
    await isar.writeTxnSync(() => isar.clear());
  }

  Future<void> updateRoutine(Routine routine) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.routines.putSync(routine));
    await routine.category.save();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([RoutineSchema, CategorySchema]);
    } else {
      return Future.value(Isar.getInstance());
    }
  }
}
