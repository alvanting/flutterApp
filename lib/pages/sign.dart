import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => SuccessPageState();

  void cancel() {}
}

class SuccessPageState extends State<SuccessPage> {
  late DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: Colors.black87,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Success\n${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        final progress = ProgressHUD.of(context);
                        progress?.showWithText("Loading...");
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacementNamed(context, "/home");
                          progress?.dismiss();
                        });
                      },
                      child: const Text("Back to home page")),
                ),
              ],
            ),
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
      ),
    );
  }
}
