import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/ImageInSqliteDB.dart';
import 'package:task/ImageInSqliteDBdb.dart';
import 'package:task/main.dart';

class ImageInSqliteDBaddImages extends StatefulWidget {
  const ImageInSqliteDBaddImages({Key? key}) : super(key: key);

  @override
  State<ImageInSqliteDBaddImages> createState() =>
      _ImageInSqliteDBaddImagesState();
}

class _ImageInSqliteDBaddImagesState extends State<ImageInSqliteDBaddImages> {
  final picker = ImagePicker();
  List<int> ll = [];
  String? FileImagePath;
  Database? db;
  String xr = "sds";

  void getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        /*String*/ FileImagePath = pickedFile.path;
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA$FileImagePath");
      });
    } else {
      print("ASASASSAASASASASSASASASASASASASASASASASASAS");
    }
  }

  void getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        /*String*/ FileImagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    forDataBase();
  }

  forDataBase() {
    ImageInSqliteDBdb().GetDB().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Homepage();
                  },
                ));
              },
              child: Icon(Icons.home)),
          title: Text(
            "       ADD IMAGES TO DATABASE",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(children: [
          Expanded(
            flex: 7,
            child: FileImagePath == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Center(child: Text("PLEASE SELECT IMAGE :)")),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    // child: Image.file(File(FileImagePath!)),
                    child: Image.file(File(FileImagePath!)),
                  ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                margin: EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Row(children: [
                  Icon(Icons.camera_alt),
                  TextButton(
                      onPressed: () {
                        getImageFromCamera();
                      },
                      child: Text("Select From Camera")),
                  SizedBox(
                    width: 50,
                  ),
                  Icon(Icons.photo),
                  TextButton(
                      onPressed: () {
                        getImageFromGallery();
                      },
                      child: Text("Select From Gallery")),
                ])),
          ),
          Expanded(
            flex: 3,
            // child: ElevatedButton(
            //     onPressed: () {},
            //     child: Text("SAVE TO DB"),
            //     style: ButtonStyle(
            //         backgroundColor:
            //             MaterialStatePropertyAll(Colors.transparent))),
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 0, 50, 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black12,
              ),
              child: ElevatedButton(
                  onPressed: () {
                    if (FileImagePath != null) {
                      ImageInSqliteDBdb()
                          .AddImage(FileImagePath, db!)
                          .then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return ImageInSqliteDB();
                          },
                        ));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Image Not Selected :('),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                  child: Text("SAVE TO DB"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent))),
            ),
          ),
          // Text("$FileImagePath")
          // Expanded(
          //   child: Container(
          //     margin: EdgeInsets.all(10),
          //     color: Colors.green,
          //     child: Image.file(File(xr)),
          //   ),
          // )
        ]),
      ),
    );
  }
}
