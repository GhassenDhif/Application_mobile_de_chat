import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/authnetification_controller.dart';




class LoginPage extends StatefulWidget {



  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewController controller = Get.put(AuthViewController())  ;

  get flex => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            setState(() {
              controller.form.currentState.reset();
              FocusScope.of(context).unfocus();
            });
          },
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Spacer(
              flex: 3,
            ),
              Text("Pour demarrer votre Livraison,faire le sign-in",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              flex [4];
          ),
                Form(
                  key: controller.form,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintTile: "Saisi votre addresse mail",
                        icon: Icon(Icons.email),
                        node: controller.emailNode,
                        labelTitle: "Email",
                        type: TextInputType.emailAddress,
                        validate: (String value){
                          if(GetUtils.isEmail(value)){
                            return null;
                          }else{
                            return "verifier votre adress mail";
                          }
                        },
                        complete: (){
                          FocusScope.of(context).requestFocus(controller.passwordNode);
                        },
                        onchange: (value){
                          controller.email = value;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      GetBuilder<AuthViewController>(
                        init: Get.find(),
                        builder: (control) {
                          return CustomTextField(
                            hintTile: "Saisi votre password",
                            obscure: control.obscure,
                            node:controller.passwordNode,
                            icon: IconButton(
                              icon: control.obscure ? Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                              onPressed: control.tooglePassword,
                            ),
                            labelTitle: "password",
                            type: TextInputType.text,
                            validate: (String value){
                              if(value.isEmpty){
                                return "merci de saisi votre mot de passe";
                              }else if(value.length < 5){
                                return "mot de passe doit etre plus que 5 caractere";
                              }else{
                                return null;
                              }
                            },
                            complete: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                            },
                            onchange: (value){
                                control.password = value;
                            },
                          );
                        }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text("mot de passe oublier ?"),
                            onPressed: (){
                                Get.off(()=>ForgetPassword());
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(flex: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<AuthViewController>(
                      init: Get.find(),
                      builder: (model) {
                        return CustomButton(
                          color: Colors.black,
                            press: (){
                              if(model.form.currentState.validate()){
                                model.form.currentState.save();
                                model.singInWithEmailAndPasword();
                              }
                            },
                            child: model.loading ?Center(
                            child: CircularProgressIndicator(),
                        ): Text("Login",style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.white
                        ),));
                      }
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(
                      press: () {
                        controller.signInWithFacebook();
                      },
                      path: "assets/logo_fb.png",
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    Logo(
                      press: () {
                        controller.signInWithGoogle();
                      },
                      path: "assets/logo_google.png",
                    )
                  ],
                ),
                Spacer( ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don\'t have an Account ?",textAlign: TextAlign.center,),
                    TextButton(onPressed: (){
                      Get.off(()=>SignUp());
                    }, child: Text("Sign Up"))
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


