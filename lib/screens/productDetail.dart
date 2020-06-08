// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:ecommerce/widgets/cartbutton.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:ecommerce/widgets/reviewarea.dart';
import 'package:ecommerce/widgets/wishlistbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';

class ProductDetail extends StatefulWidget {
  // var args=ModalRoute.of(context).settings.arguments;

  var argument;
  ProductDetail(this.argument);
  @override
  _ProductDetailState createState() => _ProductDetailState(argument);
}

class _ProductDetailState extends State<ProductDetail> {
  var argument;
  // GlobalKey<ModalRoute> arg=GlobalKey<ModalRoute>();

  _ProductDetailState(this.argument);
  String imageUrl = 'lib/images/mcb.jpg';
  // String title = 'Miniature Circuit Breaker';
  // String subtitle =
  // 'BH-010 miniature circuit breaker - Type C, single pole, 6A';
  // double price = 250.00;
  bool instack = true;
  bool inCart = false;
  bool wishlist = true;
  double rating = 4.0;
  // Map<String, String> techSpecs = {
  //   'Short Circuit Capacity': '10kA',
  //   'Output': '6A',
  //   'Type of overcurrent release': 'Thermal, magnetic',
  //   'Terminal Connection': 'SolderLess',
  //   'Rated Insulation Volatage': '440V'
  // };
  // List<String> features = [
  //   'State of the art Design',
  //   'Can be lockd in on or off position',
  //   'Easy to mount and remove',
  //   'Bi-connect terminals for ultimate flexibility'
  // ];
  @override
  Widget build(BuildContext context) {
    // GlobalKey<ModalRoute> arg=GlobalKey<ModalRoute>();


    String docId = argument;
    print('kerveb' + docId.toString());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        drawer: UniDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBarWidget().appbar(_scaffoldKey, context),
        body: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('products')
                .document(docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot doc = snapshot.data;
                if (doc.data != null)
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 0.0, top: 25),
                            child: Container(width: MediaQuery.of(context).size.width-100,
                              child: Text(
                                doc.data['title'],
                                style: GoogleFonts.ubuntu(fontSize: 22.5),
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 10.0),
                        child: Container(
                            child: Text(
                          doc.data['subtitle'],
                          style: GoogleFonts.quicksand(),
                        )),
                      ), Container(
                        child: Row(
                          children: [
                            RatingBar.readOnly(
                              initialRating: doc.data['rating'].toDouble(),
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,
                              size: 20,
                            ),Text('('+doc.data['rating'].toString()+' Reviews)',style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 275,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imageUrl), fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs.' + doc.data['price'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              '+Rs.49.0 Delivery Charges',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      (doc.data['stock'] == 'instock') ? stock() : outofstock(),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CartButton(doc.documentID, doc.data['price'],
                              doc.data['title'])),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: WishListButton(doc.documentID)),
                      showTech(doc),
                      showFeatures(doc),
                      Reviews(doc)
                    ],
                  );
                else
                  return Container();
              } else
                return Container();
            }));
  }

  Widget stock() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 325),
          child: Text(
            'In Stock',
            style: TextStyle(fontSize: 15.0, color: Colors.teal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Delivers in',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
              Text(
                ' 4-5days',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget outofstock() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 8.0, right: 250),
      child: Text(
        'Out of Stock',
        style: TextStyle(fontSize: 15.0, color: Colors.red),
      ),
    );
  }

  Widget showTech(DocumentSnapshot doc) {
    if (doc.data['techSpecs'] != null)
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Technical Specifications:',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ...doc.data['techSpecs'].entries
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.key, style: GoogleFonts.manrope()),
                            Text(e.value, style: GoogleFonts.manrope())
                          ],
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      );
    else
      return Container();
  }

  Widget showFeatures(DocumentSnapshot doc) {
    if (doc.data['features'] != null)
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Features:',
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                ...doc.data['features']
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_forward_ios),
                              Text(e, style: GoogleFonts.manrope()),
                            ],
                          ),
                        ))
                    .toList()
              ]),
        ),
      );
    else
      return Container();
  }
}
