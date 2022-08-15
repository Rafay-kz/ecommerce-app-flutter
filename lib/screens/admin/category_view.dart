import 'package:e_commerce_app/entity/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/appdatabase/database.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyCategory> createState() => _MyCategory();
}

class _MyCategory extends State<MyCategory> with SingleTickerProviderStateMixin {
  final myController = TextEditingController();

  Future<List> categoryData() async {
    final database1 =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await database1.categoryDao.findAllCategory();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add & View Categories',
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
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: myController,
              autofocus: true,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Enter Category"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () async {
                if (myController.text != '') {
                  final database = await $FloorAppDatabase
                      .databaseBuilder('app_database.db')
                      .build();
                  final categoryDao = database.categoryDao;
                  final category = CategoryEntity(name: myController.text);
                  await categoryDao.insertCategory(category);
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    myController.text = '';
                  });
                  const snackBar = SnackBar(
                    content: Text('Category Add Successfully'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(
                    content: Text('Try Again...'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Add'),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Center(
                  child: Text(
                'List Of Category',
                style: TextStyle(fontSize: 30),
              )),
            ),
            Expanded(
              child: FutureBuilder(
                future: categoryData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final result = snapshot.data as List<CategoryEntity>;
                    if (result.isNotEmpty) {
                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 100,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) => Stack(children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white70
                                  ,border: Border.all(color: Colors.black12)),
                              height: 230,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Center(
                                        child: Icon(Icons.shopping_bag_outlined, color: Colors.green,size: 30,)
                                      ),
                                      const SizedBox(height: 5,),
                                       Center(
                                        child: Text(
                                          'Category Number: ${(index+1)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 13.0),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            result[index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 13.0),
                                          ),
                                          Container(),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red,),
                                            onPressed: () async {
                                              final database =
                                                  await $FloorAppDatabase
                                                      .databaseBuilder(
                                                          'app_database.db')
                                                      .build();
                                              await database.categoryDao
                                                  .DeleteById(result[index].id!);
                                              setState(() {});
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'category Delete Successfully'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                          )
                                        ],
                                      )
                                    ]),
                              ))
                        ]),
                        itemCount: result.length,
                      );

                      /* ListView.builder(
                          itemCount: result.length,
                          itemBuilder: (context, i) {
                            return SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result[i].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Container(),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        final database = await $FloorAppDatabase
                                            .databaseBuilder('app_database.db')
                                            .build();
                                        await database.categoryDao.DeleteById(result[i].id!);
                                        setState(() {

                                        });
                                        const snackBar = SnackBar(
                                          content: Text('category Delete Successfully'),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                    )
                                  ],
                                ));
                          });*/

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
