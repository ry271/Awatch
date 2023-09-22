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
  int _status = 2;

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
      _status = value['status'];

      if (_status == 0) {
        _dropValue = "Belum";
      } else if (_status == 1) {
        _dropValue = "Selesai";
      }
      print(_dropValue);
    });
  }

  @override
  void initState() {
    getItem();
    print(_dropValue);
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
                    print(_status);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Status saat ini = $_dropValue"),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 80,
                          right: 20,
                          left: 20),
                    ));
                  },
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 48),
                      primary: Colors.white,
                      elevation: 3,
                      backgroundColor: Colors.deepOrangeAccent),
                  child: Text("Lihat Status"),
                ),
                SizedBox(
                  width: 20,
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
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropValue = newValue!;
                      if (_dropValue == "Belum") {
                        _status = 0;
                      } else if (_dropValue == "Selesai") {
                        _status = 1;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var response = await FirestoreSystem.deleteProgress(
                          docId: widget.docId, progId: widget.progId);
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
                  child: Text("Hapus Progress"),
                ),
                SizedBox(width: 20.0),
                TextButton(
                  onPressed: () async {
                    if (_progressName.text.isEmpty || _status.toInt() == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Nama Progress/Status masih kosong!"),
                      ));
                      print("kosong");
                    } else {
                      if (_formKey.currentState!.validate()) {
                        var response = await FirestoreSystem.updateProgress(
                            nama: _progressName.text,
                            status: _status!,
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
          ],
        ),
      ),
    );
  }
}
