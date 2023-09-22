import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/FirestoreSystem.dart';

class UploadImagePage extends StatefulWidget {
  String proyekId;

  UploadImagePage({Key? key, required this.proyekId})
      : super(key: key);

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
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
            progId = itemValue;
            DocumentSnapshot variable = await FirebaseFirestore.instance
                .collection('proyek')
                .doc(widget.proyekId)
                .collection('progress')
                .doc(itemValue)
                .get();
            setState(() {
              nama = variable.get('nama');
              status = variable.get('status');

              print("Progress id = $progId");
              // print(variable.get('status'));
            });
            // print("prog id : $itemValue");
          },
          value: progId,
          isExpanded: false,
        );
      },
    );

    _getFromGallery() async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          print("${imageFile?.path}");
        });
      }
    }

    /// Get from Camera
    _getFromCamera() async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 300,
        maxHeight: 300,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          print("${imageFile?.path}");
        });
      }
    }

    final buttonAddImage = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _getFromCamera();
              },
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 48),
                  primary: Colors.white,
                  elevation: 3,
                  backgroundColor: Colors.deepOrangeAccent),
              child: Text("Ambil dari Kamera"),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _getFromGallery();
              },
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 48),
                  primary: Colors.white,
                  elevation: 3,
                  backgroundColor: Colors.deepOrangeAccent),
              child: Text("Ambil dari Galeri"),
            ),
          ],
        )
      ],
    );

    final imageContainer = Container(
        child: imageFile == null
            ? Container(
                alignment: Alignment.center,
                child: buttonAddImage,
              )
            : Column(
                children: [
                  Container(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buttonAddImage
                ],
              ));

    // final buttonAddImage =

    final tambahProyekButton = Container(
      margin: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () async {
          print("${imageFile?.path}");

          if (imageFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Foto masih kosong!"),
            ));
          } else if ( progId == "0") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Progress belum dipilih!"),
            ));
          } else {
            String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirImages = referenceRoot.child("images");
            Reference referenceImageToUpload =
            referenceDirImages.child(uniqueName);

            try {
              await referenceImageToUpload.putFile(File(imageFile!.path));
              imageUrl = await referenceImageToUpload.getDownloadURL();
              var response = await FirestoreSystem.uploadImage(
                  nama: nama,
                  status: status,
                  docId: widget.proyekId,
                  progId: progId,
                  imageUrl: imageUrl);

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

              print("prog id : ${progId}");
            } catch (error) {}
            ;
            print(imageUrl);
          };


        },
        style: TextButton.styleFrom(
            fixedSize: const Size(150, 48),
            primary: Colors.white,
            backgroundColor: Colors.deepOrangeAccent),
        child: Text("Upload Foto"),
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Upload Foto",
          style: TextStyle(fontSize: 20),
        ),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
          child: Container(
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
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // buttonAddImage,
                  const SizedBox(
                    height: 10,
                  ),
                  tambahProyekButton
                ],
              ))),
    );
  }
}
