import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:my_musawo/logged/doctor/timeslots.dart';


import 'package:provider/provider.dart';
import '../../Provider/docprovider.dart';
import '../../models/personal.dart';
import 'docavatar.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {



  @override
  void initState(){
    super.initState();
    getTopDoc();
  }
  final _formated= NumberFormat();

  List< PersonalServiceModel> listProduct = [];


  //api/user/getClose.php

  getTopDoc() async{


    var isCacheExist = await APICacheManager().isAPICacheKeyExist("topDoc");

    if(!isCacheExist) {

      var response = await http.get(
          Uri.parse("https://mymusawoee.000webhostapp.com/api/user/docserve.php"),
          headers: {"Accept": "headers/json"});


      print("URL:hit");

      if (response.statusCode == 200){

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"topDoc1", syncData:response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        var  jay = json.decode(response.body) as List;
        listProduct = jay.map((project) => PersonalServiceModel.fromJson(project)).toList();
        return listProduct;

      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load Doctors');
      }


    }else{


      var cachedData= await APICacheManager().getCacheData("topDoc1");
      print("Cache:hit");

      var  jay = json.decode(cachedData.syncData) as List;
      listProduct = jay.map((project) => PersonalServiceModel.fromJson(project)).toList();
      return listProduct;


    }



  }


  @override
  Widget build(BuildContext context) {

    var _docProvider=Provider.of<DoctorDetailProvider>(context);


  return  Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title:const Text('Top Doctors',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Container(
          color: Colors.white10,
          child:FutureBuilder<dynamic>(
              future:getTopDoc(),
              //initialData: [],
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if (snapshot.hasData) {
                  // if(snapshot.data!.length == 0){
                  //   return Center(child: Text('List is empty'));
                  // }else {



                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:listProduct.length ,

                      itemBuilder:( context, index){

                        var _price=int.parse(listProduct[index].Price);
                        String price=_formated.format(_price);

                        return Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.green))
                          ),
                          height: 180,
                          child:Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/logo/${listProduct[index].image}',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>GFShimmer(
                                            child:Container(
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( listProduct[index].name,style: const TextStyle(fontSize: 20),),
                                         Text( listProduct[index].Service,style: const TextStyle(fontSize: 14),),
                                        const Text('experience 8 years',style: TextStyle(color: Colors.grey),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(Icons.star,color:Colors.green,),
                                                    Text('4.9',style: TextStyle(color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(Icons.reviews,color: Colors.green,),
                                                    Text('222 Reviews',style: TextStyle(color: Colors.grey),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        //  if('comp'>0)
                                        //  Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),
                                        // Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),

                                        //Text('price'.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold),),
                                       // Text('Booking:${listProduct[index].Price}',style: const TextStyle(color: Colors.grey,fontSize:14),),
                                        Text('Booking:Shs ${price}',style: const TextStyle(color: Colors.grey,fontSize:14),),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [

                                  Expanded(
                                      child:NeumorphicButton(
                                        onPressed: (){



                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>  ChartConversations(chatID:_chatroomId)
                                          //     )
                                          // );

                                        },
                                        style: const NeumorphicStyle(color:Colors.lightGreen),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(CupertinoIcons.video_camera_solid,size: 16,color: Colors.white,),
                                              Text('Book Video',style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                        ),
                                      )),

                                  const SizedBox(width: 10,),

                                  Expanded(
                                      child:NeumorphicButton(
                                        onPressed: (){


                                          _docProvider.getselectedDocDetail(listProduct[index].ID, listProduct[index].cli_id,listProduct[index].doc_id,listProduct[index].doc_id ,listProduct[index].name, listProduct[index].email, listProduct[index].image,listProduct[index].Service,listProduct[index].Price,
                                              listProduct[index].Com, listProduct[index].phone, listProduct[index].Book, listProduct[index].lon,listProduct[index].lat,listProduct[index].luncClose, listProduct[index].luncOpen, listProduct[index].stopBooking, listProduct[index].Op,listProduct[index].Close,
                                              listProduct[index].dayCode,listProduct[index].Servet,listProduct[index].delete,listProduct[index].fcmid,listProduct[index].up);


                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => TimeSlots(
                                                    ID:listProduct[index].ID,
                                                    cli_id:listProduct[index].cli_id,
                                                    doc_id:listProduct[index].doc_id,
                                                    dep_id:listProduct[index].dep_id ,
                                                    name:listProduct[index].name,
                                                    email:listProduct[index].email,
                                                    image:listProduct[index].image,
                                                    Service:listProduct[index].Service,
                                                    Price:listProduct[index].Price,
                                                    Com:listProduct[index].Com,
                                                    phone:listProduct[index].phone,
                                                    Book:listProduct[index].Book,
                                                    lon:listProduct[index].lon,
                                                    lat:listProduct[index].lat,
                                                    luncClose:listProduct[index].luncClose,
                                                    luncOpen:listProduct[index].luncOpen,
                                                    stopBooking:listProduct[index].stopBooking,
                                                    Op:listProduct[index].Op,
                                                    Close:listProduct[index].Close,
                                                    dayCode:listProduct[index].dayCode,
                                                    Servet:listProduct[index].Servet,
                                                    delete:listProduct[index].delete,
                                                    fcmid:listProduct[index].fcmid,
                                                    up:listProduct[index].up,
                                                  )
                                              )
                                          );

                                        },
                                        style: const NeumorphicStyle(color:Colors.lightGreen),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(CupertinoIcons.calendar,size: 16,color: Colors.white,),
                                              Text('Appointment',style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                        ),
                                      )),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                            ],
                          ),
                        );



                      }) ;
                  // }
                } else {


                  return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                itemBuilder:( context, index){

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  GFShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                              border: const Border(bottom: BorderSide(color: Colors.green)),
                              color: Colors.grey.shade400,
                            ),
                            height: 180,
                          ),
                        ),
                      );
                });




                }
              }

          ),
        ),
      ),
    );;
  }
}
