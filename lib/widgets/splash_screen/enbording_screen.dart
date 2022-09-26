import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:time_tracker_flutter_course/commun/costom_button.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';

/// ha4i page un bch na3wdo na5dmouha elkol raw
/// ha4i chn7oto fiha animation bch ba3d tet3ada page login
/// matfhmch haja wa9fni
class Enbording extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          color: Colors.white12,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    height: Get.width*0.3,
                    child: Lottie.asset("assets/animation.json",
                        fit: BoxFit.cover),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(Get.width * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bienvenue chez \nChaT-App",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        CustomButton(
                          child: Text("Start chating ",style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white
                          ),),
                          color:  Colors.blue.withOpacity(0.6),
                          press: () => Get.offAll(()=>LoginPage()),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


