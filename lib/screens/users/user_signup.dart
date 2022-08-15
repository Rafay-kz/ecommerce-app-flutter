import 'package:e_commerce_app/appdatabase/database.dart';
import 'package:e_commerce_app/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
class Signup extends StatefulWidget {
  const Signup({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  SingingCharacter? _character = SingingCharacter.Male;
  final _formKey = GlobalKey<FormState>();
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  TextEditingController _text1 = TextEditingController();
  final TextEditingController _text2 = TextEditingController();
  final TextEditingController _uname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phNo = TextEditingController();
  String? _dropValue;
  bool isEnable=true;
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _text1 = TextEditingController(text: getRandomString(5));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle( fontSize: 40,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _name,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Full name',
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (fullName){
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
                  controller: _email,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (email){
                    if(!isValidate)
                      _formKey.currentState!.validate();
                    setState(() {
                    //  isValidate=true;
                    });

                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _phNo,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (phoneNum){
                    if(!isValidate)
                      _formKey.currentState!.validate();
                    setState(() {
                    });

                  },
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
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _uname,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText: 'User Name',
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (userName){
                    if(!isValidate)
                      _formKey.currentState!.validate();
                    setState(() {
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _password,
                  obscureText: _obscured,
                  focusNode: textFieldFocusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white70,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54),
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
                      return 'Please enter Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Choose your gender',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
                ListTile(
                  minLeadingWidth: 20.0,
                  minVerticalPadding: 10.0,
                  title: const Text('Male'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Male,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  minLeadingWidth: 20.0,
                  minVerticalPadding: 5.0,
                  title: const Text('Female'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Female,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                const Text(
                  'You are?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  focusColor: Colors.white,
                  value: _dropValue,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    'Buyer',
                    'Seller',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: const Text(
                    "Choose Your Role",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onChanged: (value) {
                    if(!isValidate)
                      _formKey.currentState!.validate();
                    setState(() {
                      _dropValue=value!;
                    });
                  },
                  validator: (value) {
                    if (value==null) {
                      return 'Please Mention your Role';
                    }
                  },
                ),
                const SizedBox(height: 10,),
                Container(
                  color: Colors.grey,
                  width: 60.0,
                  height: 40.0,
                  child: TextFormField(
                    controller: _text1,
                    enabled: false,
                    style: const TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: TextFormField(
                        controller: _text2,
                        enabled: isEnable,

                        decoration: const InputDecoration(
                          labelText: 'Enter Above Text',
                        ),
                        style: const TextStyle(
                            fontSize: 15.0, height: 2.0, color: Colors.black54),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5)
                        ],
                        onFieldSubmitted: (captcha){},
                        onChanged: (captcha){
                          _formKey.currentState!.validate();

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required*';
                          }
                          return null;
                        },
                      ),
                    ),
                    FlatButton(
                      // splashColor: Colors.red,
                      color: Colors.red,
                      // textColor: Colors.white,
                      child: const Text(
                        'Verify',
                      ),
                      onPressed: () {
                        setState(() {
                          if (_text1.text != _text2.text) {
                            showAlertDialog(context);

                          } else {
                            showAlertDialog2(context);
                            isEnable=false;
                          }
                        });
                      },
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // background
                      onPrimary: Colors.white,
                      // foreground
                    ),
                    onPressed: () async {
                     if (_formKey.currentState!.validate())
                     {
                        final database = await $FloorAppDatabase
                            .databaseBuilder('app_database.db')
                            .build();
                        final userDao = database.userDao;
                        final uResult=await userDao.findUsername(_uname.text);

                        if(_uname.text!=uResult?.name){
                          if(!isEnable){
                            final user = UserEntity(name: _uname.text, password: _password.text, email: _email.text, fname: _name.text, phno: int.parse(_phNo.text));
                            await userDao.insertUser(user);
                            _formKey.currentState!.save();
                            setState(() {
                              _name.text='';
                              _email.text='';
                              _phNo.text='';
                              _uname.text='';
                              _password.text='';
                              _text2.text='';
                              isEnable=true;
                              _dropValue='Buyer';

                            });
                            const snackBar = SnackBar(
                              content: Text('Add Successfully..'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }else {
                            const snackBar = SnackBar(
                              content: Text('Verify The captcha'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                        }
                        else{
                          const snackBar = SnackBar(
                            content: Text('Please Enter Another username'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }
                      } else {
                       setState(() {
                         isValidate=false;
                       });
                        print('Error');
                      }

                    },
                    icon: const Icon(Icons.edit_attributes, ),
                    label: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,

                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Warning"),
      content: const Text("Please enter correct text."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Verified Successfully"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

enum SingingCharacter { Male, Female
}
