import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Container(margin:EdgeInsets.only(bottom: height*0.06),child: Center(child: Text("Setup soon!",style: GoogleFonts.robotoSlab(fontSize: 18,color: Colors.white),))),
              height: height*0.15,
              width: width*1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue[600],
                      Colors.blue[500],
                      Colors.blue[400],
                    ]
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:height*0.09),
              width: width*12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight:Radius.elliptical(20,20) ),
                  color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Center(child: Image.asset("assets/error.gif")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
