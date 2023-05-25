import 'package:flutter/material.dart';
import 'UserPost.dart';

class AddFeed extends StatefulWidget {
  List<UserPost> userPost;

  AddFeed({Key? key, required this.userPost}) : super(key: key);

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  String img = "";
  String name = "";
  String username = "";
  String post = "";

  TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Tambah Proyek",
          style: TextStyle(fontSize: 20),
        ),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Nama Proyek"),
                // controller: tec,
                onChanged: (img) {
                  this.img = img;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Lokasi"),
                onChanged: (name) {
                  this.name = name;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Tanggal Mulai"),
                onChanged: (username) {
                  this.username = username;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Tanggal Selesai"),
                onChanged: (post) {
                  this.post = post;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      // fixedSize: const Size(150, 48),
                      minimumSize: const Size.fromHeight(50),
                      primary: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent),
                  child: Text("Tambah Progress"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 48),
                      primary: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent),
                  child: Text("Tambah Proyek"),
                ),
              ),
            ],
          )),
    );
  }
}
