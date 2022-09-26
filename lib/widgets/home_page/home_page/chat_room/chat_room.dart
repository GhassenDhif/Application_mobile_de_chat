import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/commun/logout_button.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_room/class_chat/class_room_chat.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_room/section_chat/class_chat.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_room/isima_chat/chat_isima_room.dart';


class ChatRoom extends StatelessWidget {
  ProfilController control = Get.put(ProfilController());
  UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text("Acceuil Isima Chat",style: Theme.of(context).textTheme.headline5.copyWith(
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true ,
        actions: [
          LogOut(controller: control)
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
                Spacer(),
                 Chat(
                   title: "ISIMA Chat",
                   onpress: (){
                      Get.to(()=>IsimaChat());
                   },
                 ),
               userController==null?Container(): Chat(
                  title: "Section Chat",
                  onpress: (){
                    Get.to(()=>  ChatSectionRoom(
                       user: userController.userModel,
                    ));
                  },
                ),
                Chat(
                  title: "Class Chat",
                  onpress: (){
                    Get.to(()=>  ChatClassRoom(
                      user: userController.userModel,
                    ));
                  },
                ),
               Spacer(
                 flex: 2,
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({
    Key key,@required this.title,@required this.onpress,
  }) : super(key: key);
  final String title;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
       width:double.infinity,
        height: 80,
        margin: EdgeInsets.symmetric(vertical: kPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kPadding),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,5),
              color: Colors.black54,
              blurRadius: 10
            ),
          ]
        ),
        child: Center(
            child: Text(title,style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold,letterSpacing: 1.0
            ),),
           ) ,
        ),
    );
  }
}
