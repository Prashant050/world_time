import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';


class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'uk.png', country: 'Europe/London'),
    WorldTime(location: 'Athens', flag: 'greece.png', country: 'Europe/Berlin'),
    WorldTime(location: 'Cairo', flag: 'egypt.png', country: 'Africa/Cairo'),
    WorldTime(location: 'Nairobi', flag: 'kenya.png', country: 'Europe/Nairobi'),
    WorldTime(location: 'Chicago', flag: 'usa.png', country: 'America/Chicago'),
    WorldTime(location: 'New York', flag: 'usa.png', country: 'America/New_York'),
    WorldTime(location: 'Seoul', flag: 'south_korea.png', country: 'Asia/Seoul'),
    WorldTime(location: 'Jakarta', flag: 'indonesia.png', country: 'Asia/Jakarta'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    //navigate to home screen
    // ignore: use_build_context_synchronously
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDaytime,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },

      ),

    );
  }
}
