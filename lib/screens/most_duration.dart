import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MostDurationScreen extends StatelessWidget {
  static const routeName = '/most-duration';

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments as Map;
    String name = data["name"];
    double duration = data["duration"];
    String number = data["number"];

    Size size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Most Duration"),
      ),
      body: SingleChildScrollView(
        child: Card(
          // color: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: const Radius.circular(7),
              topRight: const Radius.circular(7),
              bottomRight: const Radius.circular(7),
            ),
          ),
          margin: isPortrait
              ? const EdgeInsets.symmetric(vertical: 20, horizontal: 15)
              : EdgeInsets.symmetric(
                  vertical: 20, horizontal: size.height * 0.3),
          elevation: 15,
          // shadowColor: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  color: Theme.of(context).accentColor,
                  size: 130,
                ),
                Text(
                  name == null ? "$number" : "$name",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "$number",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    "${DateFormat.yMMMd().format(DateTime.now())}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.timelapse,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    "${duration.round()} Minutes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
