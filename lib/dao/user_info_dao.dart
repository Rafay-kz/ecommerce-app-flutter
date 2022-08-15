import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserEntity')
  Future<List<UserEntity>> findAllUser();

  @Query('SELECT * FROM UserEntity WHERE id = :id')
  Future<UserEntity?> findUserById(int id);

  @insert
  Future<void> insertUser(UserEntity user);


  @Query('SELECT name,password from UserEntity WHERE name= :name and password=:password')
  Future<UserEntity?> findAllLoginuser(String name, String password);

  @Query('SELECT name from UserEntity WHERE name= :name')
  Future<UserEntity?> findAllUserByuname(String name);


  @Query('SELECT name from UserEntity WHERE name= :name')
  Future<UserEntity?> findUsername(String name);

  @Query('DELETE FROM UserEntity WHERE id=:id')
  Future<int?> deleteById(int id);

  @Query('SELECT id from UserEntity WHERE name= :name')
  Future<UserEntity?> findUserID(String name);


  @update
  Future<void> updateuserdetail(UserEntity userEntity);

  @Query('UPDATE UserEntity SET password= :password WHERE name=:uname')
  Future<UserEntity?> UpdatePasswordByUsername(String password,String uname);

}