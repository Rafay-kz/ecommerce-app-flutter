import 'dart:io';
import 'package:e_commerce_app/dao/category_dao.dart';
import 'package:e_commerce_app/entity/category.dart';
import 'package:e_commerce_app/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:flutter/services.dart';

class MyProduct extends StatefulWidget {

  const MyProduct({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<MyProduct> createState() => _MyProduct();
}

class _MyProduct extends State<MyProduct> with SingleTickerProviderStateMixin{
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  AppDatabase? database;
  CategoryDao? categoryDao;
  String? _dropValue;
  int? discount;
  List<String> catList=[];

  @override
  void initState() {
    // TODO: implement initState
    categoryData();
    super.initState();
  }
  Future<List> productData() async {
    final database1 =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await database1.productDao.findAllProduct();
  }
  Future<List<CategoryEntity>> getAllCat() async{
    final database1 =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await database1.categoryDao.findAllCategory();
  }
  void categoryData() async{
    final database1 =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final result= await database1.categoryDao.findAllCategory();

    print(result.length);
    for(int i=0;i<result.length;i++){
      if(i>=0){
        catList.add(result[i].name);}
      if(i==0){
        _dropValue=catList[i];
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add & View Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
             decoration: const InputDecoration(
               hintText: 'Product Name'
             ),
              controller: myController1,
            ),
            FutureBuilder(
              future: getAllCat(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                  final result=snapshot.data as List<CategoryEntity>;
                  if(result.isNotEmpty){
                    return   DropdownButton<String>(
                      isExpanded: true,
                      focusColor: Colors.white,
                      value: _dropValue,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: catList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        "Choose Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _dropValue = value!;
                        });
                      },
                    );


                  }else{
                    return const CircularProgressIndicator();

                  }
                }else{
                  return const CircularProgressIndicator();
                }
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                  hintText: 'Product Price'
              ),
              controller: myController3,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: const InputDecoration(
                  hintText: 'Discount'
              ),
              controller: myController2,
            ),



           ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.black, // background
               onPrimary: Colors.white, // foreground
             ),
             onPressed: () async {
              if (myController1.text!=''&& _dropValue!=''&&myController3.text!='') {
                final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                final productDao = database.productDao;
               final product = ProductEntity(name:myController1.text,
                   category:_dropValue!,
                   price:int.parse(myController3.text),
                   image:'assets/images/myiamge1.jpg',
                   dis: int.parse(myController2.text),
               favpro: 0);
                await productDao.insertProduct(product);
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  myController1.text='';
                  myController3.text='';
                  _dropValue=catList[0];
                  myController2.text='';

                });


                const snackBar = SnackBar(
                  content: Text('Product Add Successfully'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              else{


                const snackBar = SnackBar(

                  content: Text('Try Again...'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, child: const Text('Add'),),


            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(child: Text('List Of Product',style: TextStyle(
                  fontSize: 30

              ),)),
            ),

            Expanded(
              child: FutureBuilder(
                future: productData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final result = snapshot.data as List<ProductEntity>;
                    if (result.isNotEmpty) {
                      return ListView.builder(
                          itemCount: result.length,
                          itemBuilder: (context, i) {
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                    border: Border.all(color: Colors.black12)
                                ),
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                result[i].name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              Text(
                                                result[i].category,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0),
                                              ),
                                              Text(
                                                result[i].price.toString()+'\$',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0),
                                              ),
                                              Text(
                                                result[i].dis.toString()+'%',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0),
                                              ),
                                            ],
                                          ),
                                          Container(),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red,),
                                            onPressed: () async {
                                              final database = await $FloorAppDatabase
                                                  .databaseBuilder('app_database.db')
                                                  .build();
                                              await database.productDao.DeleteById(result[i].id!);
                                              setState(() {

                                              });
                                              const snackBar = SnackBar(
                                                content: Text('Product Deleted Successfully'),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                          )
                                        ],
                                      ),



                                    ],
                                  ),
                                )

                            );
                          });
                    } else {
                      return const Center(child: Text('No Data'));
                    }
                  } else {
                    return const Center(child: Text('No Data'));
                  }
                },
              ),
            ),













    ],
        ),
      ),
    );
  }
}