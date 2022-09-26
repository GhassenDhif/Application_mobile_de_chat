import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/avatar_user.dart';
import 'package:time_tracker_flutter_course/constants.dart';

import 'package:time_tracker_flutter_course/models/user_model.dart';

class Discussion extends StatelessWidget {
  Discussion({Key key, this.user}) : super(key: key);
  TextEditingController _controller = TextEditingController();

  UserModel user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: Get.height * 0.12,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Get.back();
                        }),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                          Avatar(user: user),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: kPadding / 2,
                                    ),
                                   user.isOnline? Text("isOnline"):Text(''),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.add_ic_call),
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.person_pin), onPressed: () {})
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                  children: [
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                    margin:user.uid != FirebaseAuth.instance.currentUser.uid ? EdgeInsets.only(right: 50.0,bottom: 10): EdgeInsets.only(left: 50.0,bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        user.uid != FirebaseAuth.instance.currentUser.uid ? Avatar(user: user):Container(),
                        Expanded(child: Container(
                            padding:EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight:Radius.circular(10) ,
                                    bottomRight:Radius.circular(10)
                                ),
                                color: Colors.black54
                            ),
                            child: Text("messsssssssage  messssssssssssage, messsssae message messsssssssage  messssssssssssage, messsssae messageFancy Text est un générateur de polices en ligne (très) cool. Avec Fancy Text, tu peux copier / coller des polices avec plusieurs de nos générateurs de texte fantaisie GRATUIT. Crée toi un texte sympa avec des lettres fantaisies sur Instagram, Snapchat, Twitter, Facebook, Blogspot et plus encore. Nous avons beaucoup de générateurs de texte. ",),),)
                      ],
                    ),
                  ),
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                      margin: EdgeInsets.only(left: 50.0,bottom: 10),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Expanded(child: Container(
                            padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft:Radius.circular(20) ,
                                    bottomLeft:Radius.circular(20)
                                ),
                                color: Colors.black54
                            ),
                            child: Text("messsssssssage  messssssssssssage, messsssae message messsssssssage  messssssssssssage, messsssae messageFancy Text est un générateur de polices en ligne (très) cool. Avec Fancy Text, tu peux copier / coller des polices avec plusieurs de nos générateurs de texte fantaisie GRATUIT. Crée toi un texte sympa avec des lettres fantaisies sur Instagram, Snapchat, Twitter, Facebook, Blogspot et plus encore. Nous avons beaucoup de générateurs de texte. ",),),)
                        ],
                      ),
                    ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Stack(
                          children: [
                            TextField(
                              controller:_controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: borderSide,
                                focusedBorder: borderSide,
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 15.0),
                                hintText: "Aa ",
                              ),
                            ),
                            Positioned(
                                right: 5.0,
                                top: 0.0,
                                bottom: 0.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.emoji_emotions_outlined,
                                    size: 25,
                                  ),
                                  onPressed: () {},
                                ))
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 25,
                        ),
                        onPressed: () {

                        }),
                    IconButton(
                        icon: Icon(
                          Icons.settings_voice,
                          size: 25,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
