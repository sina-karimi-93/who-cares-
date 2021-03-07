import 'package:flutter/material.dart';

class TodaysCallsScreen extends StatelessWidget {
  static const routeName = '/todays-call';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List logs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todays Calls"),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height * 0.9,
        child: ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, int index) {
            return ExpansionTile(
              backgroundColor: Color.fromRGBO(223, 223, 223, 1),
              tilePadding: EdgeInsets.all(15),
              leading: Icon(
                Icons.person,
                color: Theme.of(context).accentColor,
                size: 35,
              ),
              title: Text(
                logs[index].name != null
                    ? logs[index].name
                    : logs[index].number,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                logs[index].number,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                "${logs[index].callType.toString().substring(9)}",
                style: TextStyle(
                    color:
                        logs[index].callType.toString().substring(9) == "missed"
                            ? Colors.red
                            : Theme.of(context).primaryColor),
              ),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.timer_rounded,
                    color:
                        logs[index].callType.toString().substring(9) == "missed"
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                  ),
                  title: Text("${(logs[index].duration / 60).floor()} Minutes"),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
