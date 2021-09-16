import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ptsganjil202112rpl2alga4/services/auth.dart';
import 'package:ptsganjil202112rpl2alga4/views/splash_screen.dart';
import 'package:ptsganjil202112rpl2alga4/wrapper.dart';

import 'models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MaterialColor primarySwatch = const MaterialColor(
      0xFF2756CA,
      const <int, Color>{
        50: const Color(0xFF2756CA),
        100: const Color(0xFF2756CA),
        200: const Color(0xFF2756CA),
        300: const Color(0xFF2756CA),
        400: const Color(0xFF2756CA),
        500: const Color(0xFF2756CA),
        600: const Color(0xFF2756CA),
        700: const Color(0xFF2756CA),
        800: const Color(0xFF2756CA),
        900: const Color(0xFF2756CA),
      },
    );

    return StreamProvider<UserModel?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF2756CA),
            primarySwatch: primarySwatch,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    headline6: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600))),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Color(0xFF2756CA),
              ),
            ),
            textSelectionTheme:
                TextSelectionThemeData(selectionColor: Color(0xFFA5D7FF))),
        home: SplashScreen(),
      ),
    );
  }
}
