import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: Colors.black87,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Staff ID *",
                      hintText: "Your Staff ID Number",
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      // suffixIcon: Icon(Icons.remove_red_eye),
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState((){
                            _obscureText =!_obscureText;
                          });
                        },
                      ),
                      labelText: "Password *",
                      hintText: "Your Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 52.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48.0,
                  height: 48.0,
                  child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () {
                      final progress = ProgressHUD.of(context);
                      progress?.showWithText("Loading...");
                      FocusScope.of(context).requestFocus(FocusNode());
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, "/home");
                        progress?.dismiss();
                      });
                    },
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
