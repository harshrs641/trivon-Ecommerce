import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:ecommerce/screens/addreview.dart';
import 'package:ecommerce/screens/editreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:rating_bar/rating_bar.dart';

class Reviews extends StatefulWidget {
  DocumentSnapshot product;
  Reviews(this.product);
  @override
  _ReviewsState createState() => _ReviewsState(product);
}

class _ReviewsState extends State<Reviews> {
  DocumentSnapshot product;
  _ReviewsState(this.product);
  bool showing = false;
  String reviewDis =
      'eigfvhekjvhe iebve hfuh3 gufi3gf3h b giu3g fbfugff fi3gf   fbi3gfiu3gfbbf bgigbfbgk3bb f';
  double rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => setState(() => showing = !showing),
            child: Row(
              children: [
                Container(
                    child: Text(
                  'Reviews',
                  style: GoogleFonts.montserrat(fontSize: 25),
                )),
                showing
                    ? Icon(Icons.arrow_drop_up)
                    : Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
        ),
        (showing)
            ? StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('reviews')
                    .where('productID', isEqualTo: product.documentID)
                    // .orderBy('rating', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Column(
                      children: [
                        snapshot.data.documents.any(
                                (element) => element.data['userID'] == userID)
                            ? Container()
                            : FlatButton(
                                onPressed: () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            AddReview(product))),
                                child: Text('+Add Your Review',style: GoogleFonts.montserrat(color:Colors.orange[600]),),
                              ),
                         ...snapshot.data.documents.map((e) => review(e))
                      ],
                    );
                  else
                    return Container();
                },
              )
            : Container(),
      ],
    );
  }

  // double _rating = 3.5;
  Widget review(DocumentSnapshot info) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/images/mcb.jpg'),
                  ),
                  Text(
                    info.data['userID'],
                    style: TextStyle(fontSize: 25),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.readOnly(
                      initialRating: info.data['rating'],
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      size: 30,
                    ),
                    Container(
                        child: Text(DateFormat.yMMMd()
                            .format(info.data['createdon'].toDate())))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    info.data['description'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                (userID == info.data['userID'])
                    ? RaisedButton(
                        onPressed: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) => EditReview(info,product))),
                        child: Text('Edit Your Review'))
                    : Container()
              ],
            ),
          )),
    );
  }
}
