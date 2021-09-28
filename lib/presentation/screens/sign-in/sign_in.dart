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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Joe Box"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: ElevatedButton.icon(
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _signInWithGoogle(context);
                  },
                  label: const Text("Sign In with google"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.white,
                      minimumSize: const Size(double.infinity, 50))),
            )
          ],
        ),
      ),
    );
  }
}
