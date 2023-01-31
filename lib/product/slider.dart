import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_musawo/models/slidermodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {



  @override
  void initState(){
    super.initState();
    getSlider();
  }

  int _index= 0;
  int _dataLenghth=1;

  //List<SliderModel> slider = [];
  late  List slider=[];

  getSlider() async{

    var response = await http.get(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/bana.php"),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        final data = jsonDecode(response.body);
        // for (Map item in data) {
        //   slider.add(SliderModel.fromJson(item));
        //
        // }
        slider = data;


        _dataLenghth=data.length;
      });
      print(data);
      return data;
    }

  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future:getSlider(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

            if (snapshot.hasData) {

            return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider.builder(
                    itemCount:snapshot.data.length,
                    options:CarouselOptions(
                    initialPage: 0,
                    autoPlay: true,height: 150,
                      onPageChanged:(int i, carouselPageChangedReason){

                        setState(() {
                         _index=i;
                        });

                      }
                  ), itemBuilder: (BuildContext context, int index, int realIndex) {

                 // final x = slider[index];

                  return  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/bana/${slider[index]['image']}',fit: BoxFit.cover,),
                  );


                 },),
              );



            }else{

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(4),
                  child: Container(
                    width:MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.purple,
                    child:Image.asset('assets/images/loading.png',color: Colors.white,),
                  ),
                ),
              );

            }

          }
        ),

        DotsIndicator(
          dotsCount:_dataLenghth,
          position: _index.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(5.0),
            activeSize: const Size(18.0, 5.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            activeColor:Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
