import 'package:flutter/widgets.dart';

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
