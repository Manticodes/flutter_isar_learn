// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
part 'category.g.dart';

@Collection()
class Category extends Equatable {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String name;

  @override
  List<Object?> get props => [id, name];
}
