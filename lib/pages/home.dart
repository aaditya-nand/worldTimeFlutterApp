import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    String bgImg = data['isDayTime'] ? "day.png" : "night.png";
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: 180.0,
                    child: ElevatedButton(
                        onPressed: () async{
                          dynamic result = await Navigator.pushNamed(context, "/location");
                          setState(() {
                            data = {
                              "time" : result["time"],
                              "location" : result["location"],
                              "flag" : result["flag"],
                              "isDayTime" : result["isDayTime"]
                            };
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.location_on),
                            SizedBox(width: 8.0),
                            Text("Edit Location"),
                          ],
                        ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/${data["flag"]}"),
                    ),
                    const SizedBox(width: 10.0,),
                    Text(
                      data["location"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                Text(
                  data['time'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 66.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
