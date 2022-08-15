import 'package:floor/floor.dart';

@entity
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String? name, password, email,fname;
  final int? phno;

  UserEntity({this.id,required this.name, required this.password,required this.email, required this.fname, required this.phno});
}