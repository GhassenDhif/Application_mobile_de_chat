import 'package:flutter/material.dart';


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home_Page")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ));
            },
            child: Container(
              height: 70.0,
              width: 300.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 20.0),
                        blurRadius: 30.0,
                        color: Colors.black12)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0)),
              child: Row(children: <Widget>[
                Container(
                  height: 70.0,
                  width: 250.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  child: Text(
                    'ISIMA_Chat',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .apply(color: Colors.black54),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(95.0),
                        topLeft: Radius.circular(95.0),
                        bottomRight: Radius.circular(200.0)),
                  ),
                ),
                Icon(
                  Icons.message,
                  size: 30.0,
                ),
              ]
              ),
            ),
          ),
          SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Container(),
                    ));
              },
              child: Container(
                height: 70.0,
                width: 300.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 20.0),
                          blurRadius: 30.0,
                          color: Colors.black12)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0)),
                child: Row(children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 250.0,
                    padding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                    child: Text(
                      'Section_Chat',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colors.black54),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(95.0),
                          topLeft: Radius.circular(95.0),
                          bottomRight: Radius.circular(200.0)),
                    ),
                  ),
                  Icon(
                    Icons.message,
                    size: 30.0,
                  ),
                ]),
              ),
            ),
          SizedBox(height: 30.0),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ));
            },
            child: Container(
              height: 70.0,
              width: 300.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 20.0),
                        blurRadius: 30.0,
                        color: Colors.black12)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0)),
              child: Row(children: <Widget>[
                Container(
                  height: 70.0,
                  width: 250.0,
                  padding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  child: Text(
                    'Class_Chat',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .apply(color: Colors.black54),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(95.0),
                        topLeft: Radius.circular(95.0),
                        bottomRight: Radius.circular(200.0)),
                  ),
                ),
                Icon(
                  Icons.message,
                  size: 30.0,
                ),
              ]),
            ),
          ),
          ]),
        ),
    );
  }
}
