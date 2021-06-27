import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_notes_app/utils/snackBarUtil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  /*Google Sign In*/
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User> signInWithGoogle() async {
    User user;
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    var authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    var currentUser = await FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser.uid);
    print("User Name: ${user.displayName}");
    print("User Email ${user.email}");
    return user;
  }

  static Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out Google");
  }

  static bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static Future<UserCredential> signInWithEmailPassword(
      {String email, String password, BuildContext context}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        signUpWithEmailPassword(email: email, password: password);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<UserCredential> signUpWithEmailPassword(
      {String email, String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("SignUp: $userCredential");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

  static Future<User> getCurrentUser() async {
    User user = await FirebaseAuth.instance.currentUser;
//    print("User: ${user?.email ?? "None"}");
    return user;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    print("Sign Out");
  }

  static Future deleteCurrentUser() async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}
