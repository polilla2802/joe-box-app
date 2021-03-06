import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joebox/app/provider/database_manager.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:joebox/main.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatefulWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  String box = "";
  DatabaseManager database = DatabaseManager();
  bool loading = true;

  @override
  void initState() {
    fetchBox();
    super.initState();
  }

  Future<void> fetchBox() async {
    String caja;
    print("[USER ID]: ${user.uid}");
    caja = await database.getUserBox(user.uid);
    print("caja $caja");
    if (caja.isEmpty) {
      Provider.of<Boxes>(context, listen: false).hasNoBoxes();
      Provider.of<Boxes>(context, listen: false).yourBox(SizedBox());
    } else {
      Provider.of<Boxes>(context, listen: false).hasBoxes();
      Provider.of<Boxes>(context, listen: false).yourBox(Image.network(
        caja,
        width: double.infinity,
      ));
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> _logOut() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await provider.googleLogOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(249, 202, 36, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(45, 52, 54, 1),
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      radius: 15,
                    )),
                Container(
                    child: Text(
                  'Hi ' + user.displayName!,
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async => _logOut(),
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    if (loading == true) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.black,
            )
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 32),
              child: TitleBox(
                title: Provider.of<Boxes>(context).title,
              ),
            ),
            Container(
              child: Provider.of<Boxes>(context).box,
            ),
            Text(box)
          ],
        ),
      );
    }
  }

  Widget _buildBox(BuildContext context) {
    return SizedBox();
  }
}

class TitleBox extends StatelessWidget {
  final String? title;

  TitleBox({this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(45, 52, 54, 1)),
    );
  }
}
