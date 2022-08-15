import 'package:badges/badges.dart';
import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/dao/product_dao.dart';
import 'package:e_commerce_app/entity/cart_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/screens/users/checkout_screen.dart';
import 'package:flutter/material.dart';

class ProductDetail2 extends StatefulWidget {
  const ProductDetail2(
      {Key? key,
      required this.name,
      required this.price,
      required this.category,
      required this.image,
      required this.discount,
      required this.userId,
      required this.productId})
      : super(key: key);
  final String name, price, category, image, discount;
  final int? userId, productId;

  @override
  State<ProductDetail2> createState() => _ProductDetail2();
}

class _ProductDetail2 extends State<ProductDetail2>
    with SingleTickerProviderStateMixin {
  _ProductDetail2();
  int _counter = 0;
  bool showRaisedButtonBadge = true;
  int myCounter = 0;
  double? disPrice;
  int c=0;
  int funCounter=0;
  AppDatabase? database;
  ProductDao? productDao;
  Future<List<ProductEntity?>> products() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final result = await database?.cartDao.findCartByUserId(widget.userId!);
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Product detail',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            _shoppingCartBadge2(),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              _productImage(),
              _productDetail(),
              _addRemoveCartButtons(),
              _productDescription()
            ],
          ),
        ),
      ),
    );
  }

  Widget _shoppingCartBadge2() {

    return FutureBuilder(
      future: products(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final productList = snapshot.data as List<ProductEntity?>;
          if (productList.isNotEmpty || productList.isEmpty) {
            return Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                productList.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCheckoutDb(
                            userId: widget.userId,
                            productId: 1,
                          ),
                        ),
                      );
                    });
                  }
              ),

            );

          } else {
            return const Text('0');
          }
        } else {
          return const Text('0');
        }
      },
    );
  }

  Widget _productImage() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: 400,
        child: Image.asset(widget.image, height: 230, fit: BoxFit.cover),
      ),
    );
  }

  Widget _addRemoveCartButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
            onPressed: () {
              setState(() {
                _counter++;
                myCounter=_counter;

              });
            },
            icon: const Icon(Icons.add),
            label: const Text("")),
        RaisedButton(
          color: Colors.grey,
          onPressed: () {



          },
          child: Badge(
            badgeColor: Colors.grey,
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: const Duration(milliseconds: 300),
            borderRadius: BorderRadius.zero,
            animationType: BadgeAnimationType.slide,
            badgeContent: Text(
              _counter.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        RaisedButton.icon(
            onPressed: () {
              if (_counter > 0) {
                setState(() {
                  _counter--;
                  myCounter=_counter;
                });
              }
            },
            icon: const Icon(Icons.remove),
            label: const Text('')),
      ],
    );
  }

  Widget _productDetail() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(20)),
                    width: 77,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('(5)',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellowAccent,
                          size: 20,
                        ),
                      ],
                    )),


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                      child: Text(widget.name,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 30))),
                  Container(),
                  int.parse(widget.discount) > 0
                      ? Row(
                          children: [
                            Text(
                              widget.price + '\$',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black54,
                                  fontSize: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                                myDiscount(
                                        int.parse(widget.price), int.parse(widget.discount)) +
                                    '\$',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 20))
                          ],
                        )
                      : Text(
                          widget.price + '\$',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 20),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: <Widget>[
                  Center(
                      child: Text(widget.category,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 20))),
                  const SizedBox(width: 150),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _productDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Description',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          const Text(
              'xhghasghghd ghgahgchfdaghfhag jvgjcgvjsdgjggg gggggvjdjd jgjgdjgdsjvg jgsdjgsj vgjdsgjvgj dsgvjgs jvgj gjvg sjvgjsg sjgvj sgv jvsj',
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (myCounter > 0) {
                    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                    final cartDao = database.cartDao;
                    c=c+myCounter;

                  cartDao.DeleteAllByPId(widget.productId!);
                    final cart = CartEntity(productId: widget.productId!, userId: widget.userId!,p_quantity: c);
                    await cartDao.insertInCart(cart);


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductCheckoutDb(
                          userId: widget.userId,
                          productId: widget.productId),
                      ),
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('cart is Empty'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.red),
                    ))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String myDiscount(int price, int dis) {
    disPrice = (price - (price * dis) / 100);
    return disPrice.toString();
  }




}
