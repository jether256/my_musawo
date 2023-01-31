import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import '../login/login.dart';
import '../models/catmodel.dart';


class Categories extends StatefulWidget {

  static const  String id='categories';

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


  @override
  void initState(){
    super.initState();
    getCategory();
  }


  //List<CategoryModel> listCategory = [];

  late  List listCategory=[];

  getCategory() async{

    var response = await http.get(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/medcat.php"),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        final data = jsonDecode(response.body);
        // for (Map item in data) {
        //   listCategory.add(CategoryModel.fromJson(item));
        // }
        listCategory= data;

      });
      print(data);
      return data;

    }

  }

  //listCategory.add(CategoryWithProduct.fromJson(item));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future:getCategory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

          if (snapshot.hasData) {

            // List shopDistance=[];
            // for(int i=0;i<=snapshot.data.length;i++){
            //   var dista= Geolocator.distanceBetween(_userLat,_userLon,snapshot.data[i]['lat'].latitude,snapshot.data[i]['lon'].longitude);
            //   //var dista= Geolocator.distanceBetween(_userLat,_userLon,snapshot.data.top[i]['lat'],snapshot.data.top[i]['lon']);
            //   var distKm=dista/1000;
            //   shopDistance.add(distKm);
            // }


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset('assets/images/thumb.gif'),

                      ),
                      const Text('Top Medicine Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),)

                    ],
                  ),


                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection:Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: listCategory.length,
                        itemBuilder: (context, index) {

                         // final x = listCategory[index];

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
                                          child: CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/drug/${listCategory[index]['image']}',fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Container(
                                        height: 20,
                                        child:Text(listCategory[index]['category'],style: const TextStyle(fontSize: 14,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),

                                    // Text('$shopDistance',style: const TextStyle(color: Colors.grey,fontSize: 10),)
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
              child: Image.asset(
                'assets/images/loading.png',
                color: Colors.white,
              ),
            );
          }

        });
  }
}
