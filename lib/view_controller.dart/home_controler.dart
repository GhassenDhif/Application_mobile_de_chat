



import 'package:get/get.dart';

class HomeController extends GetxController{
  int index = 0;

  ///************* index pour home page changer les page *********///
  updateIndex(int value ){
    index= value ;
    update();
  }

}