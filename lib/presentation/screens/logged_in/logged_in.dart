import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joebox/app/provider/database_manager.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:joebox/main.dart';
import 'package:joebox/presentation/components/texts/title_box.dart';
import 'package:joebox/presentation/screens/box/box.dart';
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
    Map<dynamic, dynamic>? caja;
    print("[USER ID]: ${user.uid}");
    caja = await database.getUserBox(user.uid);
    print("caja $caja");
    if (caja!.isEmpty) {
      Provider.of<Boxes>(context, listen: false).hasNoBoxes();
      Provider.of<Boxes>(context, listen: false).yourBox(_emptyBox());
    } else {
      Provider.of<Boxes>(context, listen: false).hasBoxes();
      Provider.of<Boxes>(context, listen: false).yourBox(_boxGrid(caja));
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> _logOut() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await provider.googleLogOut();
  }

  void _paintBox(String box) {
    print("$box");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BoxScreen(
                box: box,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(249, 202, 36, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(45, 52, 54, 1),
          title: Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                        radius: 15,
                      ),
                    )),
                Flexible(
                  flex: 4,
                  child: Container(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        user.displayName!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
              padding: const EdgeInsets.only(bottom: 8),
              child: TitleBox(
                title: Provider.of<Boxes>(context).title,
              ),
            ),
            Expanded(
              child: Container(child: Provider.of<Boxes>(context).box),
            ),
          ],
        ),
      );
    }
  }

  Widget _emptyBox() {
    return const SizedBox();
  }

  Widget _boxGrid(Map<dynamic, dynamic> boxMap) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () => _paintBox(boxMap["Box ${index + 1}"]),
                child: Container(
                  child: Column(
                    children: [
                      Image.asset("assets/logos/cube.png"),
                      Text("cube ${index + 1}")
                    ],
                  ),
                ),
              );
            },
            childCount: boxMap.length,
          ),
        ),
      ],
    );
  }
}
