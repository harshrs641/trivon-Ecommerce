// import 'package:ecommerce/homescreen.dart';

// import 'dart:js';

// import 'dart:js';

// import 'dart:js';

// import 'dart:js';

import 'package:ecommerce/screens/addaddresspage.dart';
import 'package:ecommerce/screens/addresspage.dart';
import 'package:ecommerce/screens/addresspagecheckout.dart';
import 'package:ecommerce/screens/addreview.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/category.dart';
import 'package:ecommerce/screens/checkoutconfirmation.dart';
import 'package:ecommerce/screens/homescreen.dart';
import 'package:ecommerce/screens/justadd.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/orderhistory.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:ecommerce/screens/thankyou.dart';
import 'package:ecommerce/screens/wishlist.dart';
import 'package:ecommerce/services/usermanagement.dart';
import 'package:ecommerce/widgets/addtosearch.dart';
import 'package:ecommerce/widgets/reviewarea.dart';
import 'package:ecommerce/widgets/screentransition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:ecommerce/productDetail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var route = {
    // '/a': (context) => AddToSearch(),
    '/login': (context) => LogIn(),
    '/address': (context) => AddressPage(),
    '/home': (context) =>HomeScreen(),
    '/': (context) => JustAdd(),
    '/cart': (context) => CartPage(),
    '/productdetail': (context) => ProductDetail(ModalRoute.of(context).settings.arguments),
    '/orderhistory': (context) => OrderHistory(),
    '/thankyou': (context) => ThankYou(),
    '/addAddress': (context) => AddAddressPage(),
    '/addresscheckout': (context) => AddressCheckOutPage(),
    '/checkout': (context) => CheckOut(),
    // '/category': (context) => CategoryScreen(),
    '/wishlist': (context) => WishList()
    // ,'/':(context)=>AddReview()
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: UserManagement().auth(),
        // initialRoute: '/',
        onGenerateRoute: (settings) {
          return CupertinoPageRoute(
              builder: (context) => route[settings.name](context));
        });
  }
}
