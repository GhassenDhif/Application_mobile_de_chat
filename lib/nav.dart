import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'homework/home_screen.dart';
import 'homework/messages_screen.dart';
import 'homework/profile_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

Future<void> _signOut(BuildContext context) async {
  try {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signOut();
  } catch (e) {
    print(e.toString());
  }
}
Future <void> confirmSignOut(BuildContext context) async {
  final didRequestSignOut = await showAlertDialog(
    context,
    title: 'Logout',
    content: 'Are you sure that you want to Logout?',
    cancelActionText: 'Cancel',
    defaultActionText: 'Logout',
  );
  if (didRequestSignOut == true) {
    _signOut(context);
  }
}

class _NavState extends State<Nav> {
  int _selectedIndex= 0;
  List<Widget>_widgetOptions =<Widget>[
    Home(),
    Messages(),
    ProfileScreen(),
  ];

  void _onItemTap(int index){
setState(() {
  _selectedIndex =index;
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label : 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title:Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title:Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
  }

