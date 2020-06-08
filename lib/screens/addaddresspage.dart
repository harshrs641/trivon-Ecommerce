import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/globalVar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  // void _handleSubmitted() {
  //   final FormState form = _formKey.currentState;
  //   if (!form.validate()) {
  //     // _autovalidate = true; // Start validating on every change.
  //     // showInSnackBar('Please fix the errors in red before submitting.');
  //   } else {
  //     // showInSnackBar('snackchat');
  //     // User.instance.first_name = firstName;
  //     // User.instance.last_name = lastName;

  //     // User.instance.save().then((result) {
  //     //   print("Saving done: ${result}.");
  //     // });
  //   }
  // }

  // // controllers for form text controllers
  // final TextEditingController _firstNameController = new TextEditingController();
  // String firstName = 'Hrarsh';
  // final TextEditingController _lastNameController = new TextEditingController();
  // String lastName ='singh';

  // @override
  // void initState() {
  //   _firstNameController.text = firstName;
  //   _lastNameController.text = lastName;
  //   return super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final ThemeData themeData = Theme.of(context);
  //   final DateTime today = new DateTime.now();

  //   return new Scaffold(
  //       appBar: new AppBar(title: const Text('Edit Profile'), actions: <Widget>[
  //         new Container(
  //             padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
  //             child: new MaterialButton(
  //               color: themeData.primaryColor,
  //               textColor: themeData.secondaryHeaderColor,
  //               child: new Text('Save'),
  //               onPressed: () {
  //                 _handleSubmitted();
  //                 // Navigator.pop(context);
  //               },
  //             ))
  //       ]),
  //       body: new Form(
  //           key: _formKey,
  //           autovalidate: true,
  //           // onWillPop: _warnUserAboutInvalidData,
  //           child: new ListView(
  //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //             children: <Widget>[
  //               new Container(
  //                 child: new TextField(
  //                   decoration: const InputDecoration(labelText: "First Name", hintText: "What do people call you?"),
  //                   autocorrect: false,
  //                   controller: _firstNameController,
  //                   onChanged: (String value) {
  //                     firstName = value;
  //                   },
  //                 ),
  //               ),
  //               new Container(
  //                 child: new TextField(
  //                   decoration: const InputDecoration(labelText: "Last Name"),
  //                   autocorrect: false,
  //                   controller: _lastNameController,
  //                   onChanged: (String value) {
  //                     lastName = value;
  //                   },
  //                 ),
  //               ),
  //             ],
  //           )));
  // }
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();
    TextEditingController address4 = TextEditingController();

  TextEditingController phone = TextEditingController();
    TextEditingController phoneAlter = TextEditingController();

  String tempName = '',
      tempAdd1 = '',
      tempAdd2 = '',
      tempAdd3 = '',      tempAdd4 = '',

      tempPhone = '',
      tempAlter = '';
  void initState() {
    name.text = '';
    address1.text = '';
    address2.text = '';
    address3.text = '';
        address4.text = '';

    phone.text = '';
    super.initState();
  }

  void snack() {
    _key.currentState.showSnackBar(SnackBar(content: Text('Please Enter the required Fields')));
  }

  void submit()async {
    if (tempName == '' ||
        tempAdd1 == '' ||
        tempAdd2 == '' ||
        tempAdd3 == '' ||        tempAdd4 == '' ||

        tempPhone == '') {
      snack();
    } else {
      var allAddress=await Firestore.instance.collection('addresses').document(userID).get().then((value) => value.data);
      if(allAddress['addresses']==null)
      allAddress['addresses']=[];
      allAddress['addresses'].add({'name':tempName,'street':tempAdd1,'landmark':tempAdd2,'area':tempAdd3,'pincode':tempAdd4,'phone':tempPhone,'alterphone':tempAlter});
       Firestore.instance.collection('addresses').document(userID).setData(allAddress);
       Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0,backgroundColor:Colors.orange[300],title:Text('Add Address',style: GoogleFonts.raleway(),)),
        key: _key,backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => tempName = value.trim(),
                controller: name,
                decoration: InputDecoration(labelText: 'Name*'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (value) => tempAdd1 = value.trim(),
                  controller: address1,
                  decoration: InputDecoration(
                    labelText: 'Flat No., Street Name*',
                  )),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (value) => tempAdd2 = value.trim(),
                  controller: address2,
                  decoration: InputDecoration(
                    labelText: 'Land Mark*',
                  )),
            ),   Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (value) => tempAdd3 = value.trim(),
                  controller: address3,
                  decoration: InputDecoration(
                    labelText: 'Area*',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (value) => tempAdd4 = value.trim(),
                  controller: address4,
                  decoration: InputDecoration(
                    labelText: 'Pin Code(Delivery only in Kolkata)*',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => tempPhone = value.trim(),
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number*',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => tempAlter = value.trim(),
                  controller: phoneAlter,
                  decoration: InputDecoration(
                    labelText: 'Alternate Number(Optional)',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(color: Colors.orangeAccent[100],onPressed: () => submit(),child: Text('Add',style: GoogleFonts.raleway()),),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(alignment:Alignment.centerRight,child:Text('*required',style: TextStyle(color: Colors.grey),)),
            )
          ],
        ));
  }
}
