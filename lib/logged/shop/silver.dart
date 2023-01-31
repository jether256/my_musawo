import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Provider/cartprovider.dart';
import '../../Provider/productprovider.dart';
import '../../Provider/shopprov.dart';
import '../../pref/pref.dart';

class SliverShopDetails extends StatefulWidget {
  const SliverShopDetails({Key? key}) : super(key: key);

  @override
  State<SliverShopDetails> createState() => _SliverShopDetailsState();
}

class _SliverShopDetailsState extends State<SliverShopDetails> {



  int? indexx;
  bool filter=false;


  @override
  void initState(){
    super.initState();
    getPref();
    //getCategory();
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

     return  SliverAppBar(
       backgroundColor: Colors.lightGreen,
      floating: false,
      pinned: true,
      elevation: 1,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      expandedHeight: 280,
      flexibleSpace: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 86),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:NetworkImage('https://mymusawoee.000webhostapp.com/api/api/owner/logo/${_shopProvider.Logo}'),
                  ),

                ),
                child: Container(
                  color:Colors.grey.withOpacity(.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [


                        Text(_shopProvider.ShopNem,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text(_shopProvider.Mail,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text(_shopProvider.Ad,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),

                        Row(
                          children: const [
                            Icon(Icons.star,color: Colors.white,),
                            Icon(Icons.star,color: Colors.white,),
                            Icon(Icons.star,color: Colors.white,),
                            Icon(Icons.star_half,color: Colors.white,),
                            Icon(Icons.star_outline,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text('(3.5)',style: TextStyle(color: Colors.white),)
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            CircleAvatar(
                              backgroundColor:Colors.white,
                              child: IconButton(
                                onPressed:(){

                                  launch('tel:${_shopProvider.Phone}');
                                },
                                icon:const Icon(Icons.phone,color: Colors.lightGreen,),
                              ),
                            ),

                            const SizedBox(width: 3,),

                            CircleAvatar(
                              backgroundColor:Colors.white,
                              child: IconButton(
                                onPressed:(){
                                  _mapLauncher(_shopProvider.Lat,_shopProvider.Lon);
                                },
                                icon:const Icon(Icons.map,color: Colors.lightGreen,),
                              ),
                            ),
                          ],
                        )

                      ],

                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      actions: [
        IconButton(
            onPressed:(){},
            icon:const Icon(CupertinoIcons.search))
      ],
      title:Text( _shopProvider.ShopNem,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(color: Colors.white)),
    );
  }
}
