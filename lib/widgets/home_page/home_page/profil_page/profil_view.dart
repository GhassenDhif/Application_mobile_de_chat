import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form_bio.dart';
import 'package:time_tracker_flutter_course/commun/logout_button.dart';
import 'package:time_tracker_flutter_course/commun/custom_text_form.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';

class Profil extends GetWidget<ProfilController> {
  ProfilController controller = Get.put(ProfilController());
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black54),
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          LogOut(controller: controller)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: EdgeInsets.all(kPadding),
            child: StreamBuilder<DocumentSnapshot>(
                stream: _users
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = UserModel.fromJson(snapshot.data.data());
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GetBuilder<ProfilController>(
                                init: Get.put(ProfilController()),
                                builder: (logic) {
                                  return Container(
                                      width: Get.width * 0.3,
                                      height: Get.width * 0.3,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2, color: Colors.white12)),
                                      child: Stack(
                                        children: [
                                          user.pic == null?Container():  Align(
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.width * 0.15),
                                              child:logic.loadpic?Center(child:CircularProgressIndicator() ,) :Image.network(
                                                user.pic,
                                                width: Get.width * 0.28,
                                                height: Get.height * 0.28,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 600),
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: user.isOnline
                                                        ? Colors.green
                                                        : Colors.redAccent,
                                                    shape: BoxShape.circle),
                                              ))
                                        ],
                                      ));
                                },
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.username,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    user.email,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        user.nom,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Text(
                                        user.prenom,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text("Section :"),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Text(user.section,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          BioWidget(controller: controller, user: user),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          MailUpdate(controller: controller, user: user),
                          NomUpdateWidget(controller: controller),
                          ListTileOnline(),
                          GetBuilder<ProfilController>(
                            init: Get.find(),
                            builder: (logic) {
                              return ListTile(
                                leading: Icon(Icons.camera),
                                title: Text(
                                  "Update image",
                                ),
                                trailing: Icon(
                                  Icons.add_circle_outline,
                                  size: 20,
                                ),
                                onTap: () {
                                  Get.defaultDialog(
                                      title: "Modifier votre image",
                                      content: Container(
                                        width: 300,
                                        height: Get.height * 0.25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kPadding,
                                            vertical: kPadding),
                                        child: Column(
                                          children: [
                                            Text(
                                              "confirmer de changer votre Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            MaterialButton(
                                              color: Colors.black54,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "upload from Camera",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                await controller
                                                    .getImageFromCamera();
                                                Get.back();
                                              },
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            MaterialButton(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                "upload from gallerie",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(),
                                              ),
                                              onPressed: () async {
                                                await controller
                                                    .getImageFromGallerie();
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      textCancel: "Retour",
                                      barrierDismissible: false,
                                      onCancel: () async {});
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class NomUpdateWidget extends StatelessWidget {
  const NomUpdateWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ProfilController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person_pin),
      title: Text(
        "nom et prenom",
      ),
      trailing: Icon(
        Icons.edit,
        size: 20,
      ),
      onTap: () {
        Get.defaultDialog(
            title: "Modifier votre nom et prenom",
            content: Container(
              width: 300,
              padding: EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: kPadding),
              child: Column(
                children: [
                  Text(
                    "confirmer de changer votre nom et prenom",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Form(
                    key: controller.nomForm,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintTile: "Saisi votre nom",
                          labelTitle: "Nom",

                          type: TextInputType.text,
                          icon: Icon(Icons.person_pin_circle),
                          onchange: (value) {
                            controller.changeNom = value;
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return "merci de saisir votre nom";
                            } else if (value.length < 3) {
                              return "verifier votre nom";
                            } else {
                              return null;
                            }
                          },
                          complete: () {

                          },
                        ),
                        SizedBox(
                          height: kPadding,
                        ),
                        CustomTextField(
                          hintTile: "Saisi votre prenom",
                          labelTitle: "Prenom",

                          type: TextInputType.emailAddress,
                          icon: Icon(Icons.person_pin_circle),
                          onchange: (value) {
                            controller.changePrenom = value;
                          },
                          complete: () {

                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return "merci de saisir votre prenom";
                            } else if (value.length < 3) {
                              return "verifier votre prenom ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: kPadding,
                        ),
                        CustomTextField(
                          hintTile: "Saisi votre username",
                          labelTitle: "username",

                          type: TextInputType.emailAddress,
                          icon: Icon(Icons.person_pin_circle),
                          onchange: (value) {
                            controller.changeUsername = value;
                          },
                          complete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return "merci de saisir votre username";
                            } else if (value.length < 3) {
                              return "verifier votre username ";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            textCancel: "back",
            textConfirm: "Valider",
            barrierDismissible: false,
            onConfirm: () async {
              if (controller.nomForm.currentState.validate()) {
                controller.nomForm.currentState.save();
                controller.updateNom();
                Get.back();
              }
            },
            onCancel: () {
              Get.back();
            });
      },
    );
  }
}

class MailUpdate extends StatelessWidget {
  const MailUpdate({
    Key key,
    @required this.controller,
    @required this.user,
  }) : super(key: key);

  final ProfilController controller;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.email_outlined),
      title: Text(
        "Address Email",
      ),
      trailing: Icon(
        Icons.edit,
        size: 20,
      ),
      onTap: () {
        Get.defaultDialog(
            title: "Modifier votre address mail",
            content: Container(
              width: 300,
              padding: EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: kPadding),
              child: Column(
                children: [
                  Text(
                    "confirmer de changer votre address Email",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Form(
                    key: controller.emailForm,
                    child: CustomTextField(
                      hintTile: "Saisi votre emial",
                      labelTitle: "Email",
                      type: TextInputType.emailAddress,
                      icon: Icon(Icons.email_outlined),
                      onchange: (value) {
                        controller.changeEmail = value;
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return "merci de saisir votre Email";
                        } else if (!GetUtils.isEmail(value)) {
                          return "verifier votre addres mail";
                        } else if (value == user.email) {
                          return "addres mail inchangée !!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            textCancel: "back",
            textConfirm: "Valider",
            barrierDismissible: false,
            onConfirm: () async {
              if (controller.emailForm.currentState.validate()) {
                controller.emailForm.currentState.save();
                controller.updateMail();
                Get.back();
              }
            },
            onCancel: () {
              Get.back();
            });
      },
    );
  }
}

class BioWidget extends StatelessWidget {
  const BioWidget({
    Key key,
    @required this.controller,
    @required this.user,
  }) : super(key: key);

  final ProfilController controller;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: Text("Biographie :"),
            onPressed: () {
              Get.defaultDialog(
                  title: "Modifier votre Biographie",
                  content: Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.35,
                    padding: EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: kPadding),
                    child: Column(
                      children: [
                        Text(
                          "confirmer de changer votre Bio",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: kPadding * 3,
                        ),
                        Form(
                          key: controller.bioForm,
                          child: CustomTextFieldBio(
                            hintTile: "rediger quelque phrase à propos de vous",
                            labelTitle: "Bio",
                            type: TextInputType.text,
                            icon: Icon(Icons.message),
                            onchange: (value) {
                              controller.changeBio = value;
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return "merci de saisir votre Bio";
                              } else if (value.length < 10) {
                                return "Bio doit etre superieur a 10 caractere";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  textCancel: "back",
                  textConfirm: "Valider",
                  barrierDismissible: false,
                  onConfirm: () async {
                    if (controller.bioForm.currentState.validate()) {
                      controller.bioForm.currentState.save();
                      controller.updateBio();
                      Get.back();
                    }
                  },
                  onCancel: () {
                    Get.back();
                  });
            },
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            user.bio,
            style: Theme.of(context).textTheme.subtitle1.copyWith(),
            maxLines: 5,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class ListTileOnline extends StatelessWidget {
  const ListTileOnline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilController>(
      init: Get.find(),
      builder: (logic) {
        return ListTile(
            leading: Icon(Icons.person_pin),
            title: Text(
              "changer l'etat horligne",
            ),
            trailing: Switch(
              value: logic.changeOnline,
              onChanged: (value) {
                logic.changeEtatOnline(value);
              },
            ));
      },
    );
  }
}
