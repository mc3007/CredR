import 'package:flutter/material.dart';
import 'package:ril_state/services/authenticate.dart';

import 'logIn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: ()async {
            bool condition = await signOut();
            if (condition) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return LogIn();
                }),
                    (route) => false,
              );
            }
          },
          child: Text("Log Out"))
    );
  }
}
