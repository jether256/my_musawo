
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';


import '../../Provider/paymentmethod.dart';

class CodToggleSwitch extends StatefulWidget {
  const CodToggleSwitch({Key? key}) : super(key: key);

  @override
  State<CodToggleSwitch> createState() => _CodToggleSwitchState();
}

class _CodToggleSwitchState extends State<CodToggleSwitch> {
  @override
  Widget build(BuildContext context) {

    var _payProvider=Provider.of< PaymentProvider>(context);

    return Container(
      color: Colors.white,
      child:ToggleSwitch(
        cornerRadius: 20.0,
        minHeight: 90.0,
        initialLabelIndex: 0,
        totalSwitches: 2,
        activeBgColor: [Colors.green],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.grey[900],
        labels:const ["Pay online","Cash on Delivery"],
        onToggle:(index){

          print('switched to: $index');

         // _payProvider.getPymentmtd(index);
        },
      )
    );
  }
}
