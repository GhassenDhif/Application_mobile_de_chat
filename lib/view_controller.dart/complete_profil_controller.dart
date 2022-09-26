


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:time_tracker_flutter_course/control_view.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/database_service.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';

class CompleteProfilController extends GetxController{



  GlobalKey<FormState> form = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());
  ///************* coordonnée de user*******************///
  String nom;
  String prenom;
  String pic;
  int currentIndex=0;
  String bio;
  String location;
  UserModel user;
  String classUser;
  String section = "1er-Lbc";
  File _image;
  File get image =>_image;
  List<String> classes =["A","B","C","D","E","F","G"];
  List<String> _sections = ["1er-Lbc","1er-Lcs","1er-Lce","2eme-Bi-EB","2eme-SE-IRS","2eme-GLSI-IM","3eme-Ars","3eme-Lai","3eme-Lfi","Master-ASSR","Master-Tsd"];
  List<String> get sections => _sections;
  bool _loading = false;
  bool get load => _loading;
  FocusNode nomlNode = FocusNode();
  FocusNode prenomNode = FocusNode();
  FocusNode bioNode = FocusNode();

  bool loaduser = false;

///************ variable ************///


  @override
  void onInit() async{
    super.onInit();
    nomlNode = FocusNode();
    prenomNode = FocusNode();
    bioNode = FocusNode();

  }

  @override
  void onClose() {
    super.onClose();
    nomlNode.dispose();
    prenomNode.dispose();
    bioNode .dispose();
   }

   void updateIndex(int value,String val){
    classUser = val;
    currentIndex = value;
    update();
   }




   ///**************dropdownmenuItem function*******************//
  void updateSection(String value){
    section = value;
    update();
  }

  void updateLoading(){
    _loading = true;
    update();
  }


  void loaded(){
    _loading = false;
    update();
  }

  ///**************** impotre image from gellery *************///
  void getImagefromGallerie() async{

    ImagePicker picker = ImagePicker();

    final picked = await picker.getImage(source: ImageSource.gallery);
    if(picked != null){
      _image = File(picked.path);

      update();

    }else{
      print("no image picked");
    }
}

///**************** impotre image from camera *************///
  void getImagefromCamera() async{
    ImagePicker picker = ImagePicker();

    final picked = await picker.getImage(source: ImageSource.camera);
    if(picked != null){
      _image = File(picked.path);
      update();
    }else{
      print("no image picked");
      loaded();
    }
  }

  ///************ upload image to firebase fireStore **************************///
  uploadimage()async{
    try{
      var nomImage = basename(_image.path);
     if(nomImage != null){
       var refStorage = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser.uid}/$nomImage");
       await refStorage.putFile(image);
       pic = await refStorage.getDownloadURL();
       update();
     }else{
       Get.snackbar("Error ", "merci de choisir une photo de profil");
     }
    }catch(e){
      print(e.message);
    }

 }



 ///*************************** methde save data to firestore cloud***********///
  Future<void> updateData( )async{
  try{
    updateLoading();

     await uploadimage();
     await ServiceDatabase().updateProfil(FirebaseAuth.instance.currentUser.uid, nom, prenom, bio,pic,section,classUser).then((value){
       userController.fetchUser(FirebaseAuth.instance.currentUser.uid);
       Get.offAll(()=>ControlView());
     });
     loaded();

  }catch(e){
    Get.snackbar("Error", e.message);
    loaded();
  }
}
  Future<void> updateDataGoogle( )async{
    try{
      updateLoading();
      await ServiceDatabase().updateProfil(FirebaseAuth.instance.currentUser.uid, nom, prenom, bio,userController.userModel.pic,section,classUser).then((value){
        userController.fetchUser(FirebaseAuth.instance.currentUser.uid);
        Get.offAll(()=>ControlView());
      });
      loaded();

    }catch(e){
      Get.snackbar("Error", e.message);
      loaded();
    }
  }

}