import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressItem extends StatefulWidget {
  String nama;

  ProgressItem({Key? key, required this.nama}) : super(key: key);

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(13),
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child: Text(
                            widget.nama,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        child: SizedBox(),
                        flex: 2,
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              // borderRadius: Radius.circular(20),
                              border:
                              Border.all(width: 1, color: Colors.black),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.chevron_right_rounded)
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // divider
          ],
        ));
  }
}