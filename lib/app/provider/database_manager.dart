import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference userList =
      FirebaseFirestore.instance.collection("users");
  DocumentSnapshot? box;
  var caja;

  Future<String> getUserBox(String uid) async {
    print("[getUserBoxes USER ID]: $uid");
    try {
      box = await userList.doc(uid).get();
      caja = box!.data() as Map;
    } catch (e) {
      print(e.toString());
    }
    return caja["Box"].toString();
  }
}
