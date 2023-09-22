import 'package:awatch/Utilities/FirestoreSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProgress extends StatefulWidget {
  String docId;

  AddProgress({Key? key, required this.docId}) : super(key: key);

  @override
  State<AddProgress> createState() => _AddProgressState();
}

class _AddProgressState extends State<AddProgress> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _progressName = TextEditingController();

  @override
  void dispose() {
    _progressName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tambah progress baru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _progressName,
              decoration: InputDecoration(
                labelText: 'Nama progress',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama progress masih kosong!';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var response = await FirestoreSystem.addProgress(
                      nama: _progressName.text,
                      status: 0,
                      docId: widget.docId,
                      imageUrl: '');
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
                }
              },
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 48),
                  primary: Colors.white,
                  elevation: 3,
                  backgroundColor: Colors.deepOrangeAccent),
              child: Text("Tambah Progress"),
            ),
          ],
        ),
      ),
    );
  }
}
