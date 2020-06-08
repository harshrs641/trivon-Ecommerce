import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_bar/rating_bar.dart';

class EditReview extends StatefulWidget {
  DocumentSnapshot doc;
    DocumentSnapshot product;

  EditReview(this.doc,this.product);
  @override
  _EditReviewState createState() => _EditReviewState(doc,product);
}

class _EditReviewState extends State<EditReview> {
  DocumentSnapshot doc;
    DocumentSnapshot product;

  _EditReviewState(this.doc, this.product);
  TextEditingController descriptionController = TextEditingController();
  String description;
  double _rating;
    var _initrating;
      var _noofrating;


  void initState() {
    descriptionController.text = doc.data['description'];
    description = doc.data['description'];
    _rating = doc.data['rating'];
_initrating=product.data['rating'];
_noofrating=product.data['noofrating'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text('Edit Your Review'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar(
                onRatingChanged: (rating) {
                  _rating = rating;
                },
                initialRating: _rating,
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
                  description = value.trim();
                },
                decoration: InputDecoration(
                    // fillColor: Colors.orange,
                    // hintMaxLines: 19,
                    // helperMaxLines: 50,
                    // hintText: 'Describe what you like about our product'),
                    ),
                controller: descriptionController,
                // minLines: 45,
                maxLines: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  color: Colors.orange[200],
                  onPressed: () {
                    Firestore.instance
                        .collection('reviews')
                        .document(doc.documentID)
                        .setData(
                            {'rating': _rating, 'description': description},
                            merge: true);
                            _initrating=_initrating+((_rating-_initrating)/_noofrating);
                            Firestore.instance.collection('products').document(product.documentID).setData({'rating':_initrating},merge:true);
                    Navigator.of(context).pop();
                  },
                  child: Text('Save', style: GoogleFonts.montserrat())),
            )
          ],
        ));
  }
}
