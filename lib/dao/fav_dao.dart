import 'package:e_commerce_app/entity/fav_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavDao {
  @Query('SELECT * FROM FavEntity')
  Future<List<FavEntity>> findAllFavProduct();

  @Query('SELECT * FROM FavEntity WHERE id = :id')
  Future<FavEntity?> findFavById(int id);

  @insert
  Future<void> insertInfav(FavEntity favEntity);


  @Query('DELETE FROM FavEntity WHERE product_id = :id AND user_id=:uid')
  Future<void>  DeleteByPId(int id, int uid);


  @Query('DELETE FROM FavEntity WHERE user_id = :id')
  Future<FavEntity?> DeleteByUserId(int id);


  @Query('SELECT * FROM ProductEntity JOIN FavEntity on ProductEntity.id = FavEntity.product_id where user_id=:id')
  Future<List<ProductEntity>> findfavByUserId(int id);


  @update
  Future<void> updateproductfav(FavEntity favEntity);

  @Query('SELECT user_id FROM FavEntity WHERE id = :id')
  Future<int?> findUserById(int id);

  @Query('SELECT * FROM FavEntity WHERE user_id = :id')
  Future<int?> findfavouritebyUid(int id);

  @Query('SELECT * FROM FavEntity WHERE user_id = :id  AND product_id=:pid')
  Future<FavEntity?> findfavouritebyUidPid(int id, int pid);

  @Query('DELETE  FROM FavEntity')
  Future<void> Delete();

  @Query('UPDATE FavEntity SET favourite=1 WHERE product_id=:id AND user_id=:uid')
  Future<FavEntity?> UpdateById(int id, int uid);

  @Query('UPDATE FavEntity SET favourite=0 WHERE product_id=:id AND user_id=:uid')
  Future<FavEntity?> UpdateZeroById(int id,int uid);


  @Query('SELECT favourite FROM FavEntity WHERE product_id = :id')
  Future<int?> findfavByPId(int id);


}