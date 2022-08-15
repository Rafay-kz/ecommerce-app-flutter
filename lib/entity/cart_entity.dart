import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'CartEntity',
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
class CartEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'product_id')
   int? productId;

  @ColumnInfo(name: 'user_id')
   int? userId;

  @ColumnInfo(name: 'p_quantity')
   int? p_quantity;


  CartEntity({this.id,required this.productId,required this.userId,required this.p_quantity});
}