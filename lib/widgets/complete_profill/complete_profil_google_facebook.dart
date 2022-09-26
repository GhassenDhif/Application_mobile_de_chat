import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/costom_button.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form_bio.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/utils/utils_config.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/complete_profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';
import 'package:time_tracker_flutter_course/widgets/login/login_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:time_tracker_flutter_course/widgets/splash_screen/enbording_screen.dart';



class CompleteProfilGoogle extends StatefulWidget {
  const CompleteProfilGoogle({Key key}) : super(key: key);

  @override
  _CompleteProfilGoogle createState() => _CompleteProfilGoogle();
}

class _CompleteProfilGoogle extends State<CompleteProfilGoogle> {
  CompleteProfilController controller = Get.put(CompleteProfilController());
  UserController userController = Get.put(UserController());
  ProfilController profilController = Get.put(ProfilController());


  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Profil utilisateur",style: Theme.of(context).textTheme.headline6,),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: (){
                profilController.deteleAccount();
               Get.off(Enbording());
              },
              child: Padding(
                padding: EdgeInsets.only(right: kPadding),
                child: Icon(Icons.close,size: 20,),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: Get.height,
              padding: EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  Text("Completer votre Profil ",style: Theme.of(context).textTheme.headline5,textAlign: TextAlign.center,),
                  GetBuilder<CompleteProfilController>(
                      init: Get.find(),
                      builder: (controller) {
                        return Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:Stack(
                              children: [
                                Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(

                                      shape: BoxShape.circle,

                                    ),
                                    child:userController.userModel.pic != null? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(userController.userModel.pic, height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ):Container() ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: (){
                                      controller.getImagefromGallerie();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.camera)),
                                  ),
                                )
                              ],
                            )
                        );
                      }
                  ) ,
                  Spacer(),
                  Form(
                    key: controller.form,
                    child: Column(
                      children: [
                        CustomTextField(
                          node: controller.nomlNode,
                          hintTile: 'Saisi votre nom',
                          labelTitle: 'Nom',
                          icon: Icon(Icons.person_pin),
                          onchange: (value){
                            controller.nom = value;
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return "merci de saisi votre nom";
                            } else if (value.length < 4) {
                              return "nom doit etre plus que 4 caractere";
                            } else {
                              return null;
                            }
                          },
                          complete: (){
                            Utils.updateNode(controller.prenomNode, context);
                          },
                        ),
                        SizedBox(
                          height: Get.height*0.03,
                        ),
                        CustomTextField(
                            node: controller.prenomNode,
                            hintTile: "Sais votre prenom",
                            labelTitle: 'Prenom',
                            icon: Icon(Icons.person_pin),
                            onchange: (value){
                              controller.prenom= value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return "merci de saisi votre prenom";
                              } else if (value.length < 4) {
                                return "prenom doit etre plus que 4 caractere";
                              } else {
                                return null;
                              }
                            },
                            complete: (){
                              Utils.updateNode(controller.bioNode, context);
                            }
                        ),

                        SizedBox(
                          height: Get.height*0.03,
                        ),
                        CustomTextFieldBio(
                          node: controller.bioNode,
                          hintTile: "",
                          labelTitle: 'Bio',
                          icon: Icon(Icons.account_box_outlined),
                          onchange: (value){
                            controller.bio= value.trim();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return "merci de saisi votre Bio";
                            } else if (value.length < 10) {
                              return "nom doit etre plus que 10 caractere";
                            } else {
                              return null;
                            }
                          },
                          complete: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                        SizedBox(
                          height: Get.height*0.03,
                        ),

                      ],
                    ),
                  ),

                  GetBuilder<CompleteProfilController>(
                      init: Get.find(),
                      builder: (controller) {
                        return Container(
                          width: double.infinity,
                          height: 70,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kPadding),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.6),
                              )
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            elevation: 5,
                            itemHeight: 70,
                            iconEnabledColor: Colors.grey,
                            value: controller.section,
                            onChanged: (value){
                              controller.updateSection(value);
                            },
                            items:controller.sections.map((section){
                              return DropdownMenuItem<String>(
                                  value: section,
                                  onTap: (){

                                  },
                                  child: Text(section));
                            }).toList(),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  GetBuilder<CompleteProfilController>(
                    init: Get.find(),
                    builder: (logic) {
                      return Container(
                        width: double.infinity,
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Choix votre Class"),
                            SizedBox(
                              height: 5.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic.classes.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        logic.updateIndex(index,logic.classes[index] );
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        margin: EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:logic.currentIndex == index? Colors.black87:Colors.grey.withOpacity(0.2),
                                        ),
                                        child: Center(
                                            child: Text(
                                              controller.classes[index],style: Theme.of(context).textTheme.subtitle1.copyWith(
                                                color: Colors.white
                                            ),)),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetBuilder<CompleteProfilController>(
                      init: Get.find(),
                      builder: ( controller) {
                        return CustomButton(
                            press: (){
                              if(controller.form.currentState.validate()){
                                controller.form.currentState.save();
                                controller.updateDataGoogle();
                              }
                            },
                            child:controller.load?Center(child: CircularProgressIndicator(),): Text("Valider",style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.white
                            ),),
                            color: Colors.black);
                      }
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
