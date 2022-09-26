

import 'package:bottom_navy_bar/bottom_navy_bar.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:time_tracker_flutter_course/view_controller.dart/home_controler.dart';

import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_priv%C3%A9e/chat_priv%C3%A9e.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_priv%C3%A9e/design_page_priv%C3%A9e.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_room/chat_room.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/profil_page/profil_view.dart';





// ignore: must_be_immutable
class HomePage extends GetWidget<HomeController> {

  HomeController controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: GetBuilder<HomeController>(
        init: Get.find(),
        builder: (controller) {
          return BottomNavyBar(
            selectedIndex:  controller.index,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) => controller.updateIndex(index),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.chat),
                title: Text('chat room'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.message),
                  title: Text('chat privée'),
                  activeColor: Colors.purpleAccent
              ),

              BottomNavyBarItem(
                  icon: Icon(Icons.person_pin),
                  title: Text('Profil'),
                  activeColor: Colors.blue
              ),
            ],
          );
        }
      ),
      body:SafeArea(
        child: GetBuilder<HomeController>(
          init: Get.find(),
          builder: (controller) {
            return IndexedStack(
              index: controller.index,
              children: [
                ChatRoom(),
                AcceuilPrive(),
               Profil()

              ],
            );
          }
        ),
      ),

     );
  }
}
