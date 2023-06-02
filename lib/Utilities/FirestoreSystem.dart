import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('proyek');

class FirestoreSystem {
  static Future<Response> addProyek(
      {required String nama,
      required String alamat,
      required String tm,
      required int status}) async {
    Response response = Response();
    DocumentReference documentReference = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "alamat": alamat,
      "tanggal-mulai": tm,
      "status": status
    };

    var result = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully create proyek to database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Stream<QuerySnapshot> readProyek() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Stream<QuerySnapshot> readProgress({required String docId}) {
    CollectionReference notesItemCollection =
        _Collection.doc(docId).collection('progress');

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateProyek({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no": contactno
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteProyek({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
