import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2alga4/views/home.dart';
import 'package:ptsganjil202112rpl2alga4/views/profile.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  Widget _body = Home();
  String _appBarTitle = 'Soccer App';
  final _currentAuth = FirebaseAuth.instance;
  String _name = '';
  late Function changeName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = _currentAuth.currentUser!.displayName.toString();
    changeName = (String name) {
      setState(() {
        _name = name;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    String photoUrl = _currentAuth.currentUser!.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/soccer-app-f976e.appspot.com/o/default.jpg?alt=media&token=745342dd-e5b2-4b1b-8727-b21e48b94380';
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle), elevation: 0),
      body: _body,
      drawer: Container(
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            color: Colors.white,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                    accountName: Text(_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    accountEmail: Text(_currentAuth.currentUser!.email.toString(), style: TextStyle(fontWeight: FontWeight.w300))
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    setState(() {
                      _appBarTitle = 'Soccer App';
                      _body = Home();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () {
                    setState(() {
                      _appBarTitle = 'Profile';
                      _body = Profile(changeName: changeName);
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.black),
                  title: Text('Logout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  onTap: () async {
                    Navigator.pop(context);
                    await _currentAuth.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
