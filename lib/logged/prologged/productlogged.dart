import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:my_musawo/logged/prologged/productdeatils.dart';
import 'package:provider/provider.dart';

import '../../Provider/productprovider.dart';
import '../../models/productMo.dart';

class productLogged extends StatefulWidget {
  static const  String id='product logged';


  @override
  State<productLogged> createState() => _productLoggedState();
}

class _productLoggedState extends State<productLogged> {



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


  // List< ProductModel> listProduct = [];
  // getProduct() async{
  //
  //   listProduct.clear();
  //
  //     var response = await http.get(
  //         Uri.parse("https://mymusawoee.000webhostapp.com/api/user/medpro.php"),
  //         headers: {"Accept": "headers/json"});
  //
  //
  //
  //     if (response.statusCode == 200){
  //
  //        var  jay = json.decode(response.body) as List;
  //         listProduct = jay.map((project) => ProductModel.fromJson(project)).toList();
  //        return listProduct;
  //
  //         //listProduct= ProductModel.fromJson(jsonDecode(jay.toString()) as Map<String, dynamic>) as List<ProductModel>;
  //
  //
  //
  //     }else {
  //
  //       // If that call was not successful, throw an error.
  //       throw Exception('Failed to load Products');
  //
  //
  //     }
  //
  //
  //
  //
  //
  //
  // }



  @override
  Widget build(BuildContext context) {

    final _productsProvider=Provider.of<ProductProvider>(context);


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
                              // _productsProvider.getselectedProduct(listProduct[index]['id'],listProduct[index]['user_id'],listProduct[index]['ownerName'],listProduct[index]['shopName'],listProduct[index]['productName'],listProduct[index]['descc'],
                              //     listProduct[index]['price'],listProduct[index]['compared'],listProduct[index]['collection'],listProduct[index]['brand'],listProduct[index]['category'],listProduct[index]['weight'],
                              //     listProduct[index]['tax'],listProduct[index]['published'],listProduct[index]['carType'],listProduct[index]['service'],listProduct[index]['pack'],listProduct[index]['image'],listProduct[index]['pro_id']
                              // );


                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ProductDetails(ID:listProduct[index].id,userID:listProduct[index].user_id,Owner:listProduct[index].ownerName,Shop:listProduct[index].shopName,Pro:listProduct[index].productName,Des:listProduct[index].descc,
                                      Price:listProduct[index].price,Comp:listProduct[index].comp,Coll:listProduct[index].coll,Brand:listProduct[index].brand,Cat:listProduct[index].category,Wei:listProduct[index].weight,Tax:listProduct[index].tax,
                                      Pub:listProduct[index].published,carType:listProduct[index].carType,Service:listProduct[index].service,Pack:listProduct[index].pack,Image:listProduct[index].image,ProID:listProduct[index].pro_id),),
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
                            ),
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
