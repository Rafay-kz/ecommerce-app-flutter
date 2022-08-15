import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/dao/cart_dao.dart';
import 'package:e_commerce_app/entity/cart_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCheckoutDb extends StatefulWidget {
  const ProductCheckoutDb(
      {Key? key, required this.userId, required this.productId})
      : super(key: key);
  final int? userId, productId;
  @override
  State<ProductCheckoutDb> createState() =>
      _ProductCheckoutDb();
}

class _ProductCheckoutDb extends State<ProductCheckoutDb> with SingleTickerProviderStateMixin {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;
  double? disPrice;
  double? discount;
  List dicList = [];
  List priceList = [];
  AppDatabase? database;
  CartDao? cartDao;
  late int counter;
  late int myValue2;
   late String myTotalDis;
   late String myTotalPrice;
  late String myValue;
  late String value;




  Future<List<ProductEntity?>> products() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final result = await database?.cartDao.findCartByUserId(widget.userId!);

    return result!;
  }

  Stream<List<CartEntity>> cart(){
    final result =database?.cartDao.findAllCart2();
    return result!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sliverAppbar = SliverAppBar(
      pinned: _pinned,
      snap: _snap,
      floating: _floating,
      expandedHeight: 100.0,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text(
          'Men\'s Wear',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titlePadding: EdgeInsets.fromLTRB(6, 0, 6, 0),
      ),
      backgroundColor: Colors.white70,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder(
        future: products(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget newsListSliver;
          if (snapshot.hasData) {
            final productList = snapshot.data as List<ProductEntity?>;
            if (productList.isNotEmpty) {
              {
                newsListSliver = SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {

                    return Column(
                      children: [
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white70,
                            //new Color.fromRGBO(255, 0, 0, 0.0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                      child: Image.asset(
                                          productList[index]!.image,
                                          height: 200,
                                          width: 140,
                                          fit: BoxFit.cover),
                                    ),
                                    width: 120,
                                    height: 200,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productList[index]!.name.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      productList[index]!.category.toString(),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          itemSize: 13,
                                          initialRating: 0,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {

                                          },
                                        ),
                                        const Text(
                                          ' (0)',
                                          style:  TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    productList[index]!.dis > 0
                                        ? Row(
                                          children: [
                                            Text(
                                               myValue= myDiscount(
                                                        productList[index]!.price,
                                                        productList[index]!.dis) ,

                                              ),
                                            const Text(
                                              '\$',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        )
                                        : Row(
                                          children: [
                                            Text(value=productList[index]!.price.toString()
                                                ),
                                            const Text(
                                              '\$',

                                            ),
                                          ],
                                        ),
                                    StreamBuilder(
                                      stream: cart(),
                                      //future: cart(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          var listOrders = snapshot.data as List<CartEntity>;
                                          int? numberOfOrders = listOrders[index].p_quantity;
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Total Item: ${myValue2=numberOfOrders!}'),
                                                const SizedBox(width: 20,),
                                                productList[index]!.dis > 0?
                                                Row(
                                                  children: [
                                                    const Text('Total Price:'),
                                                    const SizedBox(height: 5,),
                                                    Text(myTotalDis=totalItemPrice(double.parse( myDiscount(
                                                        productList[index]!.price,
                                                        productList[index]!.dis)),myValue2).toString()),

                                                  ],
                                                ):
                                                Row(
                                                  children: [
                                                    const Text('Total Price:'),
                                                    const SizedBox(width: 5,),
                                                    Text(myTotalPrice=totalItemPrice2(productList[index]!.price,myValue2).toString()),

                                                  ],
                                                ),


                                              ],
                                            );
                                        }else {
                                          return const Text('Cart is Empty');
                                        }
                                      },
                                    ),


                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ClipRect(
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 70),
                                        height: 200,
                                        child: Stack(
                                          children: <Widget>[
                                            const Card(
                                              semanticContainer: true,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                            ),
                                            FractionalTranslation(
                                              translation: const Offset(0.0, 0.2),
                                              child: Align(
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white70,
                                                    radius: 15.0,
                                                    child: CircleAvatar(
                                                      radius: 70,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                            size: 18),
                                                        onPressed: () async {
                                                          final database =
                                                              await $FloorAppDatabase
                                                                  .databaseBuilder(
                                                                      'app_database.db')
                                                                  .build();
                                                          await database.cartDao
                                                              .DeleteById(
                                                                  productList[
                                                                          index]!
                                                                      .id!);
                                                          setState(() {});
                                                        },
                                                      ),
                                                    )),
                                                alignment: const FractionalOffset(
                                                    1.0, 0.7),
                                              ),
                                            ),
                                          ],
                                        )),
                                  )),


                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: productList.length,
                ));
              }
            } else {
              return const Center(child: Text('No Item in cart'));
            }
          } else {
            return const Center(child: Text('No Item in cart'));
          }
          return CustomScrollView(slivers: <Widget>[
            sliverAppbar,
            newsListSliver,

          ]);
        },
      ),
    );


  }
  String myDiscount(int price, int dis) {
    discount = (price - (price * dis) / 100);
    return discount.toString();
  }
  double totalItemPrice(double value1, int myValue2) {
    double ans;
    ans= value1*myValue2;
    return ans;



  }
  String totalPriceOfItems(double myTotalDis, double myTotalPrice) {

    double totalAdd;
    totalAdd=myTotalPrice+myTotalDis;
    return totalAdd.toString();
  }
}

int totalItemPrice2(int price, int myValue2) {
  int ans;
  ans= price*myValue2;
  return ans;

}
