import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/dao/category_dao.dart';
import 'package:e_commerce_app/screens/admin/admin_view.dart';
import 'package:e_commerce_app/screens/users/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'users/main_screen_testing.dart';
import 'users/user_signup.dart';


class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  State<Login> createState() => _Login() ;
}
class _Login extends State<Login>{
  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final TextEditingController _uname=TextEditingController();
  final TextEditingController _password = TextEditingController();
  List<String> catList = [];
  List<int> prodList=[];
  $FloorAppDatabase? database;
  CategoryDao? categoryDao;
  bool isValidate = true;

  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
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
  void productData() async {
    final database1 =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final result = await database1.productDao.findAllProduct();
    for (int i = 0; i < result.length; i++) {
      if (i >= 0) {
        prodList.add(result[i].id!);
      }
    }

  }
@override
  void initState() {
  productData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
          centerTitle: true,
          backgroundColor: Colors.black
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[

                  const Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 150.0,

                    ),
                  ),
                  const SizedBox(height: 100.0),



                  TextFormField(
                    controller: _uname,
                    decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                    ),
                    onChanged: (username){
                      if(!isValidate)
                        _formKey.currentState!.validate();
                      setState(() {
                      });

                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _password,
                    key: _passwordFieldKey,
                    obscureText: _obscured,
                    focusNode: textFieldFocusNode,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
                    onChanged: (password){
                      if(!isValidate)
                        _formKey.currentState!.validate();
                      setState(() {
                      });

                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),




                  const SizedBox(height: 50.0),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                        final userDao = database.userDao;
                        if (_formKey.currentState!.validate()) {
                          final result=await userDao.findAllLoginuser(_uname.text, _password.text);
                          final resultId=await userDao.findUserID(_uname.text);
                          if(_uname.text==result?.name && _password.text==result?.password){

                            setState(() {
                              _uname.text='';
                              _password.text='';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Screen4(userid: resultId?.id)),
                            );
                          }
                         else if(_uname.text=='admin' && _password.text=='admin'){
                            setState(() {

                              _uname.text='';
                              _password.text='';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Admin(title: 'Admin')),
                            );
                          }
                          else{
                            const snackBar = SnackBar(
                              content: Text('User not found'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            setState(() {
                              _uname.text='';
                              _password.text='';
                            });
                          }
                          _formKey.currentState!.save();
                        }
                        else {
                          setState(() {
                            isValidate=false;
                          });

                          print('Error');
                        }
                      },
                      icon: const Icon(Icons.edit_attributes),
                      label: const Text('Login'
                        , style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,

                        ),),

                    ),
                  ),

                  const SizedBox(height: 20.0),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const Text('Forget your password?',

                          style: TextStyle(
                              decoration: TextDecoration.underline,

                              color: Colors.blue),

                        ),

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgetPassword(title: 'Forget Password',)),
                          );

                        },
                      ),
                      const SizedBox(width: 20.0,),


                      GestureDetector(
                        child: const Text('Sign Up',

                          style: TextStyle(
                              decoration: TextDecoration.underline,

                              color: Colors.blue),

                        ),

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Signup(title: 'Signup',)),
                          );



                        },
                      ),
                    ],
                  ),


                ],

              ),
            ),
          ],
        ),


      ),
    );
  }
}

