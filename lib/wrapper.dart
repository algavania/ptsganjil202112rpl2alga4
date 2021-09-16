import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptsganjil202112rpl2alga4/models/user_model.dart';
import 'package:ptsganjil202112rpl2alga4/views/main_menu.dart';
import 'package:ptsganjil202112rpl2alga4/views/auth/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    print('user: $user');

    // return either Home or Authenticate Widget
    if (user == null) {
      return Login();
    } else {
      return MainMenu();
    }
  }
}
