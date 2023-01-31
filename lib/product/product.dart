import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../login/login.dart';
import '../models/productMo.dart';


class Product extends StatefulWidget {

  static const  String id='product';

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {



  @override
  void initState(){
    super.initState();
    getProduct();
  }



  List< ProductModel> listProduct = [];

  getProduct() async{


    var isCacheExist = await APICacheManager().isAPICacheKeyExist("MyProduct");

    if(!isCacheExist) {

      var response = await http.get(
          Uri.parse("https://mymusawoee.000webhostapp.com/api/user/medpro.php"),
          headers: {"Accept": "headers/json"});


      print("URL:hit");

      if (response.statusCode == 200){

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"MyProduct", syncData:response.body);
      await APICacheManager().addCacheData(cacheDBModel);

        var  jay = json.decode(response.body) as List;
        listProduct = jay.map((project) => ProductModel.fromJson(project)).toList();
        return listProduct;

      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load Products');
      }


    }else{


      var cachedData= await APICacheManager().getCacheData("MyProduct");
      print("Cache:hit");

      var  jay = json.decode(cachedData.syncData) as List;
      listProduct = jay.map((project) => ProductModel.fromJson(project)).toList();
      return listProduct;


    }



  }



  @override
  Widget build(BuildContext context) {



    return Container(
      child:FutureBuilder<dynamic>(
          future:getProduct(),
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
                      child: Text('Medical Products near you',style: TextStyle(color: Colors.lightGreen,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                      child: Text('Find Quality Medical Products near you',style: TextStyle(color: Colors.grey,fontSize: 12),),
                    ),


                    GridView.builder(
                        shrinkWrap: true,
                        physics:const ScrollPhysics(),
                        gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2/3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                        ),
                        itemCount:listProduct.length,
                        itemBuilder: (BuildContext context, int index) {

                          return InkWell(
                            onTap: ()
                            {
                              // _storeProvider.getselectedStore(top[index]['bizname'],top[index]['ID'],top[index]['user_id'],top[index]['logo'],top[index]['shopImage'],top[index]['email1'],
                              //     top[index]['phone1'],top[index]['taxRegistered'],top[index]['tinNumber'],top[index]['address'],top[index]['lat'],top[index]['lon'],
                              //     top[index]['time1'],top[index]['status1'],top[index]['service'],top[index]['shopOpen'],top[index]['rating'],top[index]['totalRating'],top[index]['isTopPicked']
                              // );


                              showDialog(
                                context: (context),
                                builder:(context)=> AlertDialog(
                                  shape:Border.all(color: Colors.grey),
                                  backgroundColor: Colors.purple,
                                  title:const Text('Message',style: TextStyle(color: Colors.white),),
                                  content:const Text('Please Login First',style: TextStyle(color: Colors.white),) ,
                                  actions:<Widget> [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                                      ),

                                      onPressed:(){

                                        Navigator.pushReplacementNamed(context,LoginForm.id);

                                      },
                                      child: const Text('Login',style: TextStyle(color: Colors.white),),),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                                      ),
                                      onPressed:(){
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

                                  ],
                                ),
                              );


                            }
                            ,
                            child:Container(
                              alignment: Alignment.bottomLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                image: DecorationImage(
                                    image:NetworkImage('https://mymusawoee.000webhostapp.com/api/owner/whole/product/${listProduct[index].image}'),
                                  fit: BoxFit.cover,
                                  
                                ),
                              ),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,

                                  children: [

                                    Container(

                                      width:MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color:Colors.lightGreen,
                                         borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(listProduct[index].productName,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                          Text('Shs${listProduct[index].price}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),
                                          //Text(forma,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ) ,
                            ) ,
                          );




                        }),
                  ],
                ),
              );

            }else{
              return GridView.builder(
                  shrinkWrap: true,
                  physics:const ScrollPhysics(),
                  gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2/3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [

                          const Padding(
                            padding: EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Text('Medical Products near you',style: TextStyle(color: Colors.lightGreen,fontSize: 18,fontWeight: FontWeight.bold),),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                            child: Text('Find Quality Medical Products near you',style: TextStyle(color: Colors.grey,fontSize: 12),),
                          ),

                          // GridView(
                          //     gridDelegate: gridDelegate
                          // )

                          GFShimmer(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                color: Colors.grey.shade400,
                              ),
                              child:Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,

                                  children: [

                                    GFShimmer(
                                      child: Container(

                                        width:MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color:Colors.lightGreen,
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                        ),
                                        child: Column(
                                          children: [
                                            GFShimmer(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                                  color: Colors.lightGreen,
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                height: 2,
                                              ),
                                            ),
                                            GFShimmer(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                                  color: Colors.lightGreen,
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                height: 2,
                                              ),
                                            ),
                                            GFShimmer(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                                  color: Colors.lightGreen,
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                height: 2,
                                              ),
                                            ),
                                            // Text(listProduct[index].productName,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            // Text('Shs${listProduct[index].price}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),
                                            // //Text(forma,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ) ,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }

          }),
    );
  }
}
