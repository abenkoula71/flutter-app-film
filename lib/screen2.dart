import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'animation/bouncing_effects.dart';
import 'globale.dart';

class Screen2 extends StatefulWidget {
  final List data;
  final String hero;
  const Screen2({super.key, required this.data, required this.hero});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List actors = [];
  List dataExist = [];
  bool exist = false;
  bool block = false;
  @override
  void initState() {
    runpage();
    super.initState();
  }

  getDataLocal() async {
    String path = await getPaths();
    Hive.init(path);
    await Hive.openBox('myBox');

    var box = await Hive.openBox('myBox');
    try {
      dataExist = await box.get('moviesRegister');
    } catch (e) {
      await box.put('moviesRegister', []);
      dataExist = [];
    }
    for (var data in dataExist) {
      if (data["Title"] == widget.data[0]["Title"]) {
        setState(() {
          exist = true;
        });
      }
    }
  }

  runpage() async {
    actors = widget.data[0]["Actors"].split(',');
    for (var i = 0; i < actors.length; i++) {
      actors[i] = actors[i].toString().trim();
    }
    await getDataLocal();
  }

  Future<String> getPaths() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;

    setState(() {});
    return path;
  }

  Future addMoviesRegister(res) async {
    setState(() {
      block = true;
    });
    List data = [];
    String path = await getPaths();
    Hive.init(path);
    await Hive.openBox('myBox');

    var box = await Hive.openBox('myBox');
    data = await box.get('moviesRegister');

    data.add(res);
    await box.put('moviesRegister', data);

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      exist = true;
      block = false;
    });
  }

  showAlertDialogReporte(BuildContext context) {
    TextEditingController reporteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 40, 40, 40),
            title: const Center(
              child: Text(
                "REPORTE THIS MOVIE",
                style: TextStyle(letterSpacing: 1.4, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            content: TextFormField(
              controller: reporteController,
              decoration: const InputDecoration(
                
                labelText: "ADD YOUR REPORTS HERE ...",
                labelStyle: TextStyle(color: Color.fromARGB(255, 165, 42, 33)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 165, 42, 33),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 165, 42, 33),
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 165, 42, 33),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: DialogButton(
                        color: Colors.grey,
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Expanded(
                    child: DialogButton(
                      color: Color.fromARGB(255, 165, 42, 33),
                      child: const Text(
                        "SEND",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (reporteController.text.trim().isNotEmpty) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300.0,
                floating: true,
                pinned: true,
                snap: true,
                // actionsIconTheme: const IconThemeData(opacity: 0.0),
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: const Text("Preview",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Hero(
                    tag: widget.hero,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          widget.data[0]["Images"][index],
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: widget.data[0]["Images"].length,
                      autoplay: true,
                      // pagination:
                      //     const SwiperPagination(builder: SwiperPagination.dots),
                      // control: const SwiperControl(),
                    ),
                  ),

                  // Stack(
                  //   children: [
                  //     Positioned.fill(
                  //       child: Image.network(
                  //         "https://fr.web.img6.acsta.net/pictures/23/02/13/18/18/3312661.jpg",
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                leading: Bouncing(
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(130, 201, 201, 201),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: [
                  Bouncing(
                    onPress: () async {
                      await showAlertDialogReporte(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(130, 201, 201, 201),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([]),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              // c1,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.data[0]["Title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '${widget.data[0]["Metascore"]}% match',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${widget.data[0]["Year"]} ${widget.data[0]["Runtime"]} R HD',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xffe13c08),
                                child: Icon(
                                  Icons.thumb_up,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Most Liked',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Bouncing(
                          onPress: () async {
                            if (!exist) {
                              await addMoviesRegister(widget.data[0]);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            alignment: Alignment.center,
                            // margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xff545454),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: block
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                      strokeWidth: 1.5,
                                    ),
                                  )
                                : exist
                                    ? const Icon(Icons.check)
                                    : const Text(
                                        "REGISTER NOW",
                                        style: TextStyle(color: Colors.white),
                                      ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Prolog",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.data[0]["Plot"]}",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Awards",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.data[0]["Awards"]}",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Genre & Language",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.data[0]["Genre"]} -- ${widget.data[0]["Language"]}",
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Top Actors",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                ...List.generate(actors.length, (i) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 31,
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.red,
                                            child: Text(
                                              actors[i]
                                                  .toString()
                                                  .substring(0, 1),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          actors[i].length > 10
                                              ? "${actors[i].substring(0, 10)}.."
                                              : actors[i],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          widget.data[0]["Title"],
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'More Films',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    'See all',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(97, 255, 255, 255),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: movies.isEmpty
                              ? Container()
                              : Row(
                                  children: [
                                    ...List.generate(movies.length, (index) {
                                      if (movies[index]["Title"] ==
                                          widget.data[0]['Title']) {
                                        return Container();
                                      } else {
                                        return Bouncing(
                                          onPress: () async {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) => Screen2(
                                                data: [movies[index]],
                                                hero:
                                                    "${movies[index]["Title"]} $index ",
                                              ),
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 15),
                                            height: 210,
                                            width: 140,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    22, 244, 67, 54),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${movies[index]['Poster']}'),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color.fromARGB(
                                                        151, 255, 255, 255))),
                                            // child: Text('${movies[index]['posterUrl']}'),
                                          ),
                                        );
                                      }
                                    }),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  SizedBox c1 = SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://fr.web.img6.acsta.net/pictures/23/02/13/18/18/3312661.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(130, 201, 201, 201),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(130, 201, 201, 201),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const Text(
                  'Preview',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          )
        ],
      ));
}
