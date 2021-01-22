import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wake_on_lan/wake_on_lan.dart';
class Settings extends StatefulWidget {
  bool check_url,isSwitched;
  Settings(this.check_url,this.isSwitched);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Icon icondata;
  Future updateurl(bool result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('check_url',result);
    print(result==true?"On":"Off");

  }
  bool isSwitched;
  var textValue;
  Future geturl() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check_url= await prefs.getBool('check_url');
    setState(() {
      isSwitched=check_url;
      print("switch $isSwitched");
      icondata=check_url==true?Icon(Icons.wifi_off):Icon(Icons.wifi);
      textValue=check_url==false?"Online":"Offline";
    });
  }
  Future updateLan() async{
    SharedPreferences prefs = await SharedPreferences.getInstance( );
    await prefs.setString('ip_address', ip);
    await prefs.setString('mac_address', mac);
  }
  void WakeOnLan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance( );
    String ip = await prefs.getString('ip_address');
    String mac = await prefs.getString('mac_address');
    print("ip $ip mac $mac");
    if(!IPv4Address.validate(ip)) {
      print('Invalid IPv4 Address String');
      return;
    }
    if(!MACAddress.validate(mac)) {
      print('Invalid MAC Address String');
      return;
    }
    IPv4Address ipv4Address = IPv4Address.from(ip);
    MACAddress macAddress = MACAddress.from(mac);

    WakeOnLAN.from(ipv4Address, macAddress, port: 9).wake();
  }

  String ip,mac;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geturl();
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: (){
            Navigator.of(context).pop();
           return Future.value(true);
          },
          child: Stack(
            children: [
              Container(
                child: Container(margin:EdgeInsets.only(bottom: height*0.06),child: Center(child: Text("Settings",style: GoogleFonts.robotoSlab(fontSize: 18,color: Colors.white),))),
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
                padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top:height*0.09),
                  width: width*1,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight:Radius.elliptical(20,20) ),
                  color: Colors.white
                  ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        if(isSwitched == false)
                        {
                          setState(() {
                            icondata=Icon(Icons.wifi);
                            isSwitched = true;
                            updateurl(true);
                            geturl();
                            textValue = 'Offline';
                          });
                          print('Switch Button is ON');
                        }
                        else
                        {
                          setState(() {
                            icondata=Icon(Icons.wifi_off);
                            isSwitched = false;
                            updateurl(false);
                            geturl();
                            textValue = 'Online';
                          });
                          print('Switch Button is OFF');
                        }
                      },
                      child: Row(
                        children: [
                        IconButton(icon: icondata , onPressed: null),
                          SizedBox(width: 10,),
                          Text("Online/offline  Current Mode : ${textValue}",style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        WakeOnLan();
                      },
                      onDoubleTap: (){
                        Alert(
                            context: context,
                            title: "Add IP",
                            content: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.wifi_tethering_outlined),
                                    labelText: 'IP Address',
                                  ),
                                  onChanged: (val){
                                    setState(() {
                                      ip=val;
                                    });
                                  },
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    icon:  Icon(Icons.wifi_tethering_outlined),
                                    labelText: 'MAC Address',
                                  ),
                                  onChanged: (val){
                                    setState(() {
                                      mac=val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  updateLan();
                                },
                                child: Text(
                                  "Setup",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )
                            ]).show();
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.airplay_sharp,color: Colors.grey[700],),
                          SizedBox(width: 25,),
                          Text("Wake on LAN",style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: (){

                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.label_important_outline,color: Colors.grey[700],),
                          SizedBox(width: 25,),
                          Text("About",style: GoogleFonts.robotoSlab(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
