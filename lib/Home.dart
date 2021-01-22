import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:neumorphic/neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Button.dart';
import './demo.dart';
import './waterTank.dart';
import 'main.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart'
    show Connectivity, ConnectivityResult;


class Home extends StatefulWidget {
  String email,ipAddress;
  bool isDarkMode,check_url;
   Home(this.email,this.ipAddress,this.isDarkMode,this.check_url);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with AutomaticKeepAliveClientMixin{


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
  List data;
  String total_devices;
  List data_values;
   Future get_name() async{
     //192.168.101.18:8000
     bool check=widget.check_url;
     SharedPreferences prefs=await SharedPreferences.getInstance();
     setState(() {
       check=prefs.get('check_url');
     });
     var fetchdata;
     var fetc_values;
     if(check==false){
       final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
       final response_value = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=value');
        fetchdata = jsonDecode(response.body);
        fetc_values = jsonDecode(response_value.body);
       if(response.statusCode==200){
         setState(() {
           data = fetchdata;
           data_values = fetc_values;
           total_devices = data_values.length.toString();
         });
         for(int i=0;i<data.length;i++){
           print("online ${data[i].toString()}");

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
     }
     else{
       final response = await http.get('http://${widget.ipAddress}/key/');
       final response_value = await http.get('http://${widget.ipAddress}/value/');
        fetchdata = jsonDecode(response.body);
        fetc_values = jsonDecode(response_value.body);
       if(response.statusCode>0){
         setState(() {
           data = fetchdata;
           data_values = fetc_values;
           total_devices = data_values.length.toString();
         });
         for(int i=0;i<data.length;i++){
           print("offline ${data[i].toString()}");

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
     }

    /*if(response.statusCode==200){
      setState(() {
        data = fetchdata;
        data_values = fetc_values;
        total_devices = data_values.length.toString();
      });
      for(int i=0;i<data.length;i++){
        print("offline ${data[i].toString()}");

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
    }*/

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
    await prefs.setBool('isDark', false);
    await prefs.setBool('check_url', false);
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
        print( "ip offline ${ip_data[i].toString( )}" );
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
  Future<bool> islogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance( );
    await prefs.setBool('isLoggedIn',true);
  }
  Icon _icon;
  Color _color1;
  Color _color2;
  Gradient g1;
  Gradient g2;
  seticon(){
     _icon = widget.isDarkMode==false?Icon(Icons.brightness_3_sharp):Icon(Icons.brightness_4);
     _color1=widget.isDarkMode==false?Colors.grey[100]:Colors.grey[900];
     _color2=widget.isDarkMode==false?Colors.grey[700]:Colors.white;
     g1=widget.isDarkMode==false?LinearGradient(
         begin: Alignment.centerLeft,
         end: Alignment.centerRight,
         colors: [
           Colors.blue[700],
           Colors.blue[500],
           Colors.blue[400],
         ]
     ):LinearGradient(
         begin: Alignment.centerLeft,
         end: Alignment.centerRight,
         colors: [
           Colors.grey[800],
           Colors.grey[800],
         ]
     );
  }
  Future updateMood() async{
    SharedPreferences prefs = await SharedPreferences.getInstance( );
    bool check = await prefs.getBool('isDark');
    if(check==true){
      await prefs.setBool('isDark',false);
      setState(() {
        _icon=Icon(Icons.brightness_3_sharp);
        _color1=Colors.grey[100];
        _color2=Colors.grey[700];
        widget.isDarkMode=false;
        g1=LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.blue[700],
              Colors.blue[500],
              Colors.blue[400],
            ]
        );
      });

    }
    else{
      await prefs.setBool('isDark',true);
     setState(() {
       _icon=Icon(Icons.brightness_4);
       _color1=Colors.grey[900];
       _color2=Colors.white60;
       widget.isDarkMode=true;
       g1=LinearGradient(
           begin: Alignment.centerLeft,
           end: Alignment.centerRight,
           colors: [
             Colors.grey[800],
             Colors.grey[800],
           ]
       );
     });
    }
  }
  bool isSwitched;
  Future geturl() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check_url= await prefs.get('check_url');
    setState(() {
      isSwitched=check_url;
    });
  }
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seticon();
    get_name();
    islogged();
    get_Ip();
    geturl();
   timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
     get_name();
     });
    print("url type: ${widget.check_url}");
   }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>waterTank(widget.email)));
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
                    setState(() {
                      updateMood();
                    });
                  },
                  child: Row(
                    children: [
                      IconButton(icon: _icon,color: Colors.grey[700], onPressed: (){}),
                      Text("Day/Light mode",style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                      SizedBox(width: 20,),

                    ],
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings(widget.check_url,isSwitched)));
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
                margin: EdgeInsets.only(bottom: height*0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                       margin: EdgeInsets.only(bottom: height*0.07),
                      child: IconButton(icon: Icon(Icons.menu_rounded,color: Colors.white,size: height*0.04,),
                        onPressed: (){
                          _scaffoldKey.currentState.openDrawer();
                        },),

                    ),
                    Container(margin:EdgeInsets.only(bottom: height*0.08,left: width*0.2),child: Center(child: Text("Smart Home".toString().replaceAll("_", " "),style: GoogleFonts.robotoSlab(fontSize: 20,color: Colors.white),))),
                  ],
                ),
              ),
              height: height*0.2,
              width: width*1,
              decoration:BoxDecoration(
                gradient: g1
              )
            ),
                Container(
                  margin: EdgeInsets.only(top:height*0.13),
                  width: width*12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight:Radius.elliptical(20,20) ),
                      color:_color1,
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Button(widget.email,name[index].toString(),index,widget.ipAddress,_color1,_color2,g1,widget.isDarkMode,widget.check_url)));
                                        },
                                        child: NeuCard(
                                            curveType: CurveType.concave,
                                            bevel: 10,
                                            decoration:widget.isDarkMode==false?  NeumorphicDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(10),
                                            ):NeumorphicDecoration(
                                              color: _color1,
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
                                                  Text("${name[index].toString().replaceAll("_"," ")}",style: GoogleFonts.robotoSlab(fontSize: 13,color: _color2),),
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