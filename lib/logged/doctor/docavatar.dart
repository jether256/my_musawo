
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class DocAvatar extends StatefulWidget {
  const DocAvatar({Key? key}) : super(key: key);

  @override
  State<DocAvatar> createState() => _DocAvatarState();
}

class _DocAvatarState extends State<DocAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.green))
        ),
        height: 120,
        child:Column(
          children: [
            Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/doc.png',fit: BoxFit.contain,),
                  ),
                ),

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('DR Mutale Jether',style: TextStyle(fontWeight: FontWeight.bold),),
                      const Text('peditirician',style: TextStyle(color: Colors.grey),),
                      const Text('experience 8 years',style: TextStyle(color: Colors.grey),),

                      const SizedBox(height: 30,),

                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.star),
                                  Text('4.9'),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.reviews),
                                  Text('Reviews'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // if('comp'>0)
                      // Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),
                      Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),

                      //Text('price'.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('price',style: TextStyle(fontWeight: FontWeight.bold),),

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

                const SizedBox(width: 20,),

                Expanded(
                    child:NeumorphicButton(
                      onPressed: (){


                        //
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
      ),
    );
  }
}
