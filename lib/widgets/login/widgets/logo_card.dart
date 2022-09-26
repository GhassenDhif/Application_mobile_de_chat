import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
    @required this.path,
    @required this.press,
  }) : super(key: key);
  final String path;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: Get.width * 0.13,
        height: Get.width * 0.13,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Get.width * 0.13 / 2),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}