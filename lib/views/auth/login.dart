import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ptsganjil202112rpl2alga4/services/auth.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_button.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_dialog.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_password_text_field.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_text_field.dart';
import 'package:ptsganjil202112rpl2alga4/shared/loading.dart';
import 'package:ptsganjil202112rpl2alga4/views/auth/register.dart';
import 'package:ptsganjil202112rpl2alga4/wrapper.dart';

class Login extends StatefulWidget {
  static const lightBlue = const Color(0xFFA5D7FF);
  static const mediumBlue = const Color(0xFF2756CA);
  static const darkGray = const Color(0xFF707070);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Login.lightBlue,
        body: isLoading ? Loading() : SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
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
                        'Login',
                            () {
                          signInWithEmailAndPassword(context);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        width: double.infinity,
                        child: Text('other method',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Login.darkGray)),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          signInWithGoogle(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Login.darkGray),
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
                                  style: TextStyle(color: Login.darkGray)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(color: Login.darkGray),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account? '),
                              Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Login.mediumBlue,
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

  void signInWithEmailAndPassword(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        var result = await _auth.signInWithEmailAndPassword(email, password);
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
          showErrorDialog('An error occur while logging you in');
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      }
    }
  }

  void signInWithGoogle(BuildContext context) async {
    setState(() => isLoading = true);
    try {
      var result = await _auth.signInWithGoogle();
      print(result.toString());
      if (result == null) {
        setState(() {
          showErrorDialog('An error occur while logging you in');
          isLoading = false;
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      }
    } catch (err) {
      print(err);
      setState(() {
        showErrorDialog('An error occur while logging you in');
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
