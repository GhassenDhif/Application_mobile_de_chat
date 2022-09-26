import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/sign_up_controller.dart';



class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.form,
      child: Column(
        children: [
          CustomTextField(
            node: controller.usernameNode,
            hintTile: "Saisi votre nom",
            labelTitle: "username",
            type: TextInputType.text,
            icon: Icon(Icons.person_pin_circle_outlined),
            onchange: (value) {
              controller.username = value;
            },
           complete: () {
              controller.changeNode(
                  controller.emailNode, context);
            },
            validate: (String value) {
              if (value.isEmpty) {
                return "Saisi votre username";
              } else if (value.length < 4) {
                return "nom doit etre plus que 4 cararctere";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomTextField(
            node: controller.emailNode,
            type: TextInputType.emailAddress,
            hintTile: "Saisi votre email",
            labelTitle: "Email",
            icon: Icon(Icons.email_outlined),
            onchange: (value) {
              controller.email = value;
            },
            complete: () {
              controller.changeNode(
                  controller.passwordNode, context);
            },
            validate: (String value) {
              if (value.isEmpty) {
                return "Saisi votre Email";
              } else if (!GetUtils.isEmail(value)) {
                return "Verifier votre email";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          GetBuilder<SignUpController>(
              init: Get.find(),
              builder: (controller) {
                return CustomTextField(
                  node: controller.passwordNode,
                  obscure: controller.showP,
                  type: TextInputType.text,
                  hintTile: "Saisi votre mot de passe",
                  labelTitle: "mot de passe",
                  icon: GestureDetector(
                    onTap: controller.showPass,
                    child: controller.showP
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off_outlined),
                  ),
                  onchange: (value) {
                    controller.password = value;
                  },
                  complete: () {
                    controller.changeNode(
                        controller.confirmdNode, context);
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "Saisi votre mot de passe";
                    } else if (value.length < 5) {
                      return "mot de passe doit etre plus que 5 caractere";
                    } else {
                      return null;
                    }
                  },
                );
              }),
          SizedBox(
            height: Get.height * 0.02,
          ),
          GetBuilder<SignUpController>(
              init: Get.find(),
              builder: (controller) {
                return CustomTextField(
                  hintTile: "Confirmer votre password",
                  obscure: controller.showC,
                  type: TextInputType.text,
                  node: controller.confirmdNode,
                  labelTitle: "confirm",
                  icon: GestureDetector(
                    onTap: controller.showConfirm,
                    child: controller.showC
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off_outlined),
                  ),
                  onchange: (value) {
                    controller.confirmPassword = value;
                  },
                  complete: () {
                    FocusScope.of(context).unfocus();
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "Saisi votre mot de passe";
                    } else if (value.length < 5) {
                      return "mot de passe doit etre plus que 5 caractere";
                    } else if (value != controller.password) {
                      return "confirm mot de passe invalide";
                    } else {
                      return null;
                    }
                  },
                );
              }),
        ],
      ),
    );
  }
}