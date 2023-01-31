
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import '../../Provider/docprovider.dart';

class DoctriInfo extends StatefulWidget {


  @override
  State<DoctriInfo> createState() => _DoctriInfoState();
}

class _DoctriInfoState extends State<DoctriInfo> {

  late GoogleMapController _controller;

  _mapLauncher(String lat, String lon) async{
    final availableMaps = await launcher.MapLauncher.installedMaps;
    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: launcher.Coords(double.parse(lat),double.parse(lon)),
      title: "Seller Location is Here",
    );


  }

  @override
  Widget build(BuildContext context) {


    var _docProvider=Provider.of<DoctorDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title:  Text(_docProvider.name, style: const TextStyle(
          color: Colors.white,),),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8,bottom:55),
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.green))
            ),
            height: 81,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 78,
                      width: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: 'https://mymusawoee.000webhostapp.com/api/owner/logo/${_docProvider.image}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                GFShimmer(
                                  child: Container(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_docProvider.name,maxLines: 1,overflow:TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20),),
                          Text(_docProvider.Service,
                            style: const TextStyle(fontSize: 14),),
                          Text('Booking:Shs ${_docProvider.Price}',maxLines: 1,overflow:TextOverflow.ellipsis ,style: const TextStyle(
                              color: Colors.grey, fontSize: 14),),

                        ],
                      ),
                    ),

                  ],
                ),



              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            height: 200,
            color: Colors.grey.shade300,
            child:  Stack(
              children: [
                Center(
                  child:GoogleMap(
                    initialCameraPosition:CameraPosition(
                      target:LatLng(double.parse(_docProvider.lat),double.parse(_docProvider.lon)),
                      zoom: 15,
                    ),
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller){

                      setState(() {
                        _controller=controller;
                      });

                    },
                  ),
                ),
                const Center(child: Icon(Icons.location_on,size: 35,),),
                const Center(child: CircleAvatar(radius: 60,backgroundColor:Colors.black12,),),

                Positioned(
                  right: 0.0,

                  child:Material(
                    elevation: 4,
                    shape: Border.all(color: Colors.grey.shade300),
                    child: IconButton(
                      onPressed:()
                      {
                        //launch location in google maps
                        _mapLauncher(_docProvider.lat,_docProvider.lon);
                      },
                      icon:const Icon(Icons.alt_route_outlined),
                    ),
                  ),

                )
              ],
            ),

          ),
        ],
      ),
    );
  }
}
