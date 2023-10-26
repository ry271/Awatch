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
import 'HistoryPage.dart';
import 'ProfilePage.dart';
import 'StaticFeedItem.dart';
import 'UserPost.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs;
  bool? log;
  int _selectedIndex = 0;

  final Stream<QuerySnapshot> collectionReference =
      FirestoreSystem.readProyek();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initial();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text(
            "Awatch",
            style: TextStyle(fontSize: 20),
          ),
          // title: Text(pageTitle.elementAt(_selectedIndex),
          //   style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            TextButton(
              // icon: const Icon(
              //   Icons.settings,
              //   color: Colors.black,
              // ),
              onPressed: () async {
                AuthService service = AuthService(FirebaseAuth.instance);
                prefs?.setBool('login', true);
                // print(service.checkUid().toString());
                service.logOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text("Awatch"),
                decoration: BoxDecoration(color: Colors.deepOrangeAccent),
              ),
              ListTile(
                title: Text("Testing"),
                onTap: () {
                  print(_firebaseAuth.currentUser!.uid);
                },
              ),
              ListTile(
                title: Text("Profile"),
                onTap: () {
                  var collection = FirebaseFirestore.instance.collection('users');
                  collection.doc(_firebaseAuth.currentUser!.uid).snapshots().listen((docSnapshot) {
                    if (docSnapshot.exists) {
                      Map<String, dynamic> data = docSnapshot.data()!;
                      // You can then retrieve the value from the Map like this:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                  UID: _firebaseAuth.currentUser!.uid,
                                  nama: data["nama"],
                                  jabatan: data["jabatan"],
                                  telepon: data["telepon"])));
                    }
                    else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                  UID: "UID",
                                  nama: 'nama',
                                  jabatan: "jabatan",
                                  telepon: "telepon")));
                    }
                  });
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(CupertinoIcons.plus),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddFeed()),
            );
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  },
                  child: Text('Riwayat Proyek'),
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 48),
                      primary: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent)),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirestoreSystem.readProyek(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext, index) {
                      var data = snapshot.data!.docs[index];
                      return GestureDetector(
                        child: StaticFeedItem(
                          nama: data['nama'],
                        ),
                        onTap: () async {
                          prefs = await SharedPreferences.getInstance();
                          print("nama : ${data['nama']}");
                          print("id : ${data.id}");
                          // print("tm : ${data['tanggal-mulai']}");
                          // print("alamat : ${data['alamat']}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedDetail(
                                        proyekId: data.id,
                                        nama: data['nama'],
                                        status: data['status'],
                                      )));
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
