import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:my_musawo/dashboard.dart';
import 'package:my_musawo/logged/account/about.dart';
import 'package:my_musawo/logged/account/managecards.dart';
import 'package:my_musawo/logged/account/up.dart';
import 'package:my_musawo/logged/account/applo.dart';
import 'package:my_musawo/logged/account/histolo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/auth.dart';
import '../Provider/locationPro.dart';
import '../map/map.dart';
import '../pref/pref.dart';
import 'account/cards.dart';

class ProfileLogged extends StatefulWidget {
  static const  String id='profile Logged';


  @override
  State<ProfileLogged> createState() => _ProfileLoggedState();
}

class _ProfileLoggedState extends State<ProfileLogged> {


  String _location='';
  String _adress='';

  @override
  void initState() {
    getPref();
    getLoc();

    super.initState();
  }

  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create,cry,uup,fcmi;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
      cry = sharedPreferences.getString(PrefInfo.cry);
      uup = sharedPreferences.getString(PrefInfo.uup);
      fcmi = sharedPreferences.getString(PrefInfo.fcmi);
    });
  }


  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.city);
    sharedPreferences.remove(PrefInfo.country);
    sharedPreferences.remove(PrefInfo.status);
    sharedPreferences.remove(PrefInfo.type);
    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);
    sharedPreferences.remove(PrefInfo.cry);
    sharedPreferences.remove(PrefInfo.uup);
    sharedPreferences.remove(PrefInfo.fcmi);

    Navigator.pushReplacementNamed(context, DashBoard.id);
  }

  String? loke;
  getLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);


    String? loco=sharedPreferences.getString('location');
    String? ade=sharedPreferences.getString('address');
    setState(() {
      _location=loco!;
      _adress=ade!;
    });
  }


  @override
  Widget build(BuildContext context) {

    final _userDetails=Provider.of<AuthProvider>(context);
    final locationData=Provider.of<LocationProvider>(context);

    return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.lightGreen,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  title:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/images/med.png',width: 120,height: 45,color: Colors.white,),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            children:  [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                    onTap: (){
                                      // Navigator.pushReplacementNamed(context,LoginForm.id);
                                      signOut();
                                    },
                                    child: const Icon(Icons.account_circle,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ];
            } ,
            body:ListView(
              shrinkWrap: true,
              padding:const EdgeInsets.only(left: 8.0,right: 8.0),
              children:  [

                Container(
                  color: Colors.white,
                  child:const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('My Account',style:TextStyle(fontWeight:FontWeight.bold)),
                  ),

                ),

                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children:  [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.lightBlue,
                                  child: Text('J',style:TextStyle(fontSize:50,color: Colors.white),),

                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Container(
                                    height: 70,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                         Text('$name',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white),),

                                         Text('$email',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color:Colors.white),),

                                        Text('$num',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color:Colors.white),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            ListTile(
                              tileColor: Colors.white,
                              leading:const Icon(IconlyLight.location,color: Colors.grey,),
                              //leading:Image.asset('assets/images/mapicon.png'),

                              title:  Text(_location ==null ?'':_location,style: const TextStyle(color: Colors.white),),
                              subtitle: Text(_adress== null ? '':_adress,maxLines: 1,style: const TextStyle(color: Colors.white),),
                              trailing:OutlinedButton(
                                  onPressed:() {

                                    EasyLoading.show(status: 'Please wait...');
                                    locationData.getCurrentPosition();
                                    if(locationData.permissionAllowed==true){
                                      EasyLoading.dismiss();

                                      Navigator.pushReplacementNamed(context, Mapma.id);

                                    }else{
                                      EasyLoading.dismiss();

                                      print('Permission not allowed');
                                    }


                                  },
                                  child:const Text('Change',style:TextStyle(color:Colors.white),)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                        right: 10.0,
                        top: 10.0,
                        child:IconButton(onPressed:()
                        {

                          //Navigator.pushReplacementNamed(context, ProfileUpdateScreen.id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const ProfileUp(),
                              )
                          );


                        },
                            icon:const Icon(Icons.edit,color: Colors.white,))
                    )
                  ],
                ),

                ListTile(leading: const Icon(Icons.history),
                  horizontalTitleGap: 2,
                  title: InkWell(
                      onTap: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryLogged(),
                            )
                        );

                      },
                      child: const Text('My Orders')),
                ),

                const Divider(),

                ListTile(leading: const Icon(Icons.calendar_month),
                  horizontalTitleGap: 2,
                  title: InkWell(
                      onTap: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>   AppointmentLogged() ,
                            )
                        );

                      },
                      child: const Text('My Appointments')),
                ),

                const Divider(),

                ListTile(leading: const Icon(Icons.credit_card),
                  horizontalTitleGap: 2,
                  title: InkWell(
                      onTap: (){

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>   const ManageCArds() ,
                        //     )
                        // );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>    Cards() ,
                            )
                        );

                      },
                      child: const Text('Manage Credit Cards')),
                ),

                const Divider(),

                const ListTile(leading: Icon(Icons.comment_bank_outlined),
                  horizontalTitleGap: 2,
                  title: Text('My Ratings & Reviews'),),


                const Divider(),

                const ListTile(leading: Icon(Icons.notifications),
                  horizontalTitleGap: 2,
                  title: Text('Notifications'),),

                const Divider(),

                ListTile(leading: const Icon(Icons.pages_outlined),
                  horizontalTitleGap: 2,
                  title: InkWell(
                      onTap: ()
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const AboutUS() ,
                            )
                        );
                      },
                      child: const Text('About Us')),
                ),

                const Divider(),

                ListTile(leading: const Icon(Icons.power_settings_new),
                  horizontalTitleGap: 2,
                  onTap: (){
                    signOut();

                  },
                  title: const Text('Log Out'),),


              ],
            ),

          ),
        )
    );
  }
}
