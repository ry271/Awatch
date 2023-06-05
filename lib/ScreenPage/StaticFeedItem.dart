import 'package:flutter/material.dart';
import 'UserPost.dart';

class StaticFeedItem extends StatefulWidget {
  String nama;

  StaticFeedItem({Key? key, required this.nama})
      : super(key: key);

  @override
  State<StaticFeedItem> createState() => _StaticFeedItemState();
}

class _StaticFeedItemState extends State<StaticFeedItem> {
  int _counter = 0;

  void counter() {
    setState(() {
      _counter++;
    });
  }

  Widget buttons = Container(
      padding: EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.thumb_up,
            size: 20,
          ),
          Icon(
            Icons.comment,
            size: 20,
          ),
          Icon(
            Icons.share,
            size: 20,
          ),
        ],
      ));

  Widget divider = const Divider(
    thickness: 1.05,
    height: 1,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
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
