import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:joebox/presentation/screens/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: 'Joe Box',
          theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor: Colors.purple.shade900,
              brightness: Brightness.dark),
          home: const SplashScreen()));
}
