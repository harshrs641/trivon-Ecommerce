// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/productDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';


class ItemCard extends StatefulWidget {
  String title, imgPath, subtitle;
  DocumentSnapshot doc;
  // bool isFavorite;
  ItemCard(this.doc);
  @override
  _ItemCardState createState() => _ItemCardState(doc);
}

class _ItemCardState extends State<ItemCard> {
  String title, imgPath='lib/images/mcb.jpg', subtitle;
    DocumentSnapshot doc;

  //  bool isFavorite;
  _ItemCardState(this.doc);
  // var rating = 4.0;
  String price = '250';
  @override
  Widget build(BuildContext context) {
    print('docId:'+doc.documentID);
    String docID=doc.documentID;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(onTap: ()=>Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>ProductDetail(docID))) ,
              child: Card(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(19),),elevation: 5,
                              child: Container(
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: Colors.orange[50]),
            child: Row(children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(image: AssetImage(imgPath))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width - 215,
                          child: Text(
                            doc.data['title'],
                            style: GoogleFonts.ubuntu(fontSize: 17.5),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width - 175,
                          child: Text(
                           doc.data['subtitle'],
                            style: GoogleFonts.quicksand(),
                          )),
                    ),RatingBar.readOnly(
                              initialRating: doc.data['rating'].toDouble(),
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,
                              size: 20,
                            ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Rs.'+doc.data['price'].toString(),
                        style:
                            TextStyle(fontSize: 25, color: Colors.red[900]),
                      ),
                    )
                  ],
                )
            ])),
              ),
      ),
    );
  }
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
//       child: GestureDetector(onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetail())),
//               child: Container(
//           height: 150.0,
//           width: double.infinity,
//           color: Colors.white,
//           child: Row(
//             children: <Widget>[
//               Container(
//                 width: 140.0,
//                 height: 150.0,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(imgPath), fit: BoxFit.cover)),
//               ),
//               SizedBox(width: 4.0),
//               Column(mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         title,textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 17.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       // SizedBox(width: 40.0),
//                       // Material(
//                       //   elevation: isFavorite ? 0.0 : 2.0,
//                       //   borderRadius: BorderRadius.circular(20.0),
//                       //   child: Container(
//                       //     height: 40.0,
//                       //     width: 40.0,
//                       //     decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(20.0),
//                       //         color: isFavorite
//                       //             ? Colors.grey.withOpacity(0.2)
//                       //             : Colors.white),
//                       //     child: Center(
//                       //       child: isFavorite
//                       //           ? Icon(Icons.favorite_border)
//                       //           : Icon(Icons.favorite, color: Colors.red),
//                       //     ),
//                       //   ),
//                       // )
//                     ],
//                   ),
//                   SizedBox(height: 5.0),
//                   Container(
//                     width: 175.0,
//                     child: Text(
//                       'High Speed Fan',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: 'Quicksand',
//                           color: Colors.grey,
//                           fontSize: 12.0),
//                     ),
//                   ),
//                   SizedBox(height: 5.0),
//                   Center(
//               child: SmoothStarRating(
//             rating: rating,
//             size: 20,
//             filledIconData: Icons.star,
//             halfFilledIconData: Icons.star_half,
//             defaultIconData: Icons.star_border,
//             starCount: 5,
//             allowHalfRating: true,
//             spacing: 2.0,
//             onRated: (value) {
//               print("rating value -> $value");
//               // print("rating value dd -> ${value.truncate()}");
//             },
//           )),
//                   Row(
//                     children: <Widget>[
//                       SizedBox(width: 35.0),
//                       Container(
//                         height: 40.0,
//                         width: 50.0,
//                         color: Colors.yellow[900],
//                         child: Center(
//                           child: Text(
//                             'Rs.248',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Quicksand',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 40.0,
//                         width: 100.0,
//                         color: Colors.lime,
//                         child: Center(
//                           child: Text(
//                             'Add to cart',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Quicksand',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
}
