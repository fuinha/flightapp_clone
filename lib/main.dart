import 'package:flight_list_clone/flight_list.dart';
import 'package:flutter/material.dart';
import 'package:flight_list_clone/CustomShapeClipper.dart';
import 'package:flight_list_clone/CustomAppBar.dart';

void main() => runApp(MaterialApp(
      title: 'flight list app',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

Color firstColor = Color(0xFFF47015);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

List<String> locations = ['Boston (BOS)', 'New York City (JFK)'];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomAppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              HomeScreenTopPart(),
              HomeScreenBottomPart(),
            ],
          ),
        ));
  }
}

const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 17.0);

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),

            //オレンジのバック
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, secondColor])),

              //ロケーションなどのアイコンたち
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),

                  //ロケーションアイコン＋ ドロップダウンメニュー + Settings
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        PopupMenuButton(
                          onSelected: (index) {
                            setState(() {
                              selectedLocationIndex = index;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                locations[selectedLocationIndex],
                                style: dropDownLabelStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                          //popupmenuitemの引数がintなのはvalueがint型だから
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  child: Text(
                                    locations[0],
                                    style: dropDownMenuItemStyle,
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    locations[1],
                                    style: dropDownMenuItemStyle,
                                  ),
                                  value: 1,
                                )
                              ],
                        ),
                        Spacer(),
                        Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),

                  //真ん中のテキスト
                  Text(
                    'Where would\nyou want to go?',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  //入力欄
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Material(
                      elevation: 5.0, //入力欄に影をつける(elevation:標高)
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: TextField(
                          controller: TextEditingController(
                            text: null,
                          ),
                          style: dropDownMenuItemStyle,
                          cursorColor: appTheme.primaryColor,
                          decoration: InputDecoration(
                              hintText: locations[1],
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 14.0),
                              suffixIcon: Material(
                                elevation: 2.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FlightListingScreen()));
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    )),
                              ),
                              border: InputBorder.none)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  //flights, hotelボタン
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        child: ChoiceChip(
                            Icons.flight_takeoff, "Flights", isFlightSelected),
                        onTap: () {
                          setState(() {
                            isFlightSelected = true;
                          });
                        },
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      InkWell(
                        child: ChoiceChip(
                            Icons.hotel, "Hotels", !isFlightSelected),
                        onTap: () {
                          setState(() {
                            isFlightSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool selected;

  ChoiceChip(this.icon, this.text, this.selected);

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: widget.selected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(30)))
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

class HomeScreenBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Currently Watched Items",
                style: dropDownMenuItemStyle,
              ),
              Spacer(),
              Text(
                "VIEW ALL(12)",
                style: viewAllStyle,
              )
            ],
          ),
        ),
        Container(
          height: 240.0,
          child:
              ListView(scrollDirection: Axis.horizontal, children: cityCards),
        )
      ],
    );
  }
}

List<CityCard> cityCards = [
  CityCard("assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "45", "4,299",
      "2,250"),
  CityCard("assets/images/athens.jpg", "Las Vegas", "Feb 2019", "10", "4299",
      "2250"),
  CityCard("assets/images/sydney.jpeg", "Las Vegas", "Feb 2019", "60", "4299",
      "2250"),
  CityCard("assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "30", "4299",
      "2250"),
  CityCard("assets/images/athens.jpg", "Las Vegas", "Feb 2019", "95", "4299",
      "2250"),
  CityCard("assets/images/sydney.jpeg", "Las Vegas", "Feb 2019", "80", "4299",
      "2250"),
];

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;

  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  width: 160.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.1)
                        ])),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(cityName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18.0)),
                          Text(monthYear,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 14.0)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          "$discount%",
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Text(
                "$newPrice yen",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "($oldPrice yen)",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
