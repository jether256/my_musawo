import 'package:flutter/material.dart';

class Below extends StatefulWidget {
  static const  String id='below';
  @override
  State<Below> createState() => _BelowState();
}

class _BelowState extends State<Below> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.lightGreen
      ),
      child: Row(
        children: [
          RichText(
              text:const TextSpan(
                  text: 'Hello,',
              style: TextStyle(fontSize: 22,color: Colors.black),
                children: [
                  TextSpan(
                      text: 'User,',
                      style: TextStyle(fontSize: 22,color: Colors.black),

                  ),
                ]
              ),
          ),
        ],
      ),
    );
  }
}
