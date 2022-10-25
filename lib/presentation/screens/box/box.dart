import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joebox/app/provider/google_sign_in.dart';
import 'package:joebox/main.dart';
import 'package:joebox/presentation/components/texts/title_box.dart';
import 'package:provider/provider.dart';

class BoxScreen extends StatefulWidget {
  String? box;
  BoxScreen({Key? key, this.box}) : super(key: key);
  User user = FirebaseAuth.instance.currentUser!;

  @override
  _BoxScreenState createState() => _BoxScreenState(box: box);
}

class _BoxScreenState extends State<BoxScreen> {
  String? box;

  _BoxScreenState({this.box});

  @override
  void initState() {
    print("box $box");

    super.initState();
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
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.photoURL!),
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
                        widget.user.displayName!,
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
              child: Container(
            child: Column(
              children: [
                Container(
                  child: Image.network(
                    box!,
                    width: 500,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
