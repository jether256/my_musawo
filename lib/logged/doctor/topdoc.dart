import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_musawo/models/personal.dart';

import 'docavatar.dart';
import 'docscreen.dart';


class DoctorList extends StatefulWidget {

  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {




  @override
  void initState(){
    super.initState();
    getTopDoc();
  }


  List< PersonalServiceModel> listProduct = [];


  getTopDoc() async{

    var isCacheExist = await APICacheManager().isAPICacheKeyExist("topDoc");

    if(!isCacheExist) {

      var response = await http.get(
          Uri.parse("https://mymusawoee.000webhostapp.com/api/user/docserve.php"),
          headers: {"Accept": "headers/json"});


      print("URL:hit");

      if (response.statusCode == 200){

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"topDoc", syncData:response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        var  jay = json.decode(response.body) as List;
        listProduct = jay.map((project) => PersonalServiceModel.fromJson(project)).toList();
        return listProduct;

      }else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load Doctors');
      }


    }else{


      var cachedData= await APICacheManager().getCacheData("topDoc");
      print("Cache:hit");

      var  jay = json.decode(cachedData.syncData) as List;
      listProduct = jay.map((project) => PersonalServiceModel.fromJson(project)).toList();
      return listProduct;


    }



  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Container(
        height: 190,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child:Text('Top Doctors',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                TextButton(onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DoctorScreen(),
                      )
                  );
                },
                  child:Row(
                    children: const [
                      Text('See All',style: TextStyle(color: Colors.white),),
                      Icon(Icons.arrow_forward_ios,size: 12,color:Colors.white,),
                    ],
                  ),

                ),
              ],

            ),
            Expanded(

              child: FutureBuilder<dynamic>(
                  future:getTopDoc(),
                  //initialData: [],
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if (snapshot.hasData) {

                      return  ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:listProduct.length ,
                          itemBuilder:( context, index){
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: InkWell(
                                onTap: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DocAvatar()
                                      )
                                  );
                                },
                                child: SizedBox(
                                  width: 0,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      //Image.network(widget.categoryPic),
                                  Card(
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                   child:CachedNetworkImage(
                                        imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/logo/${listProduct[index].image}',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>GFShimmer(
                                          child:Container(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),),),
                                      Flexible(
                                        child: Text(
                                          listProduct[index].name,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 10,color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          });

                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }

              ),
            ),

          ],

        ),
      ),
    );
  }

}
