import 'package:e_commerce_app/entity/category.dart';
import 'package:floor/floor.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM CategoryEntity')
  Future<List<CategoryEntity>> findAllCategory();

  @Query('SELECT * FROM CategoryEntity WHERE id = :id')
  Future<CategoryEntity?> findCategoryById(int id);

  @insert
  Future<void> insertCategory(CategoryEntity category);


  @Query('DELETE FROM CategoryEntity WHERE id = :id')
  Future<CategoryEntity?> DeleteById(int id);

  @Query('SELECT * FROM CategoryEntity')
  Stream<List<CategoryEntity>> findAllCategorythroughstream();


}