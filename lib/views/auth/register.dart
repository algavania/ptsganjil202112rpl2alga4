import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptsganjil202112rpl2alga4/services/auth.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_button.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_dialog.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_password_text_field.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_text_field.dart';
import 'package:ptsganjil202112rpl2alga4/shared/loading.dart';
import 'package:ptsganjil202112rpl2alga4/views/auth/login.dart';
import 'package:ptsganjil202112rpl2alga4/wrapper.dart';

class Register extends StatefulWidget {
  static const lightBlue = const Color(0xFFA5D7FF);
  static const mediumBlue = const Color(0xFF2756CA);
  static const darkGray = const Color(0xFF707070);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Register.lightBlue,
        body: isLoading ? Loading() : SafeArea(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/soccer.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: Form(
                  key: _formKey,
                  child: Wrap(
                    children: [
                      CustomTextField('Name', TextInputType.text,
                          _nameController, (value) {
                            if (value.toString().trim().isEmpty)
                              return 'Name can\'t be blank';
                            else
                              return null;
                          }),
                      SizedBox(width: double.infinity, height: 15.0),
                      CustomTextField('Email', TextInputType.emailAddress,
                          _emailController, (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value))
                              return 'Not a valid email address';
                            else
                              return null;
                          }),
                      SizedBox(width: double.infinity, height: 15.0),
                      CustomPasswordTextField(
                          'Password', _passwordController),
                      SizedBox(width: double.infinity, height: 15.0),
                      CustomButton(
                        'Sign up',
                            () {
                          registerWithEmailAndPassword(context);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        width: double.infinity,
                        child: Text('other method',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Register.darkGray)),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          registerWithGoogle(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Register.darkGray),
                          minimumSize: Size(double.infinity, 40.0),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/google_icon.svg',
                              height: 20.0,
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text('Continue with Google',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Register.darkGray)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(color: Register.darkGray),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? '),
                              Text(
                                'Login',
                                style: TextStyle(
                                    color: Register.mediumBlue,
                                    decoration: TextDecoration.underline),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void registerWithEmailAndPassword(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        var result = await _auth.registerWithEmailAndPassword(email, password, name);
        print(result.toString());
        if (result is String) {
          setState(() {
            showErrorDialog(result);
            isLoading = false;
          });
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Wrapper()));
        }
      } catch (err) {
        print(err);
        setState(() {
          showErrorDialog('An error occur while registering you');
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      }
    }
  }

  void registerWithGoogle(BuildContext context) async {
    setState(() => isLoading = true);
    try {
      var result = await _auth.signInWithGoogle();
      print(result.toString());
      if (result == null) {
        setState(() {
          showErrorDialog('An error occur while registering you');
          isLoading = false;
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      }
    } catch (err) {
      print(err);
      setState(() {
        showErrorDialog('An error occur while registering you');
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Wrapper()));
    }
  }

  void showErrorDialog(String error) {
    showDialog(context: context, builder: (context) {
      return CustomDialog(title: 'Error', content: error);
    });
  }
}
