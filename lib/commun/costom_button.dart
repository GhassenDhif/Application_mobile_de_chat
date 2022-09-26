import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomButton extends StatelessWidget {
  final Function press;
  final Widget child;
  final Color color;
  const CustomButton({
    Key key,@required this.press,@required this.child,@required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: Get.width * 0.6,
        height: Get.height * 0.07,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(Get.width * 0.1)),
        elevation: 10.0,
        color: color,
        child:  child,
        onPressed:  press
    );
  }
}