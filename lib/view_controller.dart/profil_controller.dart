


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:time_tracker_flutter_course/services/database_service.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/complete_profil_controller.dart';

class ProfilController extends GetxController{

  FirebaseAuth _auth = FirebaseAuth.instance;
  ServiceDatabase service = ServiceDatabase();
  CompleteProfilController controller = Get.put(CompleteProfilController());
  GlobalKey<FormState> emailForm = GlobalKey<FormState>();
  GlobalKey<FormState> nomForm = GlobalKey<FormState>();
  GlobalKey<FormState> bioForm = GlobalKey<FormState>();



  ///****************variable ***********************///

  File _image;
  String changeEmail;
  String changeNom;
  String changePrenom;
  String changeUsername;
  String changeBio;
  bool changeOnline =true;

  bool _loadingPicture =false;
  bool get loadpic => _loadingPicture;

  updateloading(bool value){
    _loadingPicture = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();


  }

  @override
  void onClose() {
    super.onClose();



  }


  toogleOnline(bool value){
    changeOnline = value;
    update();
  }

   changeEtatOnline(bool value)async{
   try{
     toogleOnline(value);
     await service.updateOnline(changeOnline, _auth.currentUser.uid);
     update();
   }catch(e){
     Get.snackbar('Erreur', e.message);
   }
 }


 void updateMail()async{
    try{
      await service.updateUserMail( _auth.currentUser.uid, changeEmail);
    }catch(e){
      Get.snackbar("Erreur", e.message);
    }
 }


 void updateNom()async{
    try{
      await service.updateNomPrenom(_auth.currentUser.uid, changeNom, changePrenom,changeUsername);
    }catch(e){
      Get.snackbar("Erreur", e.message);
    }
 }

  void updateBio()async{
    try{
      await service.updateBio(_auth.currentUser.uid, changeBio);
    }catch(e){
      Get.snackbar("Erreur", e.message);
    }
  }


  Future<void> deteleAccount()async{
    await service.delete(_auth.currentUser.uid);
  }




  bool _isload = false;
  bool get load => _isload;

 void upload(){
    _isload = true;
    update();
  }
  void loaded(){
    _isload = false;
    update();
  }

///*************upload image to firebaseStore *******************///

  void updateImage(File image,String nomImage)async{
    updateloading(true);
    Reference refStorage = FirebaseStorage.instance.ref("${_auth.currentUser.uid}/$nomImage");
    await refStorage.putFile(image);
    await refStorage.getDownloadURL().then((value){
      service.updateImage(_auth.currentUser.uid, value);
    });
    updateloading(false);
  }

  Future<void> getImageFromCamera()async{
    updateloading(true);
    ImagePicker picked = ImagePicker();
    final pickedFile = await picked.getImage(source: ImageSource.camera);
    if(pickedFile != null){
      _image = File(pickedFile.path);
      var nomDeImage = basename(_image.path);
      updateImage(_image, nomDeImage);
      updateloading(false);
      update();
    }else{
      Get.snackbar('messgae', 'image n\'est pas uploaded');
    }
  }
  Future<void> getImageFromGallerie()async{
    updateloading(true);
    ImagePicker picked = ImagePicker();
    final pickedFile = await picked.getImage(source: ImageSource.gallery);
    if(pickedFile != null){
      _image = File(pickedFile.path);
      var nomDeImage = basename(_image.path);
      updateImage(_image, nomDeImage);
      updateloading(false);
      update();
    }else{
      Get.snackbar('messgae', 'image n\'est pas uploaded');
    }
  }


///*********methode de sign out ********///
  Future<void> signOut() async{
    upload();
    await ServiceDatabase().disconnect(FirebaseAuth.instance.currentUser.uid);
    _auth.signOut();
    GoogleSignIn().signOut();
    FacebookAuth.instance.logOut();
    loaded();
    ///**user update isOnline false
  }

}