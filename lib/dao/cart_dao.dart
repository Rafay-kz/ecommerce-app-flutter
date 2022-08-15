import 'package:e_commerce_app/entity/cart_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:floor/floor.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM CartEntity')
  Future<List<CartEntity>> findAllCart();

  @Query('SELECT * FROM CartEntity')
  Stream<List<CartEntity>> findAllCart2();


  @Query('SELECT * FROM CartEntity WHERE id = :id')
  Future<CartEntity?> findCartById(int id);

  @insert
  Future<void> insertInCart(CartEntity cartEntity);

  @Query('SELECT * FROM CartEntity WHERE id=:id')
  Future<List<CartEntity>> findAllCartById(int id);



  @Query('SELECT * FROM ProductEntity JOIN CartEntity on ProductEntity.id = CartEntity.product_id where user_id=:id')
  Future<List<ProductEntity?>> findCartByUserId(int id);

  @Query('DELETE FROM CartEntity WHERE id = :id')
  Future<CartEntity?> DeleteById(int id);


  @Query('DELETE FROM CartEntity WHERE product_id = :id')
  Future<CartEntity?> DeleteAllByPId(int id);


  @delete
  Future<int> deleteProduct(List<CartEntity> cartentity);

  @Query('SELECT id FROM CartEntity WHERE product_id = :id')
  Future<int?> findCartByProductId(int id);


  @Query('SELECT count(*) FROM CartEntity WHERE product_id = :id')
  Future<int?> findTotalProductId(int id);


  @Query('SELECT p_quantity FROM CartEntity WHERE product_id = :id')
  Future<List<CartEntity>> findQuantityByProductId(int id);















}