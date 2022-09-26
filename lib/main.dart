import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/control_view.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/utils/binding.dart';
import 'theme/theme_app.dart';



///***** ha4ika documentation ba3d a9raha
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: GetMaterialApp(
        title: 'Time Tracker',
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),

        defaultTransition: Transition.fade,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: ControlView(),
      ),
    );

  }
}


