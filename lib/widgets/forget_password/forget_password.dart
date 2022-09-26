import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/forget_controler.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgetController controller = Get.put(ForgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.off(() => LoginPage());
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
             setState(() {
               controller.form.currentState.reset();
             });
            },
            child: Container(
              width: double.infinity,
              height: Get.height,
              padding: EdgeInsets.all(kPadding),
              child: Column(
                children: [//gassendhif7@gmail.com
                 Spacer(),
                  Text(
                    "Saisi votre address mail, un lien sera envoie pour initialiser votre mot de passe",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                      letterSpacing: 1.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  FormCard(controller: controller),
                  Spacer(),
                  SendButton(),
                  Spacer(flex: 2,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetController>(
        init: Get.find(),
        builder: (controller) {
          return MaterialButton(
              color: Colors.black,
              elevation: 5.0,
              minWidth: Get.width * 0.5,
              height: Get.height * 0.06,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: controller.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Send Email",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white
                      ),
                    ),
              onPressed: () {
                if(controller.form.currentState.validate()){
                  controller.form.currentState.save();
                  controller.updatePassword();
                }
              });
        });
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ForgetController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.form,
      child: CustomTextField(
        icon: Icon(Icons.email_outlined),
        hintTile: "Saisi votre email",
        type: TextInputType.emailAddress,
        labelTitle: "Email",
        validate: (value) {
          if(value.isEmpty){
            return "merci de saisi votre adress email";
          }else if(!GetUtils.isEmail(value)){
            return "verifier votre adress email";
          }else{
            return null;
          }
        },
        onchange: (value) {
          controller.email = value.trim();
        },
      ),
    );
  }
}
