import 'package:badges/badges.dart';
import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/dao/cart_dao.dart';
import 'package:e_commerce_app/dao/fav_dao.dart';
import 'package:e_commerce_app/dao/product_dao.dart';
import 'package:e_commerce_app/dao/user_info_dao.dart';
import 'package:e_commerce_app/entity/category.dart';
import 'package:e_commerce_app/entity/fav_entity.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:e_commerce_app/models/Item.dart';
import 'package:e_commerce_app/models/Item2.dart';
import 'package:e_commerce_app/screens/users/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'product_detail.dart';


class Screen4 extends StatefulWidget {
  const Screen4({Key? key, required this.userid})
      : super(key: key);
  final int? userid;


  @override
  State<Screen4> createState() => _Screen4();
}

class _Screen4 extends State<Screen4> with SingleTickerProviderStateMixin {
  _Screen4();
  //Variables Declaration
  int _selectedIndex = 0;
  AppDatabase? database;
  ProductDao? productDao;
  CartDao? cartDao;
  FavDao? favDao;
  UserDao? userDao;
  int count = 0;
  double? discount;
  FavEntity? favourite;
  final TextEditingController _uname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phNo = TextEditingController();
  String categoryName='';
  TabController? controller;
  List<String> catList = [];
  bool myFav = false;
  final _formKey = GlobalKey<FormState>();
  bool enable1=false;
  bool enable2=false;
  bool enable3=false;
  bool enable4=false;
  bool enable5=false;
  bool isTapped=true;
  bool? isTouching;
  bool? isTouching2;
  bool onGridTap=false;
  bool iconChange=true;
  final ScrollController _scrollController = ScrollController();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  List<Item> list = [Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false), Item(true), Item(false)
  ];

  List catAllItem=[];

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  handleTouch(bool confirmTouch) {
    setState(() {
      isTouching = confirmTouch;
      isTouching2 = confirmTouch;
    });
  }

  //Some useful Methods
  void categoryData() async {
    final database1 =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final result=await database1.categoryDao.findAllCategory();
    for (int i = 0; i<result.length; i++) {
      if (i >= 0) {
        catList.add(result[i].name);
      }
    }

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  builder() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    setState(() {
      productDao = database?.productDao;
      favDao = database?.favDao;
      userDao=database?.userDao;
    });
  }
  Future<List<ProductEntity?>> products() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final result = await database?.cartDao.findCartByUserId(widget.userid!);


    return result!;
  }
  Future<List<CategoryEntity>> getAllCat() async {
    final database1 =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await database1.categoryDao.findAllCategory();
  }
  @override
  void initState() {
    categoryData();
    builder();
    super.initState();

  }

  //Widgets and build method
  @override
  Widget build(BuildContext context) {
    Widget profile= Scaffold(
      appBar: AppBar(
          title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.black,
        leading: const Icon(Icons.person),
      ),
      body:
      FutureBuilder(
        future: userDao?.findUserById(widget.userid!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            final UserEntity userinfo=snapshot.data;
            _name.text=  userinfo.fname!;
            _email.text=userinfo.email!;
            _password.text=userinfo.password!;
            _phNo.text=userinfo.phno.toString();
            _uname.text=userinfo.name!;


            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: Icon(
                          Icons.account_circle_sharp,
                          color: Colors.black,
                          size: 100.0,
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _name,
                              enabled: enable1,
                              decoration:   const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Name',
                                ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 13,
                              backgroundColor: Colors.orange,
                              child:  GestureDetector(
                                child: const Icon(Icons.edit, color: Colors.black,size: 13,),
                                onTap: (){
                                  enable1=true;
                                  setState(() {
                                  });

                                },
                              ),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                             controller: _email,
                             // initialValue: userinfo.email,
                              enabled: enable2,
                              decoration:  const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => validateEmail(value),

                            ),
                          ),
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.orange,
                            child:  GestureDetector(
                              child: const Icon(Icons.edit, color: Colors.black,size: 13,),
                              onTap: (){
                                enable2=true;
                                setState(() {
                                });

                              },
                            ),

                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                             controller: _phNo,

                              enabled: enable3,
                              decoration:  const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Phone number',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Phone number';
                                }
                                return null;
                              },

                            ),
                          ),
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.orange,
                            child:  GestureDetector(
                              child: const Icon(Icons.edit, color: Colors.black,size: 13,),
                              onTap: (){
                                enable3=true;
                                setState(() {


                                });

                              },
                            ),

                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _uname,
                             // initialValue: userinfo.name,
                              enabled: enable4,
                              decoration:  const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Username',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Username';
                                }
                                return null;
                              },

                            ),
                          ),
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.orange,
                            child:  GestureDetector(
                              child: const Icon(Icons.edit, color: Colors.black,size: 13,),
                              onTap: (){
                                enable4=true;
                                setState(() {
                                });
                              },
                            ),

                          ),
                        ],
                      ),
                     Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _password,
                             // initialValue: userinfo.password,
                              enabled: enable5,
                              obscureText: _obscured,
                              focusNode: textFieldFocusNode,
                              decoration:  InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  hintText: 'password',
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(

                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.orange,
                            child:  GestureDetector(
                              child: const Icon(Icons.edit, color: Colors.black,size: 13,),
                              onTap: (){
                                enable5=true;
                                setState(() {
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // background
                            onPrimary: Colors.orange,
                          ),
                          onPressed: () async{
                            if (_formKey.currentState!.validate()){
                              final userDao = database?.userDao;
                              final uResult=await userDao?.findUsername(_uname.text);
                              if(enable4==false){
                                final UserEntity userdata= UserEntity(id:widget.userid,name: _uname.text, password: _password.text, email: _email.text, fname: _name.text, phno: int.parse(_phNo.text));
                                await userDao?.updateuserdetail(userdata);
                                Fluttertoast.showToast(
                                    msg:"Updated Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 12.0);
                                setState(() {
                                  enable1=false;
                                  enable2=false;
                                  enable3=false;
                                  enable4=false;
                                  enable5=false;
                                });
                              }else {
                                if(_uname.text==uResult?.name){
                                  const snackBar = SnackBar(
                                    content: Text('Please Use another Username'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                else{
                                  final UserEntity userdata= UserEntity(id:widget.userid,name: _uname.text, password: _password.text, email: _email.text, fname: _name.text, phno: int.parse(_phNo.text));
                                  await userDao?.updateuserdetail(userdata);
                                  Fluttertoast.showToast(
                                      msg:"Updated Successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                  setState(() {
                                    enable1=false;
                                    enable2=false;
                                    enable3=false;
                                    enable4=false;
                                    enable5=false;
                                  });
                                }

                              }


                            }else {
                              print('Error');
                            }






                          },
                          icon: const Icon(Icons.edit_attributes),
                          label: const Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // background
                            onPrimary: Colors.orange,
                            // foreground
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return const CircularProgressIndicator();
          }
      },),
    );
    Widget favourite=Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Items',
          style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: const Icon(Icons.favorite,color: Colors.red,),
      ),


      body: FutureBuilder(
        future: favDao?.findfavByUserId(widget.userid!),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final productList = snapshot.data as List<ProductEntity>;
            if (productList.isNotEmpty) {
            return  ListView.builder(
             controller: _scrollController,
              scrollDirection: Axis.vertical,
                  itemCount: productList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Container(
                        height: 100,
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
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.only(
                                        topLeft:
                                        Radius.circular(10.0),
                                        bottomLeft:
                                        Radius.circular(10.0)),
                                    child: Image.asset(
                                        productList[i].image,
                                        height: 200,
                                        width: 140,
                                        fit: BoxFit.cover),
                                  ),
                                  width: 120,
                                  height: 200,
                                ),
                                if (productList[i].dis > 0)
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 0),
                                      width: 45,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.red[400],
                                          borderRadius:
                                          BorderRadius.circular(
                                              20)),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                            productList[i]
                                                .dis
                                                .toString() +
                                                '%',
                                            style: const TextStyle(
                                                color: Colors.white),
                                            textAlign:
                                            TextAlign.center),
                                      ))
                                else
                                  Container()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productList[i].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    productList[i].category,
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
                                        '(0)',
                                        style: TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  productList[i].dis > 0
                                      ? Row(
                                    children: [
                                      Text(
                                        productList[i]
                                            .price
                                            .toString() +
                                            '\$',
                                        style: const TextStyle(
                                            decoration:
                                            TextDecoration
                                                .lineThrough,
                                            color:
                                            Colors.black54),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                          myDiscount(
                                              productList[
                                              i]
                                                  .price,
                                              productList[
                                              i]
                                                  .dis) +
                                              '\$',
                                          style: const TextStyle(
                                              color: Colors.red))
                                    ],
                                  )
                                      : Text(productList[i]
                                      .price
                                      .toString() +
                                      '\$'),
                                ],
                              ),
                            ),
                            FutureBuilder(
                              future: favDao?.findAllFavProduct(),
                              builder:
                                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  final productList2 = snapshot.data as List<FavEntity>;

                                  if (productList2.isNotEmpty) {
                                    return  Expanded(
                                        child: Container(
                                            margin:
                                            const EdgeInsets.only(top: 70),
                                            height: 200,
                                            child: Stack(
                                              children:  <Widget>[
                                                const Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                ),
                                                FractionalTranslation(
                                                  translation: const Offset(0.0, 0.4),
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
                                                            Icons
                                                                .favorite_rounded,
                                                            color: Colors.red,
                                                            size: 18,
                                                          ), onPressed: () async{
                                                          await favDao?.DeleteByPId(productList2[i].product_id!, widget.userid!);
                                                          setState(() {
                                                          });
                                                        },
                                                        ),
                                                      ),
                                                    ),
                                                    alignment: const FractionalOffset(
                                                        1.0, 0.7),
                                                  ),
                                                ),
                                              ],
                                            )));

                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                } else {
                                  return const CircularProgressIndicator();
                                }

                              },
                            ),



                          ],
                        ),
                      ),
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail2(
                              name: productList[i].name,
                              price:
                              productList[i].price.toString(),
                              category: productList[i].category,
                              image: productList[i].image,
                              discount:
                              productList[i].dis.toString(),
                              userId: widget.userid,
                              productId: productList[i].id,
                            ),
                          ),
                        );
                      },
                    );
                  });

            } else {
              return const Center(child: Text('No Item in Favourite List', style: TextStyle(fontSize: 30),));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }


        },
      ),
    );
    Widget gridview=FutureBuilder(
      future: categoryName.isEmpty|| isTapped? productDao?.findAllProduct(): productDao?.findProductByCategory(categoryName),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final productList = snapshot.data as List<ProductEntity>;
          if (productList.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) => Stack(children: <Widget>[
                InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            image: DecorationImage(
                              image: AssetImage(productList[index].image),
                              alignment: Alignment.center,
                              fit: BoxFit.fitWidth,
                            ), //new Color.fromRGBO(255, 0, 0, 0.0),
                            border: Border.all(color: Colors.white70),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                              margin: const EdgeInsets.only(top: 100),
                              height: 200,
                              child: Stack(
                                children: <Widget>[
                                  const Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                  ),

                                  FutureBuilder(
                                      future: favDao?.findfavouritebyUidPid(widget.userid!, productList[index].id!),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData){
                                          var myFavList=snapshot.data as FavEntity;
                                          return FractionalTranslation(
                                            translation: const Offset(0.0, 0.4),
                                            child: Align(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 130),
                                                height: 40.0,
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 50,
                                                        color: Colors.black12,
                                                        spreadRadius: 1.0)
                                                  ],
                                                ),

                                                child:
                                                myFavList.favourite==1?
                                                CircleAvatar(
                                                  radius: 70,
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      list[index].isfav=false;
                                                      await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .favorite_rounded,
                                                      color:
                                                      Colors.red,
                                                      size: 18,
                                                    ),
                                                  ),
                                                )
                                                    :
                                                CircleAvatar(
                                                  radius: 70,
                                                  backgroundColor:
                                                  Colors.white,
                                                  child: IconButton(
                                                    onPressed:
                                                        () async {
                                                      await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                      final favourite=FavEntity(product_id: productList[index].id, user_id: widget.userid, favourite: 1);
                                                      await favDao?.insertInfav(favourite);

                                                      list[index].isfav=true;
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),

                                              ),
                                              alignment:
                                              const FractionalOffset(
                                                  1.0, 0.7),
                                            ),
                                          );

                                        }
                                        else {
                                          return FractionalTranslation(
                                            translation: const Offset(0.0, 0.4),
                                            child: Align(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 130),
                                                height: 40.0,
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 50,
                                                        color: Colors.black12,
                                                        spreadRadius: 1.0)
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 70,
                                                  backgroundColor:
                                                  Colors.white,
                                                  child: IconButton(
                                                    onPressed:
                                                        () async {
                                                      await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                      final favourite=FavEntity(product_id: productList[index].id, user_id: widget.userid, favourite: 1);
                                                      await favDao?.insertInfav(favourite);

                                                      list[index].isfav=true;
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              alignment:
                                              const FractionalOffset(
                                                  1.0, 0.7),
                                            ),
                                          );
                                        }
                                      }
                                  ),


                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                            const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        productList[index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(
                        productList[index].category,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),

                      productList[index].dis>0?
                      Row(
                        children: [
                          Text(
                            productList[index].price.toString() + '\$',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black54),
                          ),
                          const SizedBox(width: 10),
                          Text(myDiscount(productList[index].price,productList[index].dis) + '%',
                              style: const TextStyle(color: Colors.red))
                        ],
                      )

                          : Text(productList[index].price.toString())
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail2(
                          name: productList[index].name,
                          price:
                          productList[index].price.toString(),
                          category: productList[index].category,
                          image: productList[index].image,
                          discount:
                          productList[index].dis.toString(),
                          userId: widget.userid,
                          productId: productList[index].id,
                        ),
                      ),
                    );
                  },
                ),
                Stack(
                  children: <Widget>[

                    if (productList[index].dis>0)
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          width: 45,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(productList[index].dis.toString() + '%',
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                          ))
                    else
                      Container()
                  ],
                )
              ]),
              itemCount: productList.length,
            );


          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
    Widget listView=FutureBuilder(
      future: categoryName.isEmpty|| isTapped? productDao?.findAllProduct(): productDao?.findProductByCategory(categoryName),

      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget newsListSliver;
        if (snapshot.hasData) {
          final productList = snapshot.data as List<ProductEntity>;
          if (productList.isNotEmpty) {
            {
              newsListSliver = SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return InkWell(
                        child: Container(
                          height: 100,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(10.0),
                                          bottomLeft:
                                          Radius.circular(
                                              10.0)),
                                      child: Image.asset(
                                          productList[index].image,
                                          height: 200,
                                          width: 140,
                                          fit: BoxFit.cover),
                                    ),
                                    width: 120,
                                    height: 200,
                                  ),
                                  if (productList[index].dis > 0)
                                    Container(
                                        margin:
                                        const EdgeInsets.fromLTRB(
                                            10, 10, 0, 0),
                                        width: 45,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.red[400],
                                            borderRadius:
                                            BorderRadius.circular(
                                                20)),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                              productList[index]
                                                  .dis
                                                  .toString() +
                                                  '%',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign:
                                              TextAlign.center),
                                        ))
                                  else
                                    Container()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productList[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      productList[index].category,
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
                                          itemPadding: const EdgeInsets
                                              .symmetric(
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
                                          '(0)',
                                          style: TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    productList[index].dis > 0
                                        ? Row(
                                      children: [
                                        Text(
                                          productList[index]
                                              .price
                                              .toString() +
                                              '\$',
                                          style: const TextStyle(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough,
                                              color:
                                              Colors.black54),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                            myDiscount(
                                                productList[
                                                index]
                                                    .price,
                                                productList[
                                                index]
                                                    .dis) +
                                                '\$',
                                            style:
                                            const TextStyle(
                                                color: Colors
                                                    .red))
                                      ],
                                    )
                                        : Text(productList[index]
                                        .price
                                        .toString() +
                                        '\$'),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 70),
                                      height: 200,
                                      child: Stack(
                                        children: <Widget>[
                                          const Card(
                                            semanticContainer: true,
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                          ),



                                          FutureBuilder(
                                              future: favDao?.findfavouritebyUidPid(widget.userid!, productList[index].id!),
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData){
                                                  var myFavList=snapshot.data as FavEntity;
                                                  return FractionalTranslation(
                                                    translation: const Offset(0.0, 0.4),
                                                    child: Align(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white70,
                                                        radius: 15.0,
                                                        child:
                                                        myFavList.favourite==1?
                                                        CircleAvatar(
                                                          radius: 70,
                                                          backgroundColor: Colors.white,
                                                          child: IconButton(
                                                            onPressed: () async {
                                                              list[index].isfav=false;
                                                              await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .favorite_rounded,
                                                              color:
                                                              Colors.red,
                                                              size: 18,
                                                            ),
                                                          ),
                                                        )
                                                            :
                                                        CircleAvatar(
                                                          backgroundColor:
                                                          Colors.white70,
                                                          radius: 15.0,
                                                          child: CircleAvatar(
                                                            radius: 70,
                                                            backgroundColor:
                                                            Colors.white,
                                                            child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                                final favourite=FavEntity(product_id: productList[index].id, user_id: widget.userid, favourite: 1);
                                                                await favDao?.insertInfav(favourite);

                                                                list[index].isfav=true;
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors.red,
                                                                size: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ),
                                                      alignment:
                                                      const FractionalOffset(
                                                          1.0, 0.7),
                                                    ),
                                                  );

                                                }
                                                else {
                                                  return FractionalTranslation(
                                                    translation: const Offset(0.0, 0.4),
                                                    child: Align(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white70,
                                                        radius: 15.0,
                                                        child:
                                                        CircleAvatar(
                                                          backgroundColor:
                                                          Colors.white70,
                                                          radius: 15.0,
                                                          child: CircleAvatar(
                                                            radius: 70,
                                                            backgroundColor:
                                                            Colors.white,
                                                            child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await favDao?.DeleteByPId(productList[index].id!, widget.userid!);
                                                                final favourite=FavEntity(product_id: productList[index].id, user_id: widget.userid, favourite: 1);
                                                                await favDao?.insertInfav(favourite);

                                                                list[index].isfav=true;
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors.red,
                                                                size: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ),
                                                      alignment:
                                                      const FractionalOffset(
                                                          1.0, 0.7),
                                                    ),
                                                  );
                                                }
                                              }
                                          ),

                                        ],
                                      ))),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail2(
                                name: productList[index].name,
                                price:
                                productList[index].price.toString(),
                                category: productList[index].category,
                                image: productList[index].image,
                                discount:
                                productList[index].dis.toString(),
                                userId: widget.userid,
                                productId: productList[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: productList.length,
                  ));
            }
          } else {
            return const Center(child: Text('No Item Available for this Category'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(slivers: <Widget>[
          newsListSliver,
        ]);
      },
    );
    return WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return _selectedIndex==0
                ?
              <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 120.0,
                flexibleSpace: const FlexibleSpaceBar(
                    title: Text(
                      'Men\'s Wear',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    titlePadding: EdgeInsets.fromLTRB(10, 0, 0, 55)),
                backgroundColor: Colors.white70,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  _shoppingCartBadge(),
                ],
                bottom: PreferredSize(
            child: Container(),

            preferredSize: const Size.fromHeight(4.0)),
              ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white70,
                    //height: 45,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 35,
                            width: 70,

                            child: Center(
                                child: Row(
                                  children: const [
                                    Icon(Icons.filter_list_outlined, color: Colors.black,size: 20,),
                                    SizedBox(width: 5,),
                                    Text('Filter',style: TextStyle(color: Colors.black, fontSize: 20),),
                                  ],
                                )), ),
                          GestureDetector(
                            child: Listener(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 35,
                                width: 60,
                                decoration:  BoxDecoration(
                                    color: isTouching == true ? Colors.red : Colors.black,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),

                                    )
                                ),
                                child: const Center(
                                    child: Text('All',style: TextStyle(color: Colors.white),)), ),

                              onPointerDown: (event) => setState(() {
                                isTouching = true;
                              }),
                              onPointerUp: (event) => setState(() {
                                isTouching = false;
                              }),
                            ),
                            onTap: (){
                              isTapped=true;
                              setState(() {

                              });
                            },
                          ),
                          for (int i = 0; i < catList.length; i++)
                            GestureDetector(
                              child: Listener(

                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 35,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                      )
                                  ),
                                  child: Center(child: Text(catList[i],style: const TextStyle(color: Colors.white),)), ),



                              ),
                              onTap: (){
                                categoryName=catList[i];
                                isTapped=false;
                                setState(() {

                                });
                              },
                            ),

                          const SizedBox(width: 20,)
                        ],

                      ),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children:  const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('ALL PRODUCTS', style: TextStyle(
                                fontSize: 30
                              ),),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Row(
                          children: [
                           Container(),
                            Container()
                          ],
                        ),
                        Row(
                          children: [
                            iconChange?
                            IconButton(
                              icon: const Icon(
                                Icons.apps,
                              ),
                              onPressed: () {
                                setState(() {
                                  onGridTap=true;
                                  iconChange=false;
                                });
                                },):
                            IconButton(
                              icon: const Icon(
                                Icons.list_sharp,
                              ),
                              onPressed: () {
                                setState(() {
                                  onGridTap=false;
                                  iconChange=true;
                                });
                              },)
                          ],),],)),),

              ] :
              <Widget>[SliverToBoxAdapter(
                  child: Container()
                )];
          },
          body:
              IndexedStack(index: _selectedIndex, children: [
                !onGridTap?
                listView: gridview,
                favourite,
                profile,]),

        ),

        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          onTap: _onItemTapped,
        ),
    ),
      );
  }
  Widget _shoppingCartBadge() {
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
                            userId: widget.userid,
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
  //Some useful Methods
  String myDiscount(int price, int dis) {
    discount = (price - (price * dis) / 100);
    return discount.toString();
  }
  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
