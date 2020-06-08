import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';

class AddReview extends StatefulWidget {
  DocumentSnapshot product;
  AddReview(this.product);
  @override
  _AddReviewState createState() => _AddReviewState(product);
}

class _AddReviewState extends State<AddReview> {
  DocumentSnapshot product;
  _AddReviewState(this.product);
  TextEditingController descriptionController = TextEditingController();
  String description = '';
  double _rating = 0;
  void submit() async{
    if (_rating != 0 && description != '')
    var ref=await  Firestore.instance.collection('reviews').add({
        'userID': userID,
        'productID': product.documentID,
        'description': description,
        'rating': _rating,
        'createdon': DateTime.now()
      });
  var initRating=product.data['rating'];
  var noofRating=product.data['noofrating'];
  var total=noofRating*initRating + _rating;
  noofRating++;
  initRating=total/noofRating;
Firestore.instance.collection('products').document(product.documentID).setData({'rating':initRating,'noofrating':noofRating},merge: true);
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(
            'Add Your Review',
            style: GoogleFonts.montserrat(),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingBar(
              onRatingChanged: (rating) {
                _rating = rating;
              },
              initialRating: 0,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              halfFilledIcon: Icons.star_half,
              isHalfAllowed: true,
              size: 35,
            ),
          ),
          Container(
            height: 200,
            child: TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                  // fillColor: Colors.orange,
                  // hintMaxLines: 19,
                  // helperMaxLines: 50,
                  hintText: 'Describe what you like about our product'),
              controller: descriptionController,
              // minLines: 45,
              maxLines: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                color: Colors.orange[200],
                onPressed: () =>submit(),
                child: Text('ADD', style: GoogleFonts.montserrat())),
          )
        ]));
  }
}
