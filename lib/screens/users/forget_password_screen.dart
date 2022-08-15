import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForgetPassword> createState() => _ForgetPassword() ;
}

class _ForgetPassword extends State<ForgetPassword>{
  final _formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final TextEditingController _uname=TextEditingController();
  final TextEditingController _password = TextEditingController();
  $FloorAppDatabase? database;

@override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text('Forget password',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
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
                      Icons.account_circle_sharp,
                      color: Colors.black,
                      size: 100.0,

                    ),
                  ),
                  const SizedBox(height: 100.0),



                  TextFormField(
                    controller: _uname,
                    decoration: const InputDecoration(
                      labelText: 'Enter Your Username',
                      border: UnderlineInputBorder(),

                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
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
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter New Password';
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
                          final result=await userDao.findAllUserByuname(_uname.text);
                          print(result?.name);
                          if(_uname.text==result?.name){
                            await userDao.UpdatePasswordByUsername(_password.text, _uname.text);
                            Fluttertoast.showToast(
                                msg:"Password Changed Successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 12.0);
                            setState(() {
                              _uname.text='';
                              _password.text='';
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login(title: 'Login',)),
                            );
                          }
                          else{
                            const snackBar = SnackBar(
                              content: Text('User not found'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          _formKey.currentState!.save();
                        }
                        else {
                        }
                      },
                      icon: const Icon(Icons.edit_attributes),
                      label: const Text('Update password'
                        , style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,

                        ),),

                    ),
                  ),

                  const SizedBox(height: 20.0),



                ],

              ),
            ),
          ],
        ),


      ),
    );
  }
}

