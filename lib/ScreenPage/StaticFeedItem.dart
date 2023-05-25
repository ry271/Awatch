import 'package:flutter/material.dart';
import 'UserPost.dart';

class StaticFeedItem extends StatefulWidget {
  List<UserPost> userPostt;
  int idx;

  StaticFeedItem({Key? key, required this.userPostt, required this.idx})
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
                          flex: 2,
                          child: Text(
                            widget.userPostt.elementAt(widget.idx).name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        child: SizedBox(),
                        flex: 6,
                      ),
                      Expanded(
                        flex: 2,
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                // borderRadius: Radius.circular(20),
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                ),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chevron_right_rounded)),
                          )),
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
