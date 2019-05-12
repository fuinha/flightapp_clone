import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    title: 'yeah',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  )
);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomeScreenTopPart()
        ],
      )
    );
  }
}


class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(height: 400.0, color: Colors.orange)
      ],
    );
  }

}



