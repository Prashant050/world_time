import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time = ""; // the time in that location
  String flag; // url to an asset flag icon
  String country; // location url for api endpoint; // location url for api endpoint url
  bool isDaytime = false; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.country });

  Future<void> getTime() async {
    try {
      // make the request
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$country');
      var response = await http.get(url);
      Map data = jsonDecode(response.body);
      //print(data['datetime']);
      // print(data['offset']);


      // get properties from data
      var datetime = data['datetime'];
      var offset = data['utc_offset'];
      int hour = int.parse(offset.substring(1,3));
      int minutes = int.parse(offset.substring(4,6));
      // print(datetime);
      //print(offset);

      //create a dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: hour, minutes: minutes));
      //print(now);

      //set the time property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

    }
    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }



  }
}


