// import 'package:butter/Screen/Modul5/data_services.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awatch/ScreenPage/LoginPage.dart';
import 'package:awatch/Utilities/FirestoreSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utilities/AuthServices.dart';
import 'AddFeed.dart';
import 'FeedDetail.dart';
import 'StaticFeedItem.dart';
import 'UserPost.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  SharedPreferences? prefs;
  bool? log;

  final Stream<QuerySnapshot> collectionReference = FirestoreSystem
      .readProyek();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initial();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text(
            "Riwayat",
            style: TextStyle(fontSize: 20),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(CupertinoIcons.plus),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFeed()),
            );
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirestoreSystem.readProyekDone(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext, index) {
                      var data = snapshot.data!.docs[index];
                      return GestureDetector(
                        child: StaticFeedItem(nama: data['nama'],),
                        onTap: () async {
                          prefs = await SharedPreferences.getInstance();
                          print("nama : ${data['nama']}");
                          print("id : ${data.id}");
                          // print("tm : ${data['tanggal-mulai']}");
                          // print("alamat : ${data['alamat']}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FeedDetail(proyekId: data.id, nama: data['nama'], status: data['status'],)));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext, index) {
                      return Divider(
                        height: 1,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  );
                }

                return Container();
              },
            ),
            // ListView.separated(
            //   itemCount: userPost.length,
            //   itemBuilder: (BuildContext, index) {
            //     return GestureDetector(
            //       child: StaticFeedItem(userPostt: userPost, idx: index),
            //       onTap: () async {
            //         prefs = await SharedPreferences.getInstance();
            //         print("asd : ${prefs?.getString('userid')}");
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     FeedDetail(userPost: userPost, idx: index)));
            //       },
            //     );
            //   },
            //   separatorBuilder: (BuildContext, index) {
            //     return Divider(
            //       height: 1,
            //     );
            //   },
            //   shrinkWrap: true,
            //   scrollDirection: Axis.vertical,
            // )
          ],
        ));
  }
}
