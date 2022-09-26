import 'package:flutter/material.dart';




class TitleSignUp extends StatelessWidget {
  const TitleSignUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Resigter votre Account et Competer votre Profil pour partager et communiquer \nune discussion",
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }
}