import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_tpa/models/ung_video_model.dart';
import 'package:ung_tpa/screens/play_video.dart';

class ShowListVideo extends StatefulWidget {
  @override
  _ShowListVideoState createState() => _ShowListVideoState();
}

class _ShowListVideoState extends State<ShowListVideo> {
  // Explicit
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<UngVideoModel> ungVideoModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('UngVideo');
    subscription = await collectionReference.snapshots().listen((response) {
      snapshots = response.documents;

      for (var snapshot in snapshots) {
        String nameVideo = snapshot.data['Name'];
        String detailVideo = snapshot.data['Detail'];
        String pathImage = snapshot.data['PathImage'];
        String pathVideo = snapshot.data['PathVideo'];

        UngVideoModel ungVideoModel =
            UngVideoModel(nameVideo, detailVideo, pathImage, pathVideo);
        setState(() {
          ungVideoModels.add(ungVideoModel);
        });

        // print('$pathVideo');
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: 180.0,
      height: 120.0,
      child: Image.network(
        ungVideoModels[index].pathImage,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              ungVideoModels[index].name,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.orange[900],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(ungVideoModels[index].detail),
          )
        ],
      ),
    );
  }

  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.grey[600],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: ListView.builder(
        itemCount: ungVideoModels.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      showImage(index),
                      showText(index),
                    ],
                  ),
                  myDivider(),
                ],
              ),
            ),
            onTap: () {

              print('index = $index');

              var playRoute = MaterialPageRoute(
                  builder: (BuildContext context) => PlayVideo(ungVideoModel: ungVideoModels[index],));
                  Navigator.of(context).push(playRoute);
            },
          );
        },
      ),
    );
  }
}
