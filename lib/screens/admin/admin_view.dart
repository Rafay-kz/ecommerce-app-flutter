import 'package:flutter/material.dart';
import 'category_view.dart';
import 'product_view.dart';

class Admin extends StatefulWidget {

  const Admin({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<Admin> createState() => _Admin();
}

class _Admin extends State<Admin> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(

          decoration: const BoxDecoration(

          image: DecorationImage(
          image: AssetImage(
          'assets/images/bakground.jpg'),
      fit: BoxFit.cover,
      )),
          child: Center(

            child: ListView(
             children:<Widget> [
                  Padding(
                    padding: const EdgeInsets.only(top:80),
                    child: Center(child: Text('ADMIN', style: TextStyle(
                      fontSize: 80,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.black,
                    ),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRect(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // background
                              onPrimary: Colors.white, // foreground
                            ),

                            onPressed: () async {


                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyCategory(title:'category')),
                              );
                            }, child: const Text('ADD Category'),),
                        ),
                        ClipRect(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {


                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyProduct(title:'product')),
                              );
                            }, child: const Text('ADD Product'),),
                        ),
                        ClipRect(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {


                              Navigator.pop(context);
                            }, child: const Text('Close'),),
                        ),

                      ],
                    ),
                  ),
                ],

            ),


          ),
        ),
      ),
    );
  }
}