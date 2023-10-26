import 'package:awatch/ScreenPage/HomePage.dart';
import 'package:flutter/material.dart';

import '../Utilities/FirestoreSystem.dart';

class ProfilePage extends StatefulWidget {
  final String UID;
  final String nama;
  final String jabatan;
  final String telepon;

  ProfilePage(
      {Key? key,
        required this.UID,
        required this.nama,
        required this.jabatan,
        required this.telepon,})
      : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _jabatan = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _nama = TextEditingController();

  @override
  void initState() {
    _nama.text = widget.nama;
    _jabatan.text = widget.jabatan;
    _telepon.text = widget.telepon;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final nameField = TextFormField(
      decoration: InputDecoration(
          hintText: "Nama", filled: true, fillColor: Colors.white),
      controller: _nama,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
    );

    final jabatanField = TextFormField(
      decoration: InputDecoration(
          hintText: "Jabatan Anda",
          filled: true,
          fillColor: Colors.white),
      controller: _jabatan,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
    );
    final teleponField = TextFormField(
      decoration: InputDecoration(
          hintText: "Nomor Telepon Anda",
          filled: true,
          fillColor: Colors.white),
      controller: _telepon,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
    );

    final updateProfileButton = Container(
      margin: EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed: () async {
          var response = await FirestoreSystem.updateProfile(
              nama: _nama.text,
              jabatan: _jabatan.text,
              telepon: _telepon.text,
              UID: widget.UID);
          if (response != 200) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message.toString()),
            ));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message.toString()),
            ));
          }
        },
        style: TextButton.styleFrom(
            fixedSize: Size(150, 48),
            primary: Colors.white,
            backgroundColor: Colors.deepOrangeAccent),
        child: Text("Update Profile"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          "Profile",
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
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                nameField,
                const SizedBox(
                  height: 5,
                ),
                jabatanField,
                const SizedBox(
                  height: 5,
                ),
                teleponField,
                const SizedBox(
                  height: 10,
                ),
                updateProfileButton
              ],
            ))),
      ),
    );
  }
}
