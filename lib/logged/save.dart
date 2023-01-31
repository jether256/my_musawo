import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/productprovider.dart';
import '../pref/pref.dart';


class SaveForLater extends StatefulWidget {
  const SaveForLater({Key? key}) : super(key: key);

  @override
  _SaveForLaterState createState() => _SaveForLaterState();
}

class _SaveForLaterState extends State<SaveForLater> {




  @override
  void initState() {
    getPref();
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




  @override
  Widget build(BuildContext context) {


    final _productsProvider=Provider.of<ProductProvider>(context);

    return InkWell(
      onTap: ()
      async {

        EasyLoading.show(status: 'Saving....');

        var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/favourite.php'),
            body:{
              "me_id":'$userID',
              "product":_productsProvider.Pro,

            });

        if(response.statusCode==200){

          EasyLoading.showSuccess('Saved Successfully');


        }else {
          EasyLoading.showError('Failed to save');
        }
      },

      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
        child: Container(
          height:56 ,
          decoration: BoxDecoration(
            color:Colors.lightGreen,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(CupertinoIcons.bookmark,color: Colors.white,),
              Text('Buy Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
          ),
        ),
        ),
      ),
    );
  }


}
