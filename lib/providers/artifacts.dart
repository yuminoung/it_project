import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Artifact {
  String image;
  String message;
  Timestamp time;
  String docID;
  String username;
  String uid;
  Artifact(
      this.docID, this.image, this.message, this.time, this.uid, this.username);
}

class Artifacts with ChangeNotifier {
  String userID;
  List<Artifact> _artifact = [];
  Artifacts(this.userID);
  List<Artifact> get artifacts {
    return [..._artifact];
  }

  Future<void> fetchAndSetArtifacts() async {
    print('entered arti');
    var all = await Firestore.instance
        .collection('artifacts')
        // .where('user', isEqualTo: 'Yumin')
        .orderBy('created_at', descending: true)
        .getDocuments();
    var list = all.documents;
    print(list.length);
    print(list.map((x) => {x.data}).toList());

    // all.map((arti) {
    //   print('ffff');
    //   print(arti);
    // });
    //   final url =
    //       'https://flutter-update.firebaseio.com/orders/$userId.json?auth=$authToken';
    //   final response = await http.get(url);
    //   final List<OrderItem> loadedOrders = [];
    //   final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //   if (extractedData == null) {
    //     return;
    //   }
    //   extractedData.forEach((orderId, orderData) {
    //     loadedOrders.add(
    //       OrderItem(
    //         id: orderId,
    //         amount: orderData['amount'],
    //         dateTime: DateTime.parse(orderData['dateTime']),
    //         products: (orderData['products'] as List<dynamic>)
    //             .map(
    //               (item) => CartItem(
    //                 id: item['id'],
    //                 price: item['price'],
    //                 quantity: item['quantity'],
    //                 title: item['title'],
    //               ),
    //             )
    //             .toList(),
    //       ),
    //     );
    //   });
    //   _orders = loadedOrders.reversed.toList();
    //   notifyListeners();
    // }
  }
}
