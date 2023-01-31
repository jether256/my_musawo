import 'package:flutter/material.dart';
import 'package:my_musawo/logged/save.dart';


import '../cart/addto.dart';


class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer({Key? key}) : super(key: key);

  @override
  _BottomSheetContainerState createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //const Expanded(child: SaveForLater()),
          Expanded(child: AddToCart()),
        ],
      ),
    );
  }
}
