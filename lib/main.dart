import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:joebox/presentation/screens/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => Boxes(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<int, Color> color = {50: const Color.fromRGBO(136, 14, 79, .1)};
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: 'Joe Box',
          theme: ThemeData(
              fontFamily: 'Futura Pt Medium',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor: const Color.fromRGBO(249, 202, 36, 1)),
          home: const SplashScreen()));
}

class Boxes extends ChangeNotifier {
  String title = "";
  Widget? box;

  void hasBoxes() {
    title = "Your Boxes";
    notifyListeners();
  }

  void hasNoBoxes() {
    title = "You don't have any boxes";
    notifyListeners();
  }

  void yourBox(Widget newBox) {
    box = newBox;
    notifyListeners();
  }
}
