



/// hne ma3nha nzido class eybhi
///****************** ha4a model user *********************///
class UserModel{
  String uid;
  String username;
  String nom;
  String prenom;
  String bio;
  String email;
  String pic;
  String classUser;
  bool isOnline ;
  String section;

  ///*** constructeur *******///

UserModel({this.section,this.nom,this.prenom,this.bio, this.email,this.classUser, this.pic, this.username,this.isOnline =false,this.uid});



 UserModel.fromJson(Map<String,dynamic> map){
  username = map["username"];
  nom = map["nom"];
  prenom = map["prenom"];
  bio = map['bio'];
  classUser = map['classUser'];
  uid = map['uid'];
  email = map["email"];
  pic = map['pic'];
  section = map["section"];
  isOnline = map["isOnline"];
}

Map<String,dynamic> toJson(){
  return {
    "uid":uid,
    "nom":nom,
    'prenom':prenom,
    'bio':bio,
    "email":email,
    "username":username,
    "pic":pic,
    "classUser":classUser,
    "section":section,
    "isOnline":isOnline
  };
}


}