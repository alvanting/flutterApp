import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: KmTimer(),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Text("Test Account"),
              ),
              ListTile(
                title: const Text("Sign out"),
                onTap: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content:
                          const Text("Are you sure to exit current account."),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", ModalRoute.withName('/')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KmTimer extends StatefulWidget {
  const KmTimer({super.key});

  @override
  State<KmTimer> createState() => KmTimerState();

  void cancel() {}
}

class KmTimerState extends State<KmTimer> {
  late Timer timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  var weekday = [
    " ",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    List<String> list = [];

    return ProgressHUD(
      backgroundColor: Colors.black87,
      child: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              child: Divider(
                height: 8.0,
                color: Colors.grey[200],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 200)),
                  Text(
                    "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    weekday[dateTime.weekday],
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
                title: ElevatedButton(
                    onPressed: () {
                      final progress = ProgressHUD.of(context);
                      progress?.showWithText("Loading...");
                      Future.delayed(const Duration(seconds: 2), () {
                        list.add(
                            "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}");
                        if (kDebugMode) {
                          log("Time: $list");
                        }
                        Navigator.pushReplacementNamed(context, "/success");
                        progress?.dismiss();
                      });
                    },
                    child: const Text("Please scan your face")))
          ],
        ),
      ),
    );
  }
}
