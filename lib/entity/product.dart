import 'package:floor/floor.dart';

@entity
class ProductEntity {
  @PrimaryKey(autoGenerate: true)
   int? id;

  final String name,category, image;
  int dis,price;
  int favpro;

  ProductEntity({this.id,required this.name, required this.category, required this.price, required this.image, required this.dis,required this.favpro});
}