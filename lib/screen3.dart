import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as provider;
import 'package:rflutter_alert/rflutter_alert.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List moviesRegister = [];
  Future<String> getPaths() async {
    Directory appDocDir = await provider.getApplicationDocumentsDirectory();
    String path = appDocDir.path;

    setState(() {});
    return path;
  }

  Future getMoviesRegister() async {
    String path = await getPaths();
    Hive.init(path);
    await Hive.openBox('myBox');
    var box = await Hive.openBox('myBox');
    moviesRegister = await box.get('moviesRegister') ?? [];
  }

  @override
  void initState() {
    try {
      getMoviesRegister();
    } catch (e) {}
    super.initState();
  }

  showAlertDialogDelete(BuildContext context, String name, int index) {
    Future delete() async {
      String path = await getPaths();
      Hive.init(path);
      await Hive.openBox('myBox');
      var box = await Hive.openBox('myBox');
      moviesRegister.removeAt(index);
      await box.put("moviesRegister", moviesRegister);
      moviesRegister = await box.get("moviesRegister");
      setState(() {});

      Future.delayed(Duration.zero).then((value) {
        Navigator.of(context).pop();
      });
    }

    showDialog(
      context: context,
      barrierColor: Color.fromARGB(64, 0, 0, 0),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 40, 40, 40),
            title: Center(
              child: Text(
                "Delete Movie $name",
                style: const TextStyle(letterSpacing: 1.4, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: DialogButton(
                          color: Colors.grey,
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Expanded(
                      child: DialogButton(
                          color: Colors.red,
                          child: const Text(
                            "DELETE",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () async {
                            await delete().then((value) => setState(() {}));
                          }),
                    ),
                  ],
                ),
              )
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Movies Pre-register"),
        centerTitle: true,
      ),
      body: moviesRegister.isEmpty
          ? const Center(
              child: Text(
              "NO MOVIE REGISTER YET !",
              style: TextStyle(color: Colors.white),
            ))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ...List.generate(
                      moviesRegister.length,
                      (index) => GestureDetector(
                            onTap: () async {
                              await showAlertDialogDelete(
                                context,
                                moviesRegister[index]["Title"],
                                index,
                              );
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 212, 52, 41),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 174, 174, 174)
                                        .withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo[200],
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              moviesRegister[index]["Poster"],
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              moviesRegister[index]["Title"],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(
                                              "Runtime : ${moviesRegister[index]["Runtime"]}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Genre : ${moviesRegister[index]["Genre"]}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Language : ${moviesRegister[index]["Language"]}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Metascore : ${moviesRegister[index]["Metascore"]}%",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Type : ${moviesRegister[index]["Type"]}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ],
              ),
            ),
    );
  }
}
