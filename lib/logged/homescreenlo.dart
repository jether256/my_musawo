import 'package:flutter/material.dart';
import 'package:my_musawo/cart/cartpages.dart';
import 'package:my_musawo/logged/prologged/productlogged.dart';
import 'package:my_musawo/logged/shop/shoplist.dart';
import 'package:my_musawo/logged/doctor/topdoc.dart';
import 'package:my_musawo/logged/slider/sliderlogged.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart/cartscreen.dart';
import '../login/login.dart';
import '../pref/pref.dart';
import 'categor/cartlogged.dart';


class HomeScreenLogged extends StatefulWidget {
  static const  String id='home logged';
  @override
  State<HomeScreenLogged> createState() => _HomeScreenLoggedState();
}

class _HomeScreenLoggedState extends State<HomeScreenLogged> {


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


  @override
  Widget build(BuildContext context) {
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
                                  },
                                  child: const Icon(Icons.account_circle,color: Colors.white,)
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                  onTap: (){
                                   // Navigator.pushReplacementNamed(context,LoginForm.id);
                                  },
                                  child: const Icon(Icons.shopping_cart,color: Colors.white,)
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
              padding:const EdgeInsets.only(left: 2,right: 2),
              children:  [


                const SliderLogged(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(4),
                    child: Container(
                      height: 120,
                      color: Colors.red,
                      child: CategoryLogged(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(4),
                    child: Container(
                      height: 200,
                      color: Colors.lightGreen,
                      child:DoctorList(),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),



                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(4),
                    child: Container(
                      height: 130,
                      color: Colors.grey[200],
                      child:const ShopList(),
                    ),
                  ),
                ),

                productLogged(),


              ],
            ),

          ),
        )
    );
  }
}
