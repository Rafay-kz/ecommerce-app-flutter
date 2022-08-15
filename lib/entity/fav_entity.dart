import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'FavEntity',
  foreignKeys: [
    ForeignKey(
      childColumns: ['product_id'],
      parentColumns: ['id'],
      entity: ProductEntity,
    ),
    ForeignKey(
      childColumns: ['user_id'],
      parentColumns: ['id'],
      entity: UserEntity,
    ),

  ],
)
class FavEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'product_id')
  final int? product_id;

  @ColumnInfo(name: 'user_id')
  final int? user_id;

  @ColumnInfo(name: 'favourite')
  final int? favourite;

  FavEntity({this.id,required this.product_id,required this.user_id,required this.favourite});
}