
import 'dart:async';
import 'package:e_commerce_app/dao/cart_dao.dart';
import 'package:e_commerce_app/dao/fav_dao.dart';
import 'package:e_commerce_app/dao/product_dao.dart';
import 'package:e_commerce_app/dao/user_info_dao.dart';
import 'package:e_commerce_app/entity/cart_entity.dart';
import 'package:e_commerce_app/entity/fav_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/category_dao.dart';
import '../entity/category.dart';


part 'database.g.dart';// the generated code will be there

@Database(version: 1, entities: [ProductEntity, CategoryEntity, UserEntity, CartEntity, FavEntity])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  CategoryDao get categoryDao;
  UserDao get userDao;
  CartDao get cartDao;
  FavDao get favDao;





}