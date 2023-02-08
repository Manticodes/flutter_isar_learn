import 'package:isar/isar.dart';

@Collection()
class Routine {
  int id = Isar.autoIncrement;
  late String title;
  @Index(composite: [CompositeIndex('title')])
  late String category;
  @Index()
  late DateTime startTime;
  @Index(caseSensitive: false)
  late String day;
}
