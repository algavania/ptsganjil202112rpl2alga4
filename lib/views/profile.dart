import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ptsganjil202112rpl2alga4/services/auth.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_button.dart';
import 'package:ptsganjil202112rpl2alga4/shared/custom_text_field.dart';
import 'package:ptsganjil202112rpl2alga4/shared/loading.dart';

class Profile extends StatefulWidget {
  final Function changeName;

  const Profile({Key? key, required this.changeName}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _currentAuth = FirebaseAuth.instance;
  TextEditingController _nameController = TextEditingController();
  AuthService _authService = AuthService();
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String name = _currentAuth.currentUser!.displayName.toString();
    _nameController.text = name;
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    String photoUrl = _currentAuth.currentUser!.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/soccer-app-f976e.appspot.com/o/default.jpg?alt=media&token=745342dd-e5b2-4b1b-8727-b21e48b94380';
    return isLoading ? Loading() : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 85.0,
                  height: 85.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: double.infinity, height: 25.0),
          CustomTextField('Name', TextInputType.text,
              _nameController, (value) {
                if (value.toString().trim().isEmpty)
                  return 'Name can\'t be blank';
                else
                  return null;
              }),
          SizedBox(width: double.infinity, height: 25.0),
          CustomButton('Save Changes', () async {
            setState(() {
              isLoading = true;
            });
            var res = await _authService.updateUserProfile(_currentAuth.currentUser!, _nameController.text);
            setState(() {
              isLoading = false;
            });
            if (res is String) {
              _showToast(res, 'error');
            } else {
              widget.changeName(_nameController.text);
              _showToast('Profile has been updated!', 'success');
            }
          }),
        ],
      ),
    );
  }

  void _showToast(String message, String type) {
    Color color = Colors.white;
    Icon icon = Icon(Icons.check);
    if (type == 'success') {
      color = Colors.green;
      icon = Icon(Icons.check, color: Colors.white);
    } else if (type == 'error') {
      color = Colors.white;
      icon = Icon(Icons.error);
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
