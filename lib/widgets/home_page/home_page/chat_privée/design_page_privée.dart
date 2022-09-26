import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_tracker_flutter_course/constants.dart';
import 'package:time_tracker_flutter_course/models/user_model.dart';
import 'package:time_tracker_flutter_course/services/database_service.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/profil_controller.dart';
import 'package:time_tracker_flutter_course/view_controller.dart/user_controller.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_priv%C3%A9e/chat_pri.dart';
import 'package:time_tracker_flutter_course/widgets/home_page/home_page/chat_priv%C3%A9e/chat_priv%C3%A9e.dart';




class AcceuilPrive extends StatefulWidget {
  @override
  _AcceuilPriveState createState() => _AcceuilPriveState();
}

class _AcceuilPriveState extends State<AcceuilPrive> {
  UserController userController = Get.put(UserController());

  CollectionReference _users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _users.where('uid',isNotEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
        builder: (context, snapshot) {
         if(snapshot.hasData){
           List<UserModel> users = [];
           snapshot.data.docs.map((user){
             users.add(UserModel.fromJson(user.data()));

           }).toList();
           return CustomScrollView(
             slivers: [
               SliverAppBar(
                 elevation: 10.0,
                 centerTitle: true,
                 title: Text("Chat privée",style: Theme.of(context).textTheme.headline5.copyWith(
                 ),
                 ),
                 actions: [
                   Padding(
                     padding: EdgeInsets.only(right: kPadding),
                     child: IconButton(
                       icon: Icon(Icons.search_outlined),
                       onPressed: (){
                         showSearch(context: context, delegate: Search(contacts: userController.contact));
                       },
                     ),

                   )
                 ],
               ),
               SliverToBoxAdapter(
                 child: GridView.builder(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         childAspectRatio: 1.2,
                         crossAxisCount: 2,
                         mainAxisSpacing: 15.0,
                         crossAxisSpacing: 15.0
                     ),
                     shrinkWrap: true,
                     itemCount: users.length,
                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                     scrollDirection: Axis.vertical,
                     primary: false,
                     itemBuilder: (context,index){
                       return users.isEmpty ?Center(child :Text("Aucune utilisateur ")):
                       GestureDetector(
                         onTap: (){
                           Get.to(()=>DiscussionPriv(
                             idUser: users[index].uid,
                             username: users[index].username,
                             url: users[index].pic,
                           ));
                         },
                         child: Card(
                           elevation: 5.0,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                                Expanded(
                                  child: Container(
                                     padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                    ),
                                    child:users[index].pic==""?Center(
                                      child: Text(users[index].username[0],style: Theme.of(context).textTheme.headline5,),
                                    ):   ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(users[index].pic,fit: BoxFit.cover,width: 80,height: 60,),
                                    ),
                                  ),
                                ),
                               SizedBox(height: 10,),
                               Text(users[index].username,style: Theme.of(context).textTheme.headline6,),
                               SizedBox(height: 10,),
                             ],
                           )
                         ),
                       );
                     }),
               ),

             ],
           );
         }else if(snapshot.connectionState == ConnectionState.waiting){
           return Center(
             child: CircularProgressIndicator(),
           );
         }else{
           return Center(
             child: CircularProgressIndicator(),
           );
         }
        }
      ),
    );
  }
}


class Search extends SearchDelegate<String>{

   List<UserModel> contacts;

  Search({this.contacts});

  var uid;
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query = "";

        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
      close(context,null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return  FutureBuilder<UserModel>(
      future: ServiceDatabase().fetchuserByuserName(query),
        builder: (context,snapshot){
        if(snapshot.hasData){
          return ListTile(
            onTap: (){
              Get.to(()=>DiscussionPriv(
                idUser: snapshot.data.uid,
                url: snapshot.data.pic,
                username: snapshot.data.username,
              ));
            },
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipRRect(
                  borderRadius:BorderRadius.circular(15.0),
                    child: Image.network(snapshot.data.pic,fit: BoxFit.cover,)),
            ),
            title: Text(snapshot.data.username),
            subtitle: Row(
              children: [
                Text(snapshot.data.nom),
                SizedBox(width: 5.0,),
                Text(snapshot.data.prenom)
              ],
            ),
          );
        }else if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return Center(
            child: Text("Aucun Etudiant trouver,\n essayez de chercher avec Username",
              style: Theme.of(context).textTheme.headline5,textAlign: TextAlign.center,),
          );
        }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var search = query.isEmpty ?contacts:contacts.where((user)=>user.username.toLowerCase().startsWith(query)).toList();
    return ListView.builder(
    itemCount: search.length,
        itemBuilder: (context,index){
      return ListTile(
        onTap: (){
          query = search[index].username;
          showResults(context);
        },
        title: Text(search[index].username),
        leading: Icon(Icons.person_pin),
        subtitle: Row(
          children: [
            Text(search[index].nom),
            SizedBox(width: 5.0,),
            Text(search[index].prenom)
          ],
        ),
      );
    });
  }

}