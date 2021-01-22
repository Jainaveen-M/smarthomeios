import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DemoButtons extends StatefulWidget {
  String email;
  String place;
  int ind;
  String ipAddress;
  DemoButtons(this.email,this.place,this.ind,this.ipAddress);
  @override
  _DemoButtonsState createState() => _DemoButtonsState();
}

class _DemoButtonsState extends State<DemoButtons> {
  List data;
  List name=[];
  List pg= [];
  Future get_name() async{
    //final response = await http.get('http://${widget.ipAddress}/key/');
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    //final response = await http.get('192.168.0.107:8000/key/');
    var fetchdata = jsonDecode(response.body);
    if(response.statusCode ==200){
      setState(() {
        data = fetchdata;
      });

      for(int i=0;i<data.length;i++){
        if(data[i].toString().contains("_Admin_Room") && (!name.contains(data[i].toString().contains("Admin_Room")))){
          name.add("Admin_Room");
          pg.add( "Admin_Room" );
        }
        else if(data[i].toString().contains("_Hall") && (!name.contains(data[i].toString().contains("Hall")))){
          name.add("Hall");
          pg.add("Hall");
        }
        else if(data[i].toString().contains("Living_Room") && (!name.contains(data[i].toString().contains("Living_Room")))){
          name.add("Living_Room");
          pg.add("Living_Room");
        }
        else if(data[i].toString().contains("_Garage") && (!name.contains(data[i].toString().contains("Garage")))){
          name.add("Garage");
          pg.add("Garage");
        }
        else if(data[i].toString().contains("_Kitchen") && (!name.contains(data[i].toString().contains("Kitchen")))){
          name.add("Kitchen");
          pg.add("Kitchen");
        }
        else if(data[i].toString().contains("Master_Bedroom") && (!name.contains(data[i].toString().contains("Master_Bedroom")))){
          name.add("Master_Bedroom");
          pg.add("Master_Bedroom");
        }
        else if(data[i].toString().contains("_Bedroom") && (!name.contains(data[i].toString().contains("Bedroom")))){
          name.add("Bedroom");
          pg.add("Bedroom");
        }
        else if(data[i].toString().contains("_Bedroom1") && (!name.contains(data[i].toString().contains("Bedroom_1")))){
          name.add("Bedroom_1");
          pg.add("Bedroom_1");
        }
        else if(data[i].toString().contains("_Bedroom2") && (!name.contains(data[i].toString().contains("Bedroom_2")))){
          name.add("Bedroom_2");
          pg.add("Bedroom_2");
        }
        else if(data[i].toString().contains("_Store_Room") && (!name.contains(data[i].toString().contains("Store_Room")))){
          name.add("Store_Room");
          pg.add("Store_Room");
        }
        else if(data[i].toString().contains("_Outside") && (!name.contains(data[i].toString().contains("Outside")))){
          name.add("Outside");
          pg.add("Outside");
        }
        else if(data[i].toString().contains("_Parking") && (!name.contains(data[i].toString().contains("Parking")))){
          name.add("Parking");
          pg.add("Parking");
        }
        else if(data[i].toString().contains("_Outside") && (!name.contains(data[i].toString().contains("Outside")))){
          name.add("Outside");
          pg.add("Outside");
        }
        else if(data[i].toString().contains("_Garden") && (!name.contains(data[i].toString().contains("Garden")))){
          name.add("Garden");
          pg.add("Garden");
        }
      }
    }
    setState(() {
      name=name.toSet().toList();
      pg=pg.toSet().toList();
      print(name);

    });
    return "success";
  }
  Future printSharedList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i=0;i<data.length;i++){
      String t = await prefs.getString(data[i]);
      print("key : ${data[i]} value : $t");
    }
  }
  @override
  void initState() {
    get_name();
    print("email ${widget.email} place${widget.place} ind${widget.ind} ");
    printSharedList();
  }

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
            itemCount: pg.length,
            itemBuilder: (context,index){
              if (index==0) {
                return Pages(widget.email,name[widget.ind].toString(),widget.ipAddress);
              }
              else if(index==widget.ind){
                return Pages(widget.email,name[0].toString(),widget.ipAddress);
              }
              else{
                return Pages(widget.email,name[index].toString(),widget.ipAddress);
              }
            }),
      ),
    );
  }
}
class Pages extends StatefulWidget {
  String email;
  String room_name;
  String ipAddress;
  Pages(this.email,this.room_name,this.ipAddress);
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> with WidgetsBindingObserver  {
  List<Widget>  _buildButtonsWithNames() {
    buttonsList.clear();
    for (int i = 0; i < data.length; i++)
    {
      button(i);
    }
    setState(() {
      buttonsList = buttonsList.toSet().toList();
    });
    return buttonsList;
  }
  String up;
  void button(int i) {
    buttonsList.add((data[i].toString().contains("Button") && data[i].toString().contains(widget.room_name))
        ? Container(
      child: InkWell(
        onTap: () {
          check().then((intenet) {
            if (intenet) {
              // Internet Present Case
              if ((data_value[0][i] == 1) ||
                  (data_value[0][i] == "1")  ) {
                setState(() {
                  data_value[0][i] = 0;
                  //up="False";
                });
              } else {
                setState(() {
                  data_value[0][i] = 1;
                  //up="True";
                });
              }
              setState(() {
                update_value(data[i],data_value[0][i], i);
                _buildButtonsWithNames();
                update_sync_value();
              });
              //print("Connection: present");
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
        },
        child: Container(
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.35,
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              /*color: (data_value[0][i] == 0) || (data_value[0][i] == "0")
                    ? Colors.white
                    : Colors.white,*/
                gradient: (data_value[0][i] == 0) || (data_value[0][i] == "0")
                    ?LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [

                      Colors.white,
                      Colors.white,
                    ]
                ):LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.blue[600],
                      Colors.blue[500],
                      Colors.blue[400],
                    ]
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-1,-1),
                      color: Colors.grey[300],
                      blurRadius: 1,
                      spreadRadius: 1
                  ),
                  BoxShadow(
                      offset: Offset(1,1),
                      color: Colors.grey[300],
                      blurRadius: 1,
                      spreadRadius: 1
                  )
                ]
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.3,
                  child: (data_value[0][i] == 0) || (data_value[0][i] == "0")?Image.asset("assets/off.png"):Image.asset("assets/on.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Container(
                  child: Column(
                    children: [
                      (data_value[0][i] == 1) || (data_value[0][i] == "1")
                          ? Text(data[i].toString().split("Button")[0].replaceAll("_", " ") + " ON ",style: GoogleFonts.robotoSlab(color: Colors.white),)
                          : Text(data[i].toString().split("Button")[0].replaceAll("_", " ") + " OFF",style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            )),
      ),
    )
        :(data[i].toString().contains("Slide") && data[i].toString().contains(widget.room_name))?Container(
      child: Container(
          height: MediaQuery.of(context).size.height*0.135,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(-1,-1),
                    color: Colors.grey[300],
                    blurRadius: 1,
                    spreadRadius: 1
                ),
                BoxShadow(
                    offset: Offset(1,1),
                    color: Colors.grey[300],
                    blurRadius: 1,
                    spreadRadius: 1
                )
              ]
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /*Text(data[i].toString().split("Slide")[0].replaceAll("_", " "),
                      style: GoogleFonts.robotoSlab(color: Colors.black)),*/
                  Text("Fan Speed  ${data_value[0][i].toString().substring(0,1)}",
                      style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                ],
              ),
              Slider(
                activeColor: Colors.blue,
                inactiveColor:  Colors.blueGrey[200],
                value: double.parse(data_value[0][i]),
                min: 0,
                max: 4,
                divisions: 4,
                label: data_value[0][i].toString().substring(0,1),
                onChangeEnd: (double value) {
                  check().then((intenet) {
                    if (intenet) {
                      // Internet Present Case

                      setState(() {
                        data_value[0][i] = value.toInt().toString();
                        /*update_value(data[i], data_value[0][i], i);
                        _buildButtonsWithNames();*/
                      });
                      //print("Connection: present");
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
                    setState(() {
                      update_value(data[i], data_value[0][i], i);
                      _buildButtonsWithNames();
                      update_sync_value();
                    });
                  }

                  );
                },
                onChanged: (double value) {
                  setState(() {
                    data_value[0][i] = value.toString();
                  });
                },
              )
            ],
          )),
    ):Container());
  }
  Future<http.Response> update_sync_value() async {
    final response = await http.post('http://34.83.46.202.xip.io/cyberhome/home.php?username=nikhil&query=update&button=sync&button_value=1');


    //final response = await http.get('http://${widget.ipAddress}/1/sync/1');
    //final response = await http.get('192.168.0.107:8000/button/$temp/');
    if (response.statusCode == 200) {
      print("response 1 : ${response.body}");
      if (response.body != "success");
      // _showScaffold("Update Failed, Please check server or internet connection and retry");
    }
    else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<http.Response> update_value(button, button_value, i) async {
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=update&button=${button}&button_value=${button_value}');


    //final response = await http.get('http://${widget.ipAddress}/1/$button/$button_value');
    //final response = await http.get('192.168.0.107:8000/button/$temp/');
    if (response.statusCode == 200) {
      result = true;
      print("response 1 : ${response.body}");
      if (response.body != "success");
      //_showScaffold("Update Failed, Please check server or internet connection and retry");
    }
    else {
      if ((data_value[0][i] == 0) || (data_value[0][i] == "0" )) {
        setState(() {
          data_value[0][i] = 1;
          _buildButtonsWithNames();
          update_sync_value();
        });

      } else {
        setState(() {
          data_value[0][i] = 0;
          _buildButtonsWithNames();
          update_sync_value();
        });

      }
      result = false;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<http.Response> call() async {
    //final response = await http.get('http://${widget.ipAddress}/key/');
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
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
     final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=value');
    //final response = await http.get('192.168.0.107:8000/value/');
    //final response = await http.get('http://${widget.ipAddress}/value/');
    if (response.statusCode == 200) {

      // print("response: ${response.statusCode}");
      setState(() {
        data_value = jsonDecode(response.body);

      });
      print("response 2: ${response.body}");
      result2 = true;

      Future.delayed(const Duration(seconds: 5), () {

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List data;
  List data_value;
  List<Container> buttonsList = new List<Container>();
  String title;
  bool result = false;
  bool result2 = false;
  Offset _offset = Offset.zero;
  Color c;
  double _currentSliderValue = 0;
  bool isSwitched;
  Timer timer;
  List name=[];
  String button_name;
  Future get_name() async{
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    // final response = await http.get('192.168.0.107:8000/key/');
    //final response = await http.get('http://${widget.ipAddress}/key/');

    var fetchdata = jsonDecode(response.body);
    if(response.statusCode ==200){
      setState(() {
        data = fetchdata;
      });
      for(int i=0;i<data.length;i++){
        print(data[i].toString());


        if(data[i].toString().contains("_Admin_Room") && (!name.contains(data[i].toString().contains("Admin_Room")))){
          name.add("Admin_Room");
        }
        else if(data[i].toString().contains("_Hall") && (!name.contains(data[i].toString().contains("Hall")))){
          name.add("Hall");
        }
        else if(data[i].toString().contains("_Garage") && (!name.contains(data[i].toString().contains("Garage")))){
          name.add("Garage");
        }
        else if(data[i].toString().contains("_Kitchen") && (!name.contains(data[i].toString().contains("Kitchen")))){
          name.add("Kitchen");
        }
        else if(data[i].toString().contains("_Bedroom1") && (!name.contains(data[i].toString().contains("Bedroom1")))){
          name.add("Bedroom1");
        }
      }
    }
    setState(() {
      name=name.toSet().toList();
      button_name="Admin_Room";
      print(name);
    });
    return "success";
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
    get_name();
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
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) =>
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
          }
        }));
    //  call_value();
    super.initState();
    print("data ${data.toString()}");
    print("data_value ${data_value.toString()}");

    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){

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
      timer = Timer.periodic(Duration(seconds:2), (Timer t) =>
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
            }
          }));//   _showScaffold("resume");
      // user returned to our app
    }else if(state == AppLifecycleState.inactive)
    {
      print("app:inactive");
      timer?.cancel();
      // app is inactive
    }else if(state == AppLifecycleState.paused){
      timer?.cancel();
      print("app:pause");
      // user is about quit our app temporally
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          child: Container(margin:EdgeInsets.only(bottom: height*0.06),child: Center(child: Text(widget.room_name.toString().replaceAll("_", " "),style: GoogleFonts.robotoSlab(fontSize: 18,color: Colors.white),))),
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
            children: [
              result && result2
                  ? SingleChildScrollView(child:Container(padding:EdgeInsets.all(5),child: Wrap(children: _buildButtonsWithNames())))
                  : Container(
                child: Container(
                  margin: EdgeInsets.only(top:height*0.4),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
