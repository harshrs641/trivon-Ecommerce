import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  bool completed = false;
  void initState() {
    controller = AnimationController(
        vsync: this, value: .1, duration: Duration(milliseconds: 3000));
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) setState(() => completed = true);
    });
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{Navigator.of(context).popUntil((route) => route.isFirst );return false;},
          child: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  child: ScaleTransition(
                      scale: animation,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.orange[300],
                        size: 100,
                      ))),
            ),  (completed)
                  ? Column(
                      children: [
                        Text('Order has been placed successfully',
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 20,
                            )),SizedBox(height: 25,),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            color: Colors.white,
                            onPressed: () {Navigator.of(context).popUntil((route) => route.isFirst );},
                            child: Text(
                              'Continue Shopping',
                              style: GoogleFonts.libreFranklin(),
                            ))
                      ],
                    )
                  : Container()
          ],
        ),
      ),
    );
  }
}
