import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this. url});

  Future<void> getTime() async {
    String datetime;
    String offsetHour;
    String offsetMinutes;
    try {
      var finalUrl = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      final response = await get(finalUrl);
      Map data = jsonDecode(response.body);

      datetime = data["datetime"];
      offsetHour = data["utc_offset"].substring(1,3);
      offsetMinutes = data["utc_offset"].substring(4,6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHour), minutes: int.parse(offsetMinutes)));

      // set the time property and day time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      // print(isDayTime);
      time = DateFormat.jm().format(now);
      // print(time);

    } catch (e){
      print("Caught Error : $e");
      time = "Could not get time data...";
    }

  }
}