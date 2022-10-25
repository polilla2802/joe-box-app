import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

Future<void> _signInWithGoogle(BuildContext context) async {
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  await provider.googleLogIn();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 202, 36, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(45, 52, 54, 1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "Bienvenido!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 64),
              child: Image.asset(
                "assets/logos/joe-box-logo.png",
                width: 200,
              ),
            ),
            Container(
              child: ElevatedButton.icon(
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Color.fromRGBO(45, 52, 54, 1),
                  ),
                  onPressed: () async {
                    await _signInWithGoogle(context);
                  },
                  label: const Text("Accede con google"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: const Color.fromRGBO(45, 52, 54, 1),
                      minimumSize: const Size(double.infinity, 50))),
            )
          ],
        ),
      ),
    );
  }
}
