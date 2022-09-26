



import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/authnetification_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/complete_profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/forget_controler.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/home_controler.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/sign_up_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => AuthViewController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => ForgetController());
  Get.lazyPut(() => CompleteProfilController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ProfilController());
  Get.lazyPut(() => UserController());
  }

}