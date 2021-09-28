import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    Future<void> _LogOut() async {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      await provider.googleLogOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged In"),
        actions: [
          TextButton(
              onPressed: () async => _LogOut(), child: const Text("Log Out"))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.network(user.photoURL!)),
            Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Hi ' + user.displayName!)),
            Container(child: Text(user.email!)),
          ],
        ),
      ),
    );
  }
}
