import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ril_state/home.dart';
import 'package:ril_state/logIn.dart';

class CurrentState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var _state=FirebaseAuth.instance.currentUser;
    return _state!=null ? HomePage() : LogIn();
  }
}