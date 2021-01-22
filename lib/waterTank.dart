import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:http/http.dart' as http;
class waterTank extends StatefulWidget {
  String name;
  waterTank(this.name);
  @override
  _waterTankState createState() => _waterTankState();
}

class _waterTankState extends State<waterTank> {
  double size1 = 0.9000;
  double size2 = 0.9000;
  double size3 = 0.9000;
  int i=1;
  List data;
  List data_value;
  bool result = false;
  bool result2 = false;
  Timer timer;
  Future<http.Response> call() async {
    //final response = await http.get('http://192.168.101.18:8000/key/');
    final response = await http.get(
        'http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.name}&query=table');
    if (response.statusCode == 200) {

      // print("response: ${response.statusCode}");
      setState(() {
        data = jsonDecode(response.body);
      });

      print("values $data");
      print("response: ${response.body}");
      result = true;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<bool> call_value() async {
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.name}&query=value');
    //final response = await http.get('192.168.0.107:8000/value/');
    //final response = await http.get('http://192.168.101.18:8000/value/');
    if (response.statusCode == 200) {

      // print("response: ${response.statusCode}");
      setState(() {
        data_value = jsonDecode(response.body);

      });
      print("response 2: ${response.body}");
      result2 = true;

      Future.delayed(const Duration(seconds: 2), () {

// Here you can write your code

        setState(() {
          print("after");
          for(int i=0; i<data_value[0].length;i++) {
            print(data_value[0][i]);
            data_value[0][i] = data_value[0][i];
          }

          // _buildButtonsWithNames();


          // Here you can write your code for open new view
        });

      });
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result2 = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return true;
  }
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
    DecorationImage backgroundImage,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height*0.95,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: backgroundColor,
        backgroundImage: backgroundImage,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    );
  }
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    check().then((intenet) {
      if (intenet) {
        call().then((value) => call_value());
      }
      else {
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  backgroundColor: Colors.black,
                  title: Text(
                    "No Internet Connection",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                      "Please check your Internet Connection",
                      style: TextStyle(color: Colors.white)),
                ));
        //print("Connection: not present");
      }
    });
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>
        check().then((intenet) {
          if (intenet) {
            call().then((value) => call_value());
            getLevel();
          }
          else {
            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        "No Internet Connection",
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                          "Please check your Internet Connection",
                          style: TextStyle(color: Colors.white)),
                    ));
          }
        }));
    super.initState();
  }
  String level;
  double inc;
  String prev;
  int i1,i2=1;
  String getLevel(){
    for(int i=0;i<data.length;i++){
      if(data[i].toString().contains("level")){
        setState(() {
          level=data_value[0][i];
          i1=int.parse(level);
          if(size1>0.02 /*&& prev!=level*/ && (i1>=1 && i1<=5)) {
            size1 = 0.0100;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>5&& i1<=10)) {
            size1 = 0.0500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>10 && i1<=20)) {
            size1 = 0.1000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>20 && i1<=30)) {
            size1 = 0.1500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>30 && i1<=40)) {
            size1 = 0.2000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>40 && i1<=50)) {
            size1 = 0.2500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>50 && i1<=60)) {
            size1 = 0.3000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>60 && i1<=70)) {
            size1 = 0.3500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>70 && i1<=80)) {
            size1 = 0.4000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>80 && i1<=90)) {
            size1 = 0.4500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>90 && i1<=100)) {
            size1 = 0.5000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>100 && i1<=110)) {
            size1 = 0.5500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>110 && i1<=120)) {
            size1 = 0.6000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>120 && i1<=130)) {
            size1 = 0.6500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>130 && i1<=140)) {
            size1 = 0.7000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>140&& i1<=150)) {
            size1 = 0.7500;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>150&& i1<=160)) {
            size1 = 0.8000;
          }
          else if(size1>0.02 /*&& prev!=level*/ && (i1>160)) {
            size1 = 0.9000;
          }

        });
      }
    }
    print("level $level");
    return level;
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: result && result2?Stack(
          children: [
            Container(
              child:  _buildCard(
                  config: CustomConfig(
                    colors: [
                      Colors.blue[300],
                      Colors.blue[300],
                      Colors.blue[300],
                    ],
                    durations: [2200, 5000, 6000],
                    heightPercentages: [size1,size1,size1],
                  ),
                  backgroundColor: Colors.blueGrey[800]
              ),
            ),
            Center(
              child: Container(
                width: width*0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white,
                      width: 5
                  ),
                ),
                child: Center(
                  child: Text(getLevel().toString(),style: GoogleFonts.robotoSlab(fontSize: 30,color: Colors.white,letterSpacing: 2)),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                      Navigator.pop(context);
                    }),
                    SizedBox(width: width*0.2,),
                    Text("Water Level",style: GoogleFonts.robotoSlab(fontSize: 20,color: Colors.white),),

                  ],
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                )
              ],
            )
          ],
        ):Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  Path _buildSpeechBubblePath(BuildContext context) {
    return Path()..addRect(Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width*1,  MediaQuery.of(context).size.height*0.89));
  }
}
