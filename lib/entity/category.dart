import 'package:floor/floor.dart';

@entity
class CategoryEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  CategoryEntity({this.id,required this.name});
}