import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/sign_up_controller.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';
import 'package:time_tracker_flutter_course/widgets/sign_up/widgets/body.dart';

import '../../constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: EdgeInsets.all(kPadding),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.form.currentState.reset();
                });
              },
              child: BodySignUp(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Sign Up ",
        style: Theme.of(context).textTheme.headline5,
      ),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.off(() => LoginPage());
        },
      ),
    );
  }
}
