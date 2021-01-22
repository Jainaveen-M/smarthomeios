import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './demo.dart';
import 'DemoButtonPage.dart';
import 'main.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart'
    show Connectivity, ConnectivityResult;


class DemoHome extends StatefulWidget {
  String email,ipAddress;
  DemoHome(this.email,this.ipAddress);
  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome>  with AutomaticKeepAliveClientMixin{
  // checking the internet connectivity
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  List name=[];
  String total_devices;
  List data;
  List data_values;
  List online_data;
  List online_data_values;
  List offline_data;
  List offline_data_values;

  Future get_name() async{
    //192.168.101.18:8000
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    //final response = await http.get('http://192.168.101.18:8000/key/');
    final response_value = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=value');
    //final response_value = await http.get('http://192.168.101.18:8000/value/');
    var fetchdata = jsonDecode(response.body);
    var fetc_values = jsonDecode(response_value.body);
    if(response.statusCode==200){
      setState(() {
        data = fetchdata;
        data_values = fetc_values;
        total_devices = data_values.length.toString();

      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for(int i=0;i<data.length;i++){
        print("offline ${data[i].toString()}");
        await prefs.setString(data[i],data_values[0][i]);
        if(data[i].toString().contains("_Admin_Room") && (!name.contains(data[i].toString().contains("Admin_Room")))){
          name.add("Admin_Room");
        }
        else if(data[i].toString().contains("_Hall") && (!name.contains(data[i].toString().contains("Hall")))){
          name.add("Hall");
        }
        else if(data[i].toString().contains("Living_Room") && (!name.contains(data[i].toString().contains("Living_Room")))){
          name.add("Living_Room");
        }
        else if(data[i].toString().contains("_Garage") && (!name.contains(data[i].toString().contains("Garage")))){
          name.add("Garage");
        }
        else if(data[i].toString().contains("_Kitchen") && (!name.contains(data[i].toString().contains("Kitchen")))){
          name.add("Kitchen");
        }
        else if(data[i].toString().contains("_Bedroom1") && (!name.contains(data[i].toString().contains("Bedroom_1")))){
          name.add("Bedroom_1");
        }
        else if(data[i].toString().contains("_Bedroom2") && (!name.contains(data[i].toString().contains("Bedroom_2")))){
          name.add("Bedroom_2");
        }
        else if(data[i].toString().contains("Master_Bedroom") && (!name.contains(data[i].toString().contains("Master_Bedroom")))){
          name.add("Master_Bedroom");
        }
        else if(data[i].toString().contains("_Bedroom") && (!name.contains(data[i].toString().contains("Bedroom")))){
          name.add("Bedroom");
        }

        else if(data[i].toString().contains("_Store_Room") && (!name.contains(data[i].toString().contains("Store_Room")))){
          name.add("Store_Room");
        }
        else if(data[i].toString().contains("_Outside") && (!name.contains(data[i].toString().contains("Outside")))){
          name.add("Outside");
        }
        else if(data[i].toString().contains("_Parking") && (!name.contains(data[i].toString().contains("Parking")))){
          name.add("Parking");
        }
        else if(data[i].toString().contains("_Outside") && (!name.contains(data[i].toString().contains("Outside")))){
          name.add("Outside");
        }
        else if(data[i].toString().contains("_Garden") && (!name.contains(data[i].toString().contains("Garden")))){
          name.add("Garden");
        }
      }
    }
    setState(() {
      name=name.toSet().toList();
      print(name);
    });
    return "success";
  }
  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', "");
    await prefs.setString('password', "");
    await prefs.setString('ip', "");
    await prefs.setBool('isLoggedIn',false);
    //print(await prefs.getBool('seen'));
    return true;
  }

  // don't change the online url
  Future get_Ip() async{
    final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    final response_value = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=value');
    var fetchdata = jsonDecode(response.body);
    var fetc_values = jsonDecode(response_value.body);
    List ip_data;
    List ip_data_value;
    if(response.statusCode==200) {
      setState( () {
        ip_data = fetchdata;
        ip_data_value = fetc_values;
      } );
      for(int i=0;i<ip_data.length;i++) {
        //print( "ip offline ${ip_data[i].toString( )}" );
        if(ip_data[i].toString().contains("local")){
          setState(() {
            ln=ip_data[i].toString();
            ipValue=ip_data_value[0][i].toString();
            ipIndex=i;
            update_Ip();
            print("ip address $ipValue");
          });
        }
      }

    }

  }

  String ln,ipValue;
  int ipIndex;
  String ipAddress;

  Future<bool> update_Ip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ip', ipValue);
    checkIP();
    return true;
  }



  Future<bool> checkIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ipad = await prefs.get('ip');
    ipAddress = ipad;
    print(ipad);
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_name();
    get_Ip();

  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Icon _icon= Icon(Icons.brightness_3_sharp);
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Container(
          width: MediaQuery.of(context).size.width*0.6,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: height*0.1,
                              width: width*0.4,
                              child: Image.asset("assets/onwords1.png")),
                          Text("Welcome",style: GoogleFonts.robotoSlab(color: Colors.grey[700]),),
                          Text("${widget.email}",style: GoogleFonts.robotoSlab(fontSize: 20,color: Colors.grey[700]),),
                        ],
                      ),
                      /* CircleAvatar(
                        child: Image.asset("assets/appicon.jpg"),
                        radius: 50,
                      )*/
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.water_damage_outlined,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Water tank ",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.settings_remote_outlined,color: Colors.grey[700] ),
                        SizedBox(width: 20,),
                        Text("Universal remote",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.support_rounded,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Cctv",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.security_outlined,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Security System",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.all_inbox_sharp,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Curtain Controls",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Demo()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.settings,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Settings",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    logout().then((value) =>
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp()),
                              (Route<dynamic> route) => false,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: Colors.grey[700]),
                        SizedBox(width: 20,),
                        Text("Log out",style: GoogleFonts.robotoSlab(color: Colors.grey[700]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child:Container(
                margin: EdgeInsets.only(bottom: height*0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                     /* margin: EdgeInsets.only(bottom: height*0.07),*/
                      child: IconButton(icon: Icon(Icons.menu_rounded,color: Colors.white,size: height*0.04,),
                        onPressed: (){
                          _scaffoldKey.currentState.openDrawer();
                        },),

                    ),
                    Container(/*margin:EdgeInsets.only(bottom: height*0.08,left: width*0.2),*/child: Center(child: Text("Smart Home".toString().replaceAll("_", " "),style: GoogleFonts.robotoSlab(fontSize: 20,color: Colors.white),))),
                    IconButton(icon: _icon, onPressed: (){setState(() {
                      _icon = Icon(Icons.brightness_4_outlined);
                    });})
                  ],
                ),
              ),
              height: height*0.2,
              width: width*1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      /*HexColor("#614385"),
                      HexColor("#516395")*/
                     /* Colors.blue[700],
                      Colors.blue[500],
                      Colors.blue[400],*/
                      Colors.grey[500],
                      Colors.grey[500],

                    ]
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:height*0.13),
              width: width*12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight:Radius.elliptical(20,20) ),
                  color: Colors.grey[700]
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
                        itemCount: name.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DemoButtons(widget.email,name[index].toString(),index,widget.ipAddress)));
                              },
                              child: Container(
                                  decoration:  BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  height: height*0.2,
                                  width: width*0.2,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: name[index].toString().contains("Hall")?Image.asset("assets/livingroom.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Admin")?Image.asset("assets/adminroom.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Garage")?Image.asset("assets/garage.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Kitchen")?Image.asset("assets/kitchen.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Bedroom_1")?Image.asset("assets/bedroom1.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Bedroom_2")?Image.asset("assets/bedroom2.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Master_Bedroom")?Image.asset("assets/masterbedroom.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Bedroom")?Image.asset("assets/bedroom.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Outside")?Image.asset("assets/outside.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Garden")?Image.asset("assets/garden.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Parking")?Image.asset("assets/parking.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Living_Room")?Image.asset("assets/livingroom2.png",width: width*0.2,height: height*0.1,)
                                            :name[index].toString().contains("Store_Room")?Image.asset("assets/storeroom.png",width: width*0.2,height: height*0.1,):Container(),
                                      ),
                                      SizedBox(
                                        height: height*0.01,
                                      ),
                                      Text("${name[index].toString().replaceAll("_"," ")}",style: GoogleFonts.robotoSlab(fontSize: 13,color: Colors.grey[300]),),
                                    ],
                                  )
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
