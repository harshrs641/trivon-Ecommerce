import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  String productID,title;
  int price;
  CartButton(this.productID, this.price,this.title);
  @override
  _CartButtonState createState() => _CartButtonState(productID, price,title);
}

class _CartButtonState extends State<CartButton> {
  String productID,title;
  int price;
  _CartButtonState(this.productID, this.price,this.title);
  List<dynamic> products;Map cart;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('/carts')
            .document(userID)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            // List<Map<String,int>>p=snapshots.data.data['products'] as List<Map<String,int>>;
            // p.;
            cart=snapshots.data.data;
            products = snapshots.data.data['products'];
            bool present;
            if (products == null)
              present = false;
            else
              present =
                  cart['products'].any((element) => element['productID'] ==  productID);
            if (present)
              return gotocart();
            else
              return addtocart();
          } else
            return addtocart();
        });
  }

  Widget gotocart() {
    return RaisedButton(
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: Container(
          height: 45,
          padding: EdgeInsets.all(10.0),
          child: Text('Go to Cart',
              style: TextStyle(fontSize: 20, color: Colors.orangeAccent[200])),
        ));
  }

  Widget addtocart() {
    return RaisedButton(
        color: Colors.orangeAccent[200],
        onPressed: () {
          if (products == null){ cart['products'] = [];
          cart['subtotal']=0;
            cart['total']=49;}
          cart['products'].add({'title':title,
            'productID': productID,
            'count': 1,
            'price': price,
            'totalprice': price
          });
          cart['subtotal']=cart['subtotal']+price;
          cart['total']=cart['subtotal']+49;
          Firestore.instance
              .collection('/carts')
              .document(userID)
              .setData(cart, merge: true);
          // setState(() {
          //   inCart = !inCart;
          // });
        },
        child: Container(
            height: 45,
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
  }
}
