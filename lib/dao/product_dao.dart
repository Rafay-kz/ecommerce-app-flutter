import 'package:e_commerce_app/entity/category.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM ProductEntity')
  Future<List<ProductEntity>> findAllProduct();

  @Query('SELECT * FROM ProductEntity WHERE id = :id')
  Future<ProductEntity?> findProductById(int id);


  @insert
  Future<void> insertProduct(ProductEntity product);

  @Query('DELETE FROM ProductEntity WHERE id = :id')
  Future<ProductEntity?> DeleteById(int id);

  @Query('UPDATE ProductEntity SET favpro=1 WHERE id = :id')
  Future<ProductEntity?> UpdateById(int id);


  @update
  Future<void> updateproductfav(ProductEntity productEntity);


  @Query('SELECT * FROM ProductEntity WHERE category = :category')
  Future<List<ProductEntity>> findProductByCategory(String category);







}