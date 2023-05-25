// import 'package:butter/Screen/Modul5/data_services.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awatch/ScreenPage/LoginPage.dart';
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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  SharedPreferences? prefs;
  String? username;
  bool? log;

  List<UserPost> userPost = [
    UserPost(
        "Proyek 1",
        "https://i.pinimg.com/originals/d7/dc/85/d7dc8575043714b163873607dcee15f5.jpg",
        "cabbit",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In commodo dui velit, ac maximus mauris."),
    UserPost(
        "Proyek 2",
        "https://i.pinimg.com/564x/71/9a/8c/719a8ca593b340c0343d4436d4988b48.jpg",
        "hat",
        "Proin eros magna, condimentum nec dolor sed, semper dignissim tortor. Sed a ipsum metus. Proin aliquam dignissim accumsan. Fusce nec."),
    UserPost(
        "Proyek 3",
        "https://i.pinimg.com/564x/7e/b1/60/7eb16069cd22cdb218301764d2fdda73.jpg",
        "tukk",
        "In hac habitasse platea dictumst. Proin scelerisque mauris eu interdum suscipit. Praesent fermentum quis turpis quis fermentum. Cras condimentum ullamcorper dui ut fringilla. Mauris."),
    UserPost(
        "Proyek 4",
        "https://i.pinimg.com/564x/08/c3/f5/08c3f52db7c972c60287076ea497b388.jpg",
        "lya",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in euismod ligula. Nam cursus lorem in purus tempor, id aliquam."),
    UserPost(
        "Proyek 5",
        "https://i.pinimg.com/564x/d5/9a/b5/d59ab590c1c5f069f8c44ecab9a92319.jpg",
        "chungee",
        "Donec sollicitudin, mauris quis placerat dignissim, augue nulla molestie nibh."),
  ];

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  void addData(UserPost user) {
    setState(() {
      userPost.add(user);
    });
  }

  void addPage() async {
    final add = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddFeed(userPost: userPost)));
    addData(add);
  }

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(CupertinoIcons.plus),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFeed(userPost: userPost)),
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
                  onPressed: () {},
                  child: Text('Riwayat Proyek'),
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 48),
                      primary: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent)
              ),
            ),
            SizedBox(height: 20),
            ListView.separated(
              itemCount: userPost.length,
              itemBuilder: (BuildContext, index) {
                return GestureDetector(
                  child: StaticFeedItem(userPostt: userPost, idx: index),
                  onTap: () async {
                    prefs = await SharedPreferences.getInstance();
                    print("asd : ${prefs?.getString('userid')}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FeedDetail(userPost: userPost, idx: index)));
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
            )
          ],
        ));
  }
}
