


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/productprovider.dart';
import '../models/catmo.dart';
import '../pref/pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CartPages extends StatefulWidget {



  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {

  final price = NumberFormat("#,##0", "EN_US");

  int delivery = 0;


  @override
  void initState(){
    super.initState();
    getPref();

  }

  @override
  void didChangeDependencies() {

    final _productsProvider=Provider.of<ProductProvider>(context);

    getCart(_productsProvider);
    
    super.didChangeDependencies();
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


  //List<CatModel> listCart = [];
  List listCart = [];

  getCart(ProductProvider productsProvider) async {
    //listCart.clear();

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/cartget.php'),
        body:{
          "me_id":'$userID',
          //"pro_id":detailsProvider.ProID,
          "user_id":productsProvider.userID,
        });

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      setState(() {
        final data = jsonDecode(response.body);
        // for (Map item in data) {
        //   listCategory.add(CategoryModel.fromJson(item));
        // }
        listCart= data;

      });
      print(data);
      return data;

      // setState(() {
      //   final data = jsonDecode(response.body);
      //   for (Map item in data) {
      //     listCart.add(CatModel.fromJson(item));
      //   }
      // });


    }
  }

  // updateQuantity(String tipe, String model) async {
  //   var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
  //   final response = await http
  //       .post(urlUpdateQuantity, body: {"cartID": model, "tipe": tipe});
  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   if (value == 1) {
  //     print(message);
  //     setState(() {
  //       getPref();
  //       widget.method();
  //     });
  //   } else {
  //     print(message);
  //     setState(() {
  //       getPref();
  //     });
  //   }
  // }
  //
  // checkout() async {
  //   var urlCheckout = Uri.parse(BASEURL.checkout);
  //   final response = await http.post(urlCheckout, body: {
  //     "idUser": userID,
  //   });
  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   String message = data['message'];
  //   if (value == 1) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => SuccessCheckout()),
  //             (route) => false);
  //   } else {
  //     print(message);
  //   }
  // }
  //
  // var sumPrice = "0";
  // int totalPayment = 0;
  // cartTotalPrice() async {
  //   var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
  //   final response = await http.get(urlTotalPrice);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     String total = data['Total'];
  //     setState(() {
  //       sumPrice = total;
  //       totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
  //     });
  //     print(sumPrice);
  //   }
  // }


  @override
  Widget build(BuildContext context) {

    final _productsProvider=Provider.of<ProductProvider>(context);



    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.length == 0
          ?  SizedBox(
        child:Text(_productsProvider.userID) ,
      )
          : Container(
        padding: const EdgeInsets.all(24),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xfffcfcfc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [

                Text(
                  "Total Items",
                  style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                ),

                // Text(
                //   "IDR " + price.format(int.parse(sumPrice)),
                //   style:const TextStyle(fontSize: 16),
                // ),
                //

                Text(
                  "Shs " ,
                  style:TextStyle(fontSize: 16),
                ),

              ],
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Delivery Fee",
                  style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                ),

                // Text(
                //   delivery == 0 ? "FREE" : delivery,
                //   style: const TextStyle(fontSize: 16),
                // ),

                Text(
                  'free',
                  style: TextStyle(fontSize: 16),
                ),

              ],
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Payment",
                  style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                ),

                // Text(
                //   "IDR " + price.format(totalPayment),
                //   style: const TextStyle(fontSize: 16),
                // ),

                Text(
                  "Shs 00000",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(

                    child: ElevatedButton(
                      onPressed:()
                      {

                      },
                      child:const Text('Checkout',style: TextStyle(color: Colors.white),),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(

          child: ListView(
            padding: const EdgeInsets.only(bottom: 220),
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  height: 70,
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                        color:Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "My Cart",
                      style:TextStyle(fontSize: 25),
                    )
                  ])),
              // listCart.length == 0 || listCart.length == null
              //     ? Container(
              //   padding: const EdgeInsets.all(24),
              //   margin: const EdgeInsets.only(top: 30),
              //   child: WidgetIlustration(
              //     image: "assets/empty_cart_ilustration.png",
              //     title: "Oops, there are no products in your cart",
              //     subtitle1: "Your cart is still empty, browse the",
              //     subtitle2: "attractive products from MEDHEALTH",
              //     child: Container(
              //       margin: EdgeInsets.only(top: 30),
              //       width: MediaQuery.of(context).size.width,
              //       child: ButtonPrimary(
              //         text: "SHOPPING NOW",
              //         onTap: () {
              //           Navigator.pushAndRemoveUntil(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => MainPages()),
              //                   (route) => false);
              //         },
              //       ),
              //     ),
              //   ),
              // )
              //     :
                Container(
                padding: const EdgeInsets.all(24),
                height: 166,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delivery Destination",
                      style:TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$name",
                          style:const TextStyle(color: Colors.grey,fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Address",
                          style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$ad",
                          style: const TextStyle(color: Colors.grey,fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phone",
                          style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$num",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: listCart.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    //final x = listCart[i];
                    return Container(
                      padding: const EdgeInsets.all(24),
                      //color: whiteColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              CachedNetworkImage(
                               imageUrl:'https://mymusawoe.000webhostapp.com/api/owner/whole/product/${listCart[i]['image']}',
                                width: 115,
                                height: 100,
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      listCart[i]['product'],
                                      style:
                                      const TextStyle(fontSize: 16),
                                    ),

                                    Row(
                                      children: [

                                        IconButton(
                                            icon: const Icon(
                                              Icons.add_circle,
                                              color:Colors.green,
                                            ),
                                            onPressed: () {
                                             // updateQuantity("tambah",listCart[i]['ID']);
                                            }),

                                        Text(listCart[i]['qty']),

                                        IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Color(0xfff0997a),
                                            ),
                                            onPressed: () {
                                             // updateQuantity("kurang",listCart[i]['ID']);
                                            }),
                                      ],
                                    ),

                                    Text(
                                      "Shs ${price.format(int.parse(listCart[i]['price']))}",
                                      style:const TextStyle(fontSize: 16),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
