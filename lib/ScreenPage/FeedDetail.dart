import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UserPost.dart';

class FeedDetail extends StatefulWidget {
  List<UserPost> userPost;
  int idx;

  FeedDetail({Key? key, required this.userPost, required this.idx})
      : super(key: key);

  @override
  State<FeedDetail> createState() => _FeedDetailState();
}

class _FeedDetailState extends State<FeedDetail> {
  Widget buttons = Container(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.thumb_up,
            size: 21,
          ),
          Icon(
            Icons.comment,
            size: 21,
          ),
          Icon(
            Icons.share,
            size: 21,
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              widget.userPost.elementAt(widget.idx).name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.all(13),
                    width: double.infinity,
                    constraints:
                        const BoxConstraints(maxHeight: double.infinity),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Image
                            Container(
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.userPost
                                        .elementAt(widget.idx)
                                        .img),
                                    fit: BoxFit.cover,
                                  )),
                              height: 55,
                              width: 55,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //username id
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            widget.userPost
                                                .elementAt(widget.idx)
                                                .name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      "@" +
                                          widget.userPost
                                              .elementAt(widget.idx)
                                              .username,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 21),
                          child: Text(
                            widget.userPost.elementAt(widget.idx).post,
                            softWrap: true,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    )),
                Divider(
                  height: 1,
                ),
                buttons,
                Divider(
                  height: 1,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back"))
              ],
            ),
          )),
    );
  }
}
