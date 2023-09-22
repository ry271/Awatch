import 'package:awatch/ScreenPage/ProgressItem.dart';
import 'package:awatch/ScreenPage/UploadImagePage.dart';
import 'package:awatch/Utilities/FirestoreSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AddProgress.dart';
import 'EditProgress.dart';
import 'UserPost.dart';
import 'ViewImagePage.dart';

class FeedDetail extends StatefulWidget {
  String proyekId;
  String nama;
  int status;

  FeedDetail(
      {Key? key,
      required this.proyekId,
      required this.nama,
      required this.status})
      : super(key: key);

  @override
  State<FeedDetail> createState() => _FeedDetailState();
}

class _FeedDetailState extends State<FeedDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget _showDetail = Column(
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ViewImagePage(
                                    proyekId: widget.proyekId)));
                      },
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
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AddProgress(docId: widget.proyekId);
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                          fixedSize: const Size(150, 48),
                          primary: Colors.white,
                          elevation: 3,
                          backgroundColor: Colors.deepOrangeAccent),
                      child: Text("Tambah Progress"),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => UploadImagePage(
                                    proyekId: widget.proyekId)));
                      },
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
                      onPressed: () async {
                        var response = await FirestoreSystem.updateProyek(
                            nama: widget.nama,
                            status: 1,
                            docId: widget.proyekId);
                        if (response != 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response.message.toString()),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response.message.toString()),
                          ));
                        }
                      },
                      style: TextButton.styleFrom(
                          fixedSize: const Size(150, 48),
                          primary: Colors.deepOrangeAccent,
                          elevation: 3,
                          backgroundColor: Colors.white),
                      child: Text("Proyek Selesai"),
                    )
                  ],
                ),
              ],
            ))
      ],
    );

    Widget _showDetailHistory = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => ViewImagePage(
                        proyekId: widget.proyekId)));
          },
          style: TextButton.styleFrom(
              fixedSize: const Size(150, 48),
              primary: Colors.white,
              elevation: 3,
              backgroundColor: Colors.deepOrangeAccent),
          child: Text("Lihat Foto"),
        )
      ],
    );

    Widget _stream = StreamBuilder(
      stream: FirestoreSystem.readProgress(docId: widget.proyekId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext, index) {
              var data = snapshot.data!.docs[index];
              return GestureDetector(
                child: ProgressItem(nama: data['nama']),
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return EditProgress(
                          docId: widget.proyekId, progId: data.id);
                    },
                  );
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
    );

    Widget _streamHistory = StreamBuilder(
      stream: FirestoreSystem.readProgress(docId: widget.proyekId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext, index) {
              var data = snapshot.data!.docs[index];
              return GestureDetector(
                child: ProgressItem(nama: data['nama']),
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
    );

    Widget _statusStream() {
      if (widget.status == 0) {
        return _stream;
      } else if (widget.status == 1) {
        return _streamHistory;
      }
      return Container();
    }

    Widget _statusPage() {
      if (widget.status == 0) {
        return _showDetail;
      } else if (widget.status == 1) {
        return _showDetailHistory;
      }
      return Container();
    }

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
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 7, child: _statusStream()),
                Expanded(flex: 3, child: _statusPage())
              ],
            )));
  }
}
