import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/costom_button.dart';

import 'package:time_tracker_flutter_course/view_controller.dart/sign_up_controller.dart';


class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: Get.find(),
        builder: (controller) {
          return CustomButton(
              color: Colors.black,
              press: () {
                if (controller.form.currentState.validate()) {
                  controller.form.currentState.save();
                  controller.createwithEmailAndPassword();
                }
              },
              child: controller.loading?Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ) : Text("Register Account",style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white
              ),));

        });
  }
}