import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/FirestoreSystem.dart';

class ViewImagePage extends StatefulWidget {
  String proyekId;

  ViewImagePage({Key? key, required this.proyekId}) : super(key: key);

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  String progId = "0";
  String imageUrl = "";
  String nama = "";
  int status = 0;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final dropdownProgress = StreamBuilder(
      stream: FirestoreSystem.readProgress(docId: widget.proyekId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<DropdownMenuItem> progressItem = [];
        if (snapshot.hasData) {
          final progresses = snapshot.data?.docs.reversed.toList();
          progressItem.add(
              DropdownMenuItem(value: "0", child: Text("Selected Progress")));
          for (var item in progresses!) {
            progressItem.add(
                DropdownMenuItem(value: item.id, child: Text(item['nama'])));
          }
        }
        return DropdownButton(
          items: progressItem,
          onChanged: (itemValue) async {
            DocumentSnapshot variable = await FirebaseFirestore.instance
                .collection('proyek')
                .doc(widget.proyekId)
                .collection('progress')
                .doc(itemValue)
                .get();
            setState(() {
              progId = itemValue;
              nama = variable.get('nama');
              status = variable.get('status');
              imageUrl = variable.get('imageUrl');

              // print(imageUrl);
              // print(variable.get('status'));
            });
            // print("prog id : $itemValue");
          },
          value: progId,
          isExpanded: false,
        );
      },
    );

    final imageContainer = Container(
        width: double.infinity,
        child: imageUrl == ""
            ? Container(
                alignment: Alignment.center,
                child: Text("Foto Kosong"),
              )
            : Container(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                  width: 300,
                  height: 300,
                ),
              ));

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Lihat Foto",
          style: TextStyle(fontSize: 20),
        ),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  dropdownProgress,
                  const SizedBox(
                    height: 20,
                  ),
                  imageContainer,
                ],
              ))),
    );
  }
}
