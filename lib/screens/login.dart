import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[300],
        body: Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(height: MediaQuery.of(context).size.height/3,),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.orange[300].withOpacity(0.8), BlendMode.dstATop),
                  image: AssetImage('lib/images/loginlogo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => signInGoogle(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 75,
                  width: 275,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Image.asset('lib/images/google.png', height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),SizedBox(height: MediaQuery.of(context).size.height/4,),Text(
              'TRIVON',
              style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.white38,letterSpacing: 5,
                  fontSize: MediaQuery.of(context).size.width / 10),
            ),
            SizedBox(
              height: 10,
            )
          ],
        )));
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult authResult =
        await firebaseAuth.signInWithCredential(authCredential);
    FirebaseUser user = authResult.user;
    //  var persistentCookies = new PersistCookieJar(dir: './cookies/');
      // persistentCookies.deleteAll();
    
// user.
  bool present =await Firestore.instance.collection('users').getDocuments().then((value) => value.documents.any((element) => element.documentID==user.uid));
  if(!present){
    Firestore.instance.collection('users').document(user.uid).setData({'userID':user.uid,'name':user.displayName,'photoUrl':user.photoUrl,'email':user.email,'phoneNumber':user.phoneNumber});
Firestore.instance.collection('wishlists').document(user.uid).setData({'products':[]});
Firestore.instance.collection('carts').document(user.uid).setData({'products':[],'subtotal':0,'total':49});
Firestore.instance.collection('addresses').document(user.uid).setData({'addresses':[]});
// Firestore.instance.collection('')
  }else
  userID=user.uid;
  }
}
