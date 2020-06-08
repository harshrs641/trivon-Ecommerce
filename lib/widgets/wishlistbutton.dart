import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';

class WishListButton extends StatefulWidget {
  String productID;
  WishListButton(this.productID);
  @override
  _WishListButtonState createState() => _WishListButtonState(productID);
}

class _WishListButtonState extends State<WishListButton> {
  String productID;
  _WishListButtonState(this.productID);
  List products;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('wishlists')
            .document(userID)
            
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            products=snapshot.data.data['products'];
            bool present;
            if(products==null)
            present=false; 
            else
            present=products.any((element) => element==productID);
            if (present)
              return removewishlist();
            else
              return addtowish();
          } else
            return removewishlist();
        });
  }

  Widget addtowish() {
    return RaisedButton(
        color: Colors.red[300],
        onPressed: () {
          if(products==null)
          products=[];
          products..add(productID);
          Firestore.instance
              .collection('wishlists')
              .document(userID)
              
              .setData({'products': products});
        },
        child: Container(
            height: 45,
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Add to WishList',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget removewishlist() {
    return RaisedButton(
        color: Colors.white,
        onPressed: () {
          products.remove(productID);
          Firestore.instance.collection('wishlists').document(userID).setData({'products':products});
        },
        child: Container(
          height: 45,
          padding: EdgeInsets.all(10.0),
          child: Text('Remove From WishList',
              style: TextStyle(fontSize: 20, color: Colors.red[300])),
        ));
  }
}
