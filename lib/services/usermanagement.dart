// import 'dart:js';

import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/screens/homescreen.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManagement {
  auth() {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            userID=snapshot.data.uid;
            // snapshot.data
            return HomeScreen();
          } else {
            return LogIn();
          }
        });
  }
}
