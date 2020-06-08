// import 'package:ecommerce/categoryArea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/screens/category.dart';
import 'package:ecommerce/screens/mcbsubcategory.dart';
import 'package:ecommerce/widgets/drawer.dart';
import 'package:ecommerce/widgets/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerce/widgets/itemCard.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TabController controller;

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
FirebaseMessaging _messaging=FirebaseMessaging();
  // String imageUrl = 'lib/images/biryani.jpeg';
  // String title = 'Miniature Circuit Breaker';
  // String subtitle =
      // 'BH-010 miniature circuit breaker - Type C, single pole, 6A';

  @override
  Widget build(BuildContext context) {
    _messaging.getToken().then((value) => print(value));
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    // String name;
// name.s
    return Scaffold(
      backgroundColor: Colors.orange[200],
      drawer: UniDrawer(),
      key: _key,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: double.infinity, color: Colors.orangeAccent[200],
                    // color: Color(getColorHexFromStr('#FDD148')),
                  ),
                  Positioned(
                    bottom: 50.0,
                    right: 100.0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.0),
                          // color: Colors.orangeAccent[100]
                          color: Color(getColorHexFromStr('#FEE16D'))
                              .withOpacity(0.4)),
                    ),
                  ),
                  Positioned(
                    bottom: 100.0,
                    left: 150.0,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.0),
                            // color: Colors.amber[600]
                            color: Color(getColorHexFromStr('#FEE16D'))
                                .withOpacity(0.5))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              color: Colors.orangeAccent[200],
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                              onPressed: () => _key.currentState.openDrawer()),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'TRIV',
                                  style: GoogleFonts.ubuntu(
                                      letterSpacing: 5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.5,
                                      color: Colors.teal[300]),
                                ),
                                Image.asset(
                                  'lib/images/invertedeco.png',
                                  alignment: Alignment.topCenter,
                                  height: 27,
                                ),
                                Text('N',
                                    style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.5,
                                      color: Colors.teal[700],
                                    )),
                              ],
                            ),
                          ),
                          IconButton(
                            color: Colors.orangeAccent[200],
                            iconSize: 30,
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/cart');
                            },
                          )
                        ],
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     SizedBox(width: 15.0),
                      //     // Container(
                      //     //   alignment: Alignment.topLeft,
                      //     //   height: 50.0,
                      //     //   width: 50.0,
                      //     //   decoration: BoxDecoration(
                      //     //       borderRadius: BorderRadius.circular(25.0),
                      //     //       border: Border.all(
                      //     //           color: Colors.white,
                      //     //           style: BorderStyle.solid,
                      //     //           width: 2.0),
                      //     //       image: DecorationImage(
                      //     //           image:
                      //     //               AssetImage('lib/images/saahil.jpeg'))),
                      //     // ),
                      //     // SizedBox(
                      //     //     width: MediaQuery.of(context).size.width - 120.0),
                      //     Container(
                      //       alignment: Alignment.topRight,
                      //       child: IconButton(
                      //         icon: Icon(Icons.menu),
                      //         onPressed: () => _key.currentState.openDrawer(),
                      //         color: Colors.white,
                      //         iconSize: 30.0,
                      //       ),
                      //     ),
                      //     SizedBox(height: 15.0),
                      //   ],
                      // ),
                      SizedBox(height: 50.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: StreamBuilder<DocumentSnapshot>(
                            stream: Firestore.instance
                                .collection('users')
                                .document(userID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return Text(
                                  'Hello , ${snapshot.data.data['name'].split(' ')[0]}',
                                  style: GoogleFonts.quicksand(
                                      // fontFamily: 'Quicksand',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                );
                              else
                                return Container();
                            }),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'What do you want to buy?',
                          style: GoogleFonts.quicksand(
                              // fontFamily: 'Quicksand',
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: RaisedButton(
                              color: Colors.grey[100],
                              padding: EdgeInsets.all(10),
                              child: Row(children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.orange[200],
                                  size: 30,
                                ),
                                Text(
                                  '    Search',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.grey, fontSize: 17.5),
                                )
                              ]),
                              onPressed: () => showSearch(
                                  context: context, delegate: SearchWidget()))),
                      SizedBox(height: 10.0)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10.0),
              categoryArea(),
            ],
          )
        ],
      ),
    );
  }

  Widget categoryArea() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 650,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('category').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                physics: new NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return categoryTile(snapshot.data.documents[index].data);
                },
              );
            else
              return CircularProgressIndicator();
          }),
    );
  }

  Widget categoryTile(Map doc) {
    return GestureDetector(
        onTap: () => (doc['categoryID'] == 'mcb1')
            ? Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => McbSubCategory()))
            : Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) =>
                    CategoryScreen(doc['categoryID'], doc['name']))),
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 100, height: 100,
                    // child: Text('harsh'),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(doc['imageurl']),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      doc['name'],
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.teal[200],
                ),
              )
            ],
          ),
        ));
  }
}
