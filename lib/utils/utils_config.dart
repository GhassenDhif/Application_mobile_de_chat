

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{

  static void updateNode(FocusNode node,context){
    FocusScope.of(context).requestFocus(node);
  }

  static String dateChange(DateTime time){
    if(time.day==DateTime.now().day){
      return DateFormat().add_Hm().format(time);
    }else{
      return DateFormat().add_yMd().format(time);
    }
  }
}