import 'package:flutter/material.dart';
import 'package:my_musawo/logged/categor/cartlogged.dart';
import 'package:my_musawo/logged/shop/productshop.dart';
import 'package:my_musawo/logged/shop/shopcart.dart';
import 'package:my_musawo/logged/shop/shoplist.dart';
import 'package:my_musawo/logged/shop/silver.dart';
import 'package:my_musawo/logged/slider/sliderlogged.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';

import '../../Provider/cartprovider.dart';
import '../../Provider/productprovider.dart';
import '../../Provider/shopprov.dart';
import '../../Provider/sliderpro.dart';
import '../../pref/pref.dart';
import '../prologged/productdeatils.dart';
import '../prologged/productlogged.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';


class ShopDetails extends StatefulWidget {


  final String USERID;

  const ShopDetails({required this.USERID});


  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {

  int? indexx;
  bool filter=false;


  @override
  void initState(){
    super.initState();
    getPref();

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

  _mapLauncher(String lat, String lon) async{
    final availableMaps = await launcher.MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: launcher.Coords(double.parse(lat),double.parse(lon)),
      title: "Seller Location is Here",
    );


  }


  _callSeller(String s){
    launch(s);
  }
 



  @override
  Widget build(BuildContext context) {

    final _categoryProvider=Provider.of<CategoryProvider>(context);


    final _shopProvider=Provider.of<ShopProvider>(context);


    final _productsProvider=Provider.of<ProductProvider>(context);

    return Scaffold(

      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverShopDetails(),
            ];
          } ,
          body:ListView(
            shrinkWrap: true,
            padding:const EdgeInsets.only(left: 2,right: 2),
            children: [

              SizedBox(height: 10,),

                ShopCategory(USERID:widget.USERID),



            ],
          ),

        ),
      ),
    );
  }
}
