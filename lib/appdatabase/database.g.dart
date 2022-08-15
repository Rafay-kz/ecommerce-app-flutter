// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  CategoryDao? _categoryDaoInstance;

  UserDao? _userDaoInstance;

  CartDao? _cartDaoInstance;

  FavDao? _favDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT NOT NULL, `dis` INTEGER NOT NULL, `price` INTEGER NOT NULL, `favpro` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CategoryEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `password` TEXT, `email` TEXT, `fname` TEXT, `phno` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `product_id` INTEGER, `user_id` INTEGER, `p_quantity` INTEGER, FOREIGN KEY (`product_id`) REFERENCES `ProductEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`user_id`) REFERENCES `UserEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `product_id` INTEGER, `user_id` INTEGER, `favourite` INTEGER, FOREIGN KEY (`product_id`) REFERENCES `ProductEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`user_id`) REFERENCES `UserEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  FavDao get favDao {
    return _favDaoInstance ??= _$FavDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProductEntity',
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'category': item.category,
                  'image': item.image,
                  'dis': item.dis,
                  'price': item.price,
                  'favpro': item.favpro
                }),
        _productEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'category': item.category,
                  'image': item.image,
                  'dis': item.dis,
                  'price': item.price,
                  'favpro': item.favpro
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  final UpdateAdapter<ProductEntity> _productEntityUpdateAdapter;

  @override
  Future<List<ProductEntity>> findAllProduct() async {
    return _queryAdapter.queryList('SELECT * FROM ProductEntity',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            category: row['category'] as String,
            price: row['price'] as int,
            image: row['image'] as String,
            dis: row['dis'] as int,
            favpro: row['favpro'] as int));
  }

  @override
  Future<ProductEntity?> findProductById(int id) async {
    return _queryAdapter.query('SELECT * FROM ProductEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            category: row['category'] as String,
            price: row['price'] as int,
            image: row['image'] as String,
            dis: row['dis'] as int,
            favpro: row['favpro'] as int),
        arguments: [id]);
  }

  @override
  Future<ProductEntity?> DeleteById(int id) async {
    return _queryAdapter.query('DELETE FROM ProductEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            category: row['category'] as String,
            price: row['price'] as int,
            image: row['image'] as String,
            dis: row['dis'] as int,
            favpro: row['favpro'] as int),
        arguments: [id]);
  }

  @override
  Future<ProductEntity?> UpdateById(int id) async {
    return _queryAdapter.query(
        'UPDATE ProductEntity SET favpro=1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            category: row['category'] as String,
            price: row['price'] as int,
            image: row['image'] as String,
            dis: row['dis'] as int,
            favpro: row['favpro'] as int),
        arguments: [id]);
  }

  @override
  Future<List<ProductEntity>> findProductByCategory(String category) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ProductEntity WHERE category = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            category: row['category'] as String,
            price: row['price'] as int,
            image: row['image'] as String,
            dis: row['dis'] as int,
            favpro: row['favpro'] as int),
        arguments: [category]);
  }

  @override
  Future<void> insertProduct(ProductEntity product) async {
    await _productEntityInsertionAdapter.insert(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateproductfav(ProductEntity productEntity) async {
    await _productEntityUpdateAdapter.update(
        productEntity, OnConflictStrategy.abort);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'CategoryEntity',
            (CategoryEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  @override
  Future<List<CategoryEntity>> findAllCategory() async {
    return _queryAdapter.queryList('SELECT * FROM CategoryEntity',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(id: row['id'] as int?, name: row['name'] as String));
  }

  @override
  Future<CategoryEntity?> findCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM CategoryEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(id: row['id'] as int?, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<CategoryEntity?> DeleteById(int id) async {
    return _queryAdapter.query('DELETE FROM CategoryEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(id: row['id'] as int?, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Stream<List<CategoryEntity>> findAllCategorythroughstream() {
    return _queryAdapter.queryListStream('SELECT * FROM CategoryEntity',
        mapper: (Map<String, Object?> row) =>
            CategoryEntity(id: row['id'] as int?, name: row['name'] as String),
        queryableName: 'CategoryEntity',
        isView: false);
  }

  @override
  Future<void> insertCategory(CategoryEntity category) async {
    await _categoryEntityInsertionAdapter.insert(
        category, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'UserEntity',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password,
                  'email': item.email,
                  'fname': item.fname,
                  'phno': item.phno
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'UserEntity',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password,
                  'email': item.email,
                  'fname': item.fname,
                  'phno': item.phno
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  @override
  Future<List<UserEntity>> findAllUser() async {
    return _queryAdapter.queryList('SELECT * FROM UserEntity',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?));
  }

  @override
  Future<UserEntity?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM UserEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [id]);
  }

  @override
  Future<UserEntity?> findAllLoginuser(String name, String password) async {
    return _queryAdapter.query(
        'SELECT name,password from UserEntity WHERE name= ?1 and password=?2',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [name, password]);
  }

  @override
  Future<UserEntity?> findAllUserByuname(String name) async {
    return _queryAdapter.query('SELECT name from UserEntity WHERE name= ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [name]);
  }

  @override
  Future<UserEntity?> findUsername(String name) async {
    return _queryAdapter.query('SELECT name from UserEntity WHERE name= ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [name]);
  }

  @override
  Future<int?> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM UserEntity WHERE id=?1', arguments: [id]);
  }

  @override
  Future<UserEntity?> findUserID(String name) async {
    return _queryAdapter.query('SELECT id from UserEntity WHERE name= ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [name]);
  }

  @override
  Future<UserEntity?> UpdatePasswordByUsername(
      String password, String uname) async {
    return _queryAdapter.query(
        'UPDATE UserEntity SET password= ?1 WHERE name=?2',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            password: row['password'] as String?,
            email: row['email'] as String?,
            fname: row['fname'] as String?,
            phno: row['phno'] as int?),
        arguments: [password, uname]);
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateuserdetail(UserEntity userEntity) async {
    await _userEntityUpdateAdapter.update(userEntity, OnConflictStrategy.abort);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartEntityInsertionAdapter = InsertionAdapter(
            database,
            'CartEntity',
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'product_id': item.productId,
                  'user_id': item.userId,
                  'p_quantity': item.p_quantity
                },
            changeListener),
        _cartEntityDeletionAdapter = DeletionAdapter(
            database,
            'CartEntity',
            ['id'],
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'product_id': item.productId,
                  'user_id': item.userId,
                  'p_quantity': item.p_quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartEntity> _cartEntityInsertionAdapter;

  final DeletionAdapter<CartEntity> _cartEntityDeletionAdapter;

  @override
  Future<List<CartEntity>> findAllCart() async {
    return _queryAdapter.queryList('SELECT * FROM CartEntity',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?));
  }

  @override
  Stream<List<CartEntity>> findAllCart2() {
    return _queryAdapter.queryListStream('SELECT * FROM CartEntity',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        queryableName: 'CartEntity',
        isView: false);
  }

  @override
  Future<CartEntity?> findCartById(int id) async {
    return _queryAdapter.query('SELECT * FROM CartEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<CartEntity>> findAllCartById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM CartEntity WHERE id=?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<ProductEntity?>> findCartByUserId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ProductEntity JOIN CartEntity on ProductEntity.id = CartEntity.product_id where user_id=?1',
        mapper: (Map<String, Object?> row) => ProductEntity(id: row['id'] as int?, name: row['name'] as String, category: row['category'] as String, price: row['price'] as int, image: row['image'] as String, dis: row['dis'] as int, favpro: row['favpro'] as int),
        arguments: [id]);
  }

  @override
  Future<CartEntity?> DeleteById(int id) async {
    return _queryAdapter.query('DELETE FROM CartEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        arguments: [id]);
  }

  @override
  Future<CartEntity?> DeleteAllByPId(int id) async {
    return _queryAdapter.query('DELETE FROM CartEntity WHERE product_id = ?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        arguments: [id]);
  }

  @override
  Future<int?> findCartByProductId(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT id FROM CartEntity WHERE product_id = ?1',
        arguments: [id]);
  }

  @override
  Future<int?> findTotalProductId(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT count(*) FROM CartEntity WHERE product_id = ?1',
        arguments: [id]);
  }

  @override
  Future<List<CartEntity>> findQuantityByProductId(int id) async {
    return _queryAdapter.queryList(
        'SELECT p_quantity FROM CartEntity WHERE product_id = ?1',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            productId: row['product_id'] as int?,
            userId: row['user_id'] as int?,
            p_quantity: row['p_quantity'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertInCart(CartEntity cartEntity) async {
    await _cartEntityInsertionAdapter.insert(
        cartEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteProduct(List<CartEntity> cartentity) {
    return _cartEntityDeletionAdapter
        .deleteListAndReturnChangedRows(cartentity);
  }
}

class _$FavDao extends FavDao {
  _$FavDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favEntityInsertionAdapter = InsertionAdapter(
            database,
            'FavEntity',
            (FavEntity item) => <String, Object?>{
                  'id': item.id,
                  'product_id': item.product_id,
                  'user_id': item.user_id,
                  'favourite': item.favourite
                }),
        _favEntityUpdateAdapter = UpdateAdapter(
            database,
            'FavEntity',
            ['id'],
            (FavEntity item) => <String, Object?>{
                  'id': item.id,
                  'product_id': item.product_id,
                  'user_id': item.user_id,
                  'favourite': item.favourite
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavEntity> _favEntityInsertionAdapter;

  final UpdateAdapter<FavEntity> _favEntityUpdateAdapter;

  @override
  Future<List<FavEntity>> findAllFavProduct() async {
    return _queryAdapter.queryList('SELECT * FROM FavEntity',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?));
  }

  @override
  Future<FavEntity?> findFavById(int id) async {
    return _queryAdapter.query('SELECT * FROM FavEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> DeleteByPId(int id, int uid) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM FavEntity WHERE product_id = ?1 AND user_id=?2',
        arguments: [id, uid]);
  }

  @override
  Future<FavEntity?> DeleteByUserId(int id) async {
    return _queryAdapter.query('DELETE FROM FavEntity WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<ProductEntity>> findfavByUserId(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ProductEntity JOIN FavEntity on ProductEntity.id = FavEntity.product_id where user_id=?1',
        mapper: (Map<String, Object?> row) => ProductEntity(id: row['id'] as int?, name: row['name'] as String, category: row['category'] as String, price: row['price'] as int, image: row['image'] as String, dis: row['dis'] as int, favpro: row['favpro'] as int),
        arguments: [id]);
  }

  @override
  Future<int?> findUserById(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT user_id FROM FavEntity WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int?> findfavouritebyUid(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT * FROM FavEntity WHERE user_id = ?1',
        arguments: [id]);
  }

  @override
  Future<FavEntity?> findfavouritebyUidPid(int id, int pid) async {
    return _queryAdapter.query(
        'SELECT * FROM FavEntity WHERE user_id = ?1  AND product_id=?2',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?),
        arguments: [id, pid]);
  }

  @override
  Future<void> Delete() async {
    await _queryAdapter.queryNoReturn('DELETE  FROM FavEntity');
  }

  @override
  Future<FavEntity?> UpdateById(int id, int uid) async {
    return _queryAdapter.query(
        'UPDATE FavEntity SET favourite=1 WHERE product_id=?1 AND user_id=?2',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?),
        arguments: [id, uid]);
  }

  @override
  Future<FavEntity?> UpdateZeroById(int id, int uid) async {
    return _queryAdapter.query(
        'UPDATE FavEntity SET favourite=0 WHERE product_id=?1 AND user_id=?2',
        mapper: (Map<String, Object?> row) => FavEntity(
            id: row['id'] as int?,
            product_id: row['product_id'] as int?,
            user_id: row['user_id'] as int?,
            favourite: row['favourite'] as int?),
        arguments: [id, uid]);
  }

  @override
  Future<int?> findfavByPId(int id) async {
    await _queryAdapter.queryNoReturn(
        'SELECT favourite FROM FavEntity WHERE product_id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertInfav(FavEntity favEntity) async {
    await _favEntityInsertionAdapter.insert(
        favEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateproductfav(FavEntity favEntity) async {
    await _favEntityUpdateAdapter.update(favEntity, OnConflictStrategy.abort);
  }
}
