import 'package:awatch/Utilities/FirestoreSystem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProgress extends StatefulWidget {
  String docId;
  String progId;

  EditProgress({Key? key, required this.docId, required this.progId})
      : super(key: key);

  @override
  State<EditProgress> createState() => _EditProgressState();
}

class _EditProgressState extends State<EditProgress> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _progressName = TextEditingController();
  String? _dropValue;

  @override
  void dispose() {
    _progressName.dispose();
    super.dispose();
  }

  Future<void> getItem() async {
    var document = await FirebaseFirestore.instance
        .collection('proyek')
        .doc(widget.docId)
        .collection('progress')
        .doc(widget.progId);
    document.get().then((value) {
      print(value["nama"]);
      _progressName.text = value['nama'];
      _dropValue = value['status'];
      print(_dropValue);
    });
  }

  @override
  void initState() {
    getItem();
    super.initState();
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
              'Update progress',
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
            Row(
              children: [
                Text("Status : "),
                TextButton(
                  onPressed: () {
                    print(_dropValue);
                  },
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 48),
                      primary: Colors.white,
                      elevation: 3,
                      backgroundColor: Colors.deepOrangeAccent),
                  child: Text("Update Progress"),
                ),
                DropdownButton(
                  value: _dropValue,
                  items: <String>['Belum', 'Selesai']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var response = await FirestoreSystem.updateProgress(
                      nama: _progressName.text,
                      status: _dropValue!,
                      docId: widget.docId,
                      progId: widget.progId);
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
              child: Text("Update Progress"),
            ),
          ],
        ),
      ),
    );
  }
}
