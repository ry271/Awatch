import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Utilities/FirestoreSystem.dart';
import 'HomePage.dart';

class AddFeed extends StatefulWidget {
  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  final TextEditingController _namaProyek = TextEditingController();
  final TextEditingController _alamatProyek = TextEditingController();
  DateTime _tmProyek = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final namaProyekField = TextFormField(
      decoration: InputDecoration(
          hintText: "Nama Proyek", filled: true, fillColor: Colors.white),
      controller: _namaProyek,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
    );

    final alamatProyekField = TextFormField(
      decoration: InputDecoration(
          hintText: "Alamat", filled: true, fillColor: Colors.white),
      controller: _alamatProyek,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
    );
    final tmProyekField = Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_tmProyek == null
                  ? 'Nothing has been picked yet'
                  : DateFormat.yMMMMd().format(_tmProyek)),
            ],
          ),
          ElevatedButton(
            child: Text("Tanggal Mulai",
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
                // minimumSize: const Size.fromHeight(50),
                primary: Colors.white,
                onPrimary: Colors.deepOrangeAccent,
                elevation: 0,
                minimumSize: Size(100, 50)),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2099),
              ).then((date) {
                setState(() {
                  _tmProyek = date!;
                });
              });
            },
          )
        ],
      ),
    );

    final tambahProyekButton = Container(
      margin: EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () async {
          var response = await FirestoreSystem.addProyek(
              nama: _namaProyek.text,
              alamat: _alamatProyek.text,
              tm: DateFormat.yMMMEd().format(_tmProyek),
              status: 0);
          if (response != 200) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message.toString()),
            ));
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message.toString()),
            ));
          }
        },
        style: TextButton.styleFrom(
            fixedSize: const Size(150, 48),
            primary: Colors.white,
            backgroundColor: Colors.deepOrangeAccent),
        child: Text("Tambah Proyek"),
      ),
    );

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
                  namaProyekField,
                  const SizedBox(
                    height: 5,
                  ),
                  alamatProyekField,
                  const SizedBox(
                    height: 5,
                  ),
                  tmProyekField,
                  const SizedBox(
                    height: 10,
                  ),
                  tambahProyekButton
                ],
              ))),
    );
  }
}
