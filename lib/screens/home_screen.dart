import 'dart:math';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:intl/intl.dart';
// Screens
import './most_duration.dart';
import './today_calls.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  double duration;
  String number;
  List<dynamic> allLogs;

  List<int> todayCalculator() {
    /* Calculate the 24 hour time from now to miliseconds
    as integer.*/
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 1)).millisecondsSinceEpoch;
    int to = now.millisecondsSinceEpoch;
    return [from, to];
  }

  Future<void> mostDuration() async {
    /*Calculate the most call duration then fill the
    name, duration and number variables by setState to pass them
    into the Most Duration Screen.
    */
    List<int> dates = todayCalculator();
    Iterable<CallLogEntry> logs = await CallLog.query(
      dateFrom: dates.first,
      dateTo: dates[1],
    );
    // create a list for duration to later get the max of list.
    List<int> durations = [];
    for (CallLogEntry log in logs) {
      if (log.duration is int) {
        durations.add(log.duration);
      }
    }
    // extract logs into new list to escape from its type.
    List newLog = [...logs];
    //
    int mostDurationIndex = durations.indexOf(durations.reduce(max));
    setState(() {
      name = newLog[mostDurationIndex].name;
      duration = durations.reduce(max) / 60;
      number = newLog[mostDurationIndex].number;
    });
  }

  Future<void> todaysCalls() async {
    /*Get all logs for today and pass them to List<dynamic>
    for Todays Calls Screen.*/
    List<int> dates = todayCalculator();
    Iterable<CallLogEntry> logs = await CallLog.query(
      dateFrom: dates.first,
      dateTo: dates[1],
    );
    setState(() {
      allLogs = [...logs];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "WHO CARES?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /******************************** Today Date *******************************/
                Container(
                  height: isPortrait ? size.height * 0.3 : size.height * 0.5,
                  // margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 4),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('Today is:'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          "${DateFormat.yMMMd().format(DateTime.now())}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                /******************************** Most Durations *******************************/
                GestureDetector(
                  onTap: () {
                    mostDuration().then((_) {
                      Navigator.of(context).pushNamed(
                        MostDurationScreen.routeName,
                        arguments: {
                          "name": name,
                          "duration": duration,
                          "number": number,
                        },
                      );
                    });
                  },
                  child: Container(
                    height: 150,
                    margin: isPortrait
                        ? const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5)
                        : EdgeInsets.symmetric(
                            vertical: 15, horizontal: size.height * 0.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(50),
                        bottomRight: const Radius.circular(50),
                      ),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 3),
                    ),
                    child: Center(
                      child: ListTile(
                        selectedTileColor: Theme.of(context).accentColor,
                        leading: Icon(
                          Icons.person_add,
                          size: 35,
                          color: Theme.of(context).accentColor,
                        ),
                        title: const Text(
                          "MOST DURATION",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Text(
                              "To find out who you talk to the most during the day!"),
                        ),
                        trailing: Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        // tileColor: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
                /******************************** Todays Calls *******************************/
                GestureDetector(
                  onTap: () {
                    todaysCalls().then((_) {
                      Navigator.of(context).pushNamed(
                          TodaysCallsScreen.routeName,
                          arguments: allLogs);
                    });
                  },
                  child: Container(
                    height: 150,
                    margin: isPortrait
                        ? const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5)
                        : EdgeInsets.symmetric(
                            vertical: 15, horizontal: size.height * 0.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(50),
                        bottomLeft: const Radius.circular(50),
                      ),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 3),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: Icon(
                          Icons.import_contacts,
                          size: 35,
                          color: Theme.of(context).accentColor,
                        ),
                        title: const Text(
                          "TODAYS CALLS",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Text("Show all calls log for Today."),
                        ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).primaryColor,
                        ),

                        // tileColor: Colors.lightGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: const Text('About App'),
                    content: const Text(
                        "This app help you to find out who you talk to the most during the day and "
                        "show you all calls log for today.\n\nDesign and Developed by:\nSina Karimi"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )),
          child: Icon(Icons.apps)),
    );
  }
}
