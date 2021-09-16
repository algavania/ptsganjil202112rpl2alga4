import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ptsganjil202112rpl2alga4/models/user_model.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user model object based on FirebaseUser
  UserModel? _userFromFirebaseUser(User user) {
    return UserModel(uid: user.uid);
  }

  // auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password, String name) async {

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      await user.updateDisplayName(name);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "The email address is already in use by another account.";
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Your password is wrong.";
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Invalid email address.";
        default:
          return "Register failed. Please try again.";
      }
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "The email address is already in use by another account.";
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Your password is wrong.";
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          return "Too many requests to log into this account.";
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Invalid email address.";
        default:
          return "Register failed. Please try again.";
      }
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user!;
    return _userFromFirebaseUser(user);
  }

  Future updateUserProfile(User user, String displayName) async {
    try {
      await user.updateDisplayName(displayName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return 'Failed to update profile';
    }
  }


  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}