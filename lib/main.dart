import 'package:flutter/material.dart';
import 'package:task/ImageInSqliteDB.dart';

void main() {
  runApp(MaterialApp(
    home: Homepage(),
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    title: "New Task App",
    theme: ThemeData.dark(useMaterial3: true),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List Task = [
    "Store and Fatch Images From Sqlite DataBase",
    "Empty Task 2",
    "Empty Task 3"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
          title: Center(
            child: Text(
              "IMP TASK`s             ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Card(
          child: ListView.builder(
            itemCount: Task.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    if (index == 0) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ImageInSqliteDB();
                        },
                      ));
                    }
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("View Source Code"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("NO")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("YES")),
                          ],
                        );
                      },
                    );
                  },
                  style: ListTileStyle.list,
                  horizontalTitleGap: 20,
                  tileColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minLeadingWidth: 10,
                  contentPadding: EdgeInsets.all(20),
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("Photos/img$index.png")),
                  title: Text("${Task[index]}"),
                  subtitle:
                      Text("$index", style: TextStyle(color: Colors.white10)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
// Ridhhi 9693 9099865125 Ghanshyambhai
