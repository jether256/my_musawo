import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Provider/productprovider.dart';
import '../Provider/shopprov.dart';
import '../crypt/encrypt.dart';
import '../pref/pref.dart';


class AddToCart extends StatefulWidget {
  static const  String id='cart_add';

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {


  bool _loading=true;
  bool _exist=false;
  int _qty=1;
  String? _ProId;
  String? _price;

  @override
  void initState() {
    getPref();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    final _detailsProvider=Provider.of<ProductProvider>(context);

    getCartData(_detailsProvider);//when opening the details screen first check if this item is in the cart or not;

    //Add(_detailsProvider);
    super.didChangeDependencies();
  }


  getCartData(ProductProvider detailsProvider) async {
    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/CartAlready.php'),
        body:{
          "me_id":'$userID',
          "pro_id":detailsProvider.ProID,
        });
    if(response.statusCode==200){

      //if exists in cart get the products

      var userData=json.decode(response.body);

      print(userData);
    }else{

      setState(() {
        _loading=false;
      });
    }


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
    final _shopProvider=Provider.of<ShopProvider>(context);

    Add(ProductProvider detailsProvider) async{

      EasyLoading.show(status: 'Adding...');
      // Cartget.php

      var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/Cart.php'),

          body:{
            "me_id":encryp('$userID'),
            "user_id":encryp(_productsProvider.userID),
            "qty":encryp('1'),
            "price":encryp(_productsProvider.Price),
            "compared":encryp(_productsProvider.Comp),
            "product":encryp(_productsProvider.Pro),
            "pro_id":encryp(_productsProvider.ProID),
            "weight":encryp(_productsProvider.Wei),
            "image":encryp(_productsProvider.Image),
            "total":encryp(_productsProvider.Price),
            "shop":encryp(_productsProvider.Shop),
          });

      //
      //
      // if(response.statusCode==200){
      //
      //   EasyLoading.showSuccess('Added to Cart');
      // }else{
      //
      //   EasyLoading.showError('Cart Addition failed');
      // }



      if(response.statusCode==200){


        var userData=json.decode(response.body);

        if(userData=="Already"){

          EasyLoading.showError('Product Already in Cart.....');



        }else{


          EasyLoading.showSuccess('Added to cart');

          print(userData);
        }

      }


    }


    return InkWell(
      onTap: ()
      async {

        Add(_productsProvider);

      },

      child:Container(
        height:56 ,
        decoration: BoxDecoration(
          color:Colors.redAccent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
        ),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(CupertinoIcons.shopping_cart,color: Colors.white,),
                Text('Add to cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        )),
      ),
    );
  }


}
