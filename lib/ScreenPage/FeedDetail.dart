import 'package:awatch/ScreenPage/ProgressItem.dart';
import 'package:awatch/Utilities/FirestoreSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UserPost.dart';

class FeedDetail extends StatefulWidget {
  String proyekId;
  String nama;

  FeedDetail({Key? key, required this.proyekId, required this.nama}) : super(key: key);

  @override
  State<FeedDetail> createState() => _FeedDetailState();
}

class _FeedDetailState extends State<FeedDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.nama,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder(
                      stream:
                          FirestoreSystem.readProgress(docId: widget.proyekId),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext, index) {
                              var data = snapshot.data!.docs[index];
                              return GestureDetector(
                                child: ProgressItem(nama: data['nama']),
                                onTap: () async {
                                  print("nama : ${data['nama']}");
                                  print("id : ${data.id}");
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
                  ],
                )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(150, 48),
                                      primary: Colors.white,
                                      elevation: 3,
                                      backgroundColor: Colors.deepOrangeAccent),
                                  child: Text("Lihat Foto"),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(150, 48),
                                      primary: Colors.white,
                                      elevation: 3,
                                      backgroundColor: Colors.deepOrangeAccent),
                                  child: Text("Proyek Selesai"),
                                ),
                              ],
                            )
                          ],
                        )),
                    Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(150, 48),
                                      primary: Colors.white,
                                      elevation: 3,
                                      backgroundColor: Colors.deepOrangeAccent),
                                  child: Text("Upload Foto"),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(150, 48),
                                      primary: Colors.deepOrangeAccent,
                                      elevation: 3,
                                      backgroundColor: Colors.white),
                                  child: Text("Update Proyek"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tambah Progress",
                                  style: TextStyle(
                                      backgroundColor: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ))
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
