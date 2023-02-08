import 'package:flutter_isar_learn/collections/category.dart';
import 'package:isar/isar.dart';

@Collection()
class Routine {
  int id = Isar.autoIncrement;
  late String title;
  @Index(composite: [CompositeIndex('title')])
  final category = IsarLink<Category>();
  @Index()
  late DateTime startTime;
  @Index(caseSensitive: false)
  late String day;
}
