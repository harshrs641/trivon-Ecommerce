import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:ecommerce/widgets/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().appbar(_key, context),
        key: _key,
        drawer: UniDrawer(),
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('wishlists')
                .document(userID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data['products'].length!=0)
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        child: Center(
                          child: Text(
                            'Your Wish List',
                            style: GoogleFonts.spartan(
                             color:  Colors.blueGrey[400],
                              fontSize: 35
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView(children: [
                          ...snapshot.data.data['products'].map((productID) =>
                              StreamBuilder<DocumentSnapshot>(
                                  stream: Firestore.instance
                                      .collection('products')
                                      .document(productID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData)
                                      return ItemCard(snapshot.data);
                                    else
                                      return Container();
                                  })),
                        ]),
                      )
                    ],
                  );
                else
                  return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.favorite,size: 50,color: Colors.grey,),
                      Text('Your Wish List is Empty',style:GoogleFonts.quicksand(color: Colors.grey)),
                    ],
                  ));
              } else
                return Container();
            }));
  }
}
