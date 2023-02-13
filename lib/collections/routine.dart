import 'package:equatable/equatable.dart';
import 'package:flutter_isar_learn/collections/category.dart';
import 'package:isar/isar.dart';
part 'routine.g.dart';

@Collection()
class Routine extends Equatable {
  Id id = Isar.autoIncrement;
  late String title;
  @Index(composite: [CompositeIndex('title')])
  final category = IsarLink<Category>();
  @Index()
  late String startTime;
  @Index(caseSensitive: false)
  late String day;

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, category, day];
}
