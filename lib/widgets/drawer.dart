import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UniDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String name = 'Harsh Raj Singh';/
    // String email = 'harshrajsingh2001@gmail.com';
    // String imageUrl = 'lib/images/mcb.jpg';
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(userID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return DrawerHeader(
                    padding: EdgeInsets.only(top: 75, left: 0.0),
                    decoration: BoxDecoration(color: Colors.orange[300]),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(snapshot.data.data['photoUrl']),
                      ),
                      title: Text(snapshot.data.data['name'],
                          style: TextStyle(fontSize: 15)),
                      subtitle: Text(
                        snapshot.data.data['email'],
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  );
                else
                  return Container();
              }),
          GestureDetector(
            onTap: () => Navigator.of(context).popAndPushNamed('/home'),
            child: Card(
              elevation: 0,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.home),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Home',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    )
                  ],
                ),
              ),
              // elevation: 0,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).popAndPushNamed('/address'),
            child: Card(
              elevation: 0,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Manage Addresses',
                        style: TextStyle(fontSize: 17.5),
                      ),
                    )
                  ],
                ),
              ),
              // elevation: 0,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).popAndPushNamed('/orderhistory'),
            child: Card(
              elevation: 0,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.history),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Your Orders', style: TextStyle(fontSize: 17.5)),
                    )
                  ],
                ),
              ),
              // elevation: 5,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).popAndPushNamed('/wishlist'),
            child: Card(
              elevation: 0,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Your Wish List',
                          style: TextStyle(fontSize: 17.5)),
                    )
                  ],
                ),
              ),
              // elevation: 5,
            ),
          ),
          GestureDetector(
            child: Card(
              elevation: 0,
              color: Colors.orange[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.headset_mic),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Customer Support',
                          style: TextStyle(fontSize: 17.5)),
                    )
                  ],
                ),
              ),
              // elevation: 5,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text('Not You?'),
              FlatButton(
                  child: Text('Sign Out',
                      style: TextStyle(color: Colors.blueAccent)),
                  onPressed: () {FirebaseAuth.instance
                      .signOut()
                      .then((value) => GoogleSignIn().signOut());Navigator.of(context).popUntil((route) => route.isFirst);})
            ]),
          )
        ],
      ),
    ));
  }
}
