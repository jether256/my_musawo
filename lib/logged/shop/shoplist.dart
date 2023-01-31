import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_musawo/logged/shop/shopdetails.dart';
import 'package:my_musawo/models/business.dart';
import 'package:provider/provider.dart';

import '../../Provider/shopprov.dart';


class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {




  //List<BusinessModel> listProduct = [];

  late  List listProduct=[];
  getShop() async{

    var response = await http.get(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/bisi.php"),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        final data = jsonDecode(response.body);
        // for (Map item in data) {
        //   listProduct.add(BusinessModel.fromJson(item));
        // }
        listProduct = data;
      });
      print(data);
      return data;

    }



  }





  @override
  Widget build(BuildContext context) {

    final _shopProvider=Provider.of<ShopProvider>(context);


    return Container(
      child:FutureBuilder<dynamic>(
          future:getShop(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

            if (snapshot.hasData) {

              // List shopDistance=[];
              // for(int i=0;i<=snapshot.data.length;i++){
              //   var dista= Geolocator.distanceBetween(_userLat,_userLon,snapshot.data[i]['lat'].latitude,snapshot.data[i]['lon'].longitude);
              //   //var dista= Geolocator.distanceBetween(_userLat,_userLon,snapshot.data.top[i]['lat'],snapshot.data.top[i]['lon']);
              //   var distKm=dista/1000;
              //   shopDistance.add(distKm);
              // }

              // final _format=NumberFormat('##,###,###,##0');
              // var jay=int.parse(snapshot.data['price']);
              // String forma='\Shs ${_format.format(jay)}';



              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Padding(
                      padding: EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Text('Top Pharmacies and Drug wholesalers',style: TextStyle(color: Colors.lightGreen,fontSize: 15,fontWeight: FontWeight.bold),),
                    ),


                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection:Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: listProduct.length,
                          itemBuilder: (context, index) {

                            return InkWell(
                              onTap: ()
                              {
                                _shopProvider. getselectedShop(listProduct[index]['ID'],listProduct[index]['user_id'],listProduct[index]['logo'],
                                  listProduct[index]['shopImage'],listProduct[index]['bizname'],listProduct[index]['phone1'],
                                    listProduct[index]['email1'],listProduct[index]['taxRegistered'],listProduct[index]['tinNumber'],
                                  listProduct[index]['address'],listProduct[index]['lon'],listProduct[index]['lat'],listProduct[index]['time1'],
                                  listProduct[index]['status1'], listProduct[index]['service'],listProduct[index]['shopOpen'],listProduct[index]['rating'],
                                  listProduct[index]['totalRating'],listProduct[index]['isTopPicked'],listProduct[index]['create_t'],
                                );


                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ShopDetails(USERID:listProduct[index]['user_id'],)),
                                );



                              }
                              ,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  width: 60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Card(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/logo/${listProduct[index]['logo']}',fit: BoxFit.cover,),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 2.0),
                                        child: Container(
                                          height: 20,
                                          child:Text(listProduct[index]['bizname'],style: const TextStyle(fontSize: 14,color: Colors.green),maxLines: 2),
                                        ),
                                      ),

                                      const Text('10km',style: TextStyle(color: Colors.grey,fontSize: 10),),
                                    ],

                                  ),
                                ),
                              ),
                            );




                          }),
                    ),
                  ],
                ),
              );

            }else{
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(4),
                  child: Container(
                    color: Colors.purple,
                    child: Image.asset(
                      'assets/images/loading.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }

          }),
    );
  }
}
