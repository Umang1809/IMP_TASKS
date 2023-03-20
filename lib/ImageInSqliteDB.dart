import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/ImageInSqliteDBaddImages.dart';
import 'package:task/ImageInSqliteDBdb.dart';
import 'package:task/main.dart';

class ImageInSqliteDB extends StatefulWidget {
  const ImageInSqliteDB({Key? key}) : super(key: key);

  @override
  State<ImageInSqliteDB> createState() => _ImageInSqliteDBState();
}

class _ImageInSqliteDBState extends State<ImageInSqliteDB> {
  Database? db;
  List<Map> Images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forDataBase();
  }

  forDataBase() {
    ImageInSqliteDBdb().GetDB().then((value) {
      db = value;
      ImageInSqliteDBdb().GetImage(db!).then((value) {
        setState(() {
          Images = value;
        });
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$value");
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
                "IMAGE FROM SQLITE DATABASE",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return ImageInSqliteDBaddImages();
                  },
                ));
              },
              child: Icon(Icons.add),
            ),
            body: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Images.length,
                itemBuilder: (context, index) {
                  Map images = Images[index];

                  return Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.white10,
                    child: Image.file(File("${images['PATH']}")),
                  );
                },
              ),
            )));
  }
}
