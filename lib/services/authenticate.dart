import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home.dart';

class GoogleSignInProvider {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user! ;

  Future<void> googleLogIn(BuildContext context) async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      _user= googleUser;
    } else{
      final googleAuth= await googleUser.authentication ;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if(FirebaseAuth.instance.signInWithCredential(credential)!= null){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            }));
      }
      print(FirebaseAuth.instance.signInWithCredential(credential));
    }
  }
}

Future<bool> signInWithEmail(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    return false;
  }
}

