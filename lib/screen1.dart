import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gp/screen2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'animation/bouncing_effects.dart';
import 'globale.dart';
import 'screen3.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List types = [];
  List typ = ['Trending Now', 'Series', 'Movie'];

  @override
  void initState() {
    runpage();
    super.initState();
  }

  runpage() async {
    List list0 = [], list1 = [], list2 = [];
    list0 = movies;
    for (var i = 0; i < movies.length; i++) {
      if (movies[i]['Type'] == 'series') {
        list1.add(movies[i]);
      }
      if (movies[i]['Type'] != 'series') {
        list2.add(movies[i]);
      }
    }
    types.add(list0);
    types.add(list1);
    types.add(list2);

    debugPrint("$types");
  }

  showAlertDialogInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 40, 40, 40),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.groups_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "TM71",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                "GROUP DEV FSEI-MOSTAGANEM",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 48,
                backgroundColor: Colors.red,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("images/logo.jpg"),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sponsored :",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Bouncing(
                onPress: () async {
                  final Uri url = Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.gamesroomtm071.games_room_v&pli=1");

                  try {
                    await launchUrl(url);
                  } catch (e) {
                    debugPrint('Could not launch $url $e');
                  }
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 176, 36, 26),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 7,
                        ),
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                "https://play-lh.googleusercontent.com/piYdp9ZlYNB0mSmEGb06s3_LI8Bv_MfiIGNQq9DvCJSTsFwG0tkSBPW_MRqLhP5Lcw=w240-h480-rw",
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "GAME ROOM",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "in play store",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: DialogButton(
                        color: Color.fromARGB(199, 158, 158, 158),
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        }),
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
      body: types.isEmpty
          ? Container()
          : Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      c3,
                      ...List.generate(
                          typ.length,
                          (index) => Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              typ[index],
                                              style: const TextStyle(
                                                  fontSize: 27,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const Text(
                                              'See all',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      97, 255, 255, 255),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  c2(types[index], index),
                                ],
                              ))
                    ],
                  ),
                ),
                c1(context),
              ],
            ),
    );
  }

  Widget c1(context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            // will be 10 by default if not provided
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            // color: Colors.blue, //test
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Bouncing(
                  onPress: () async {
                    await showAlertDialogInfo(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        color: Colors.red,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80')),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                const Spacer(),
                const Text(
                  "MOVIZO",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Screen3(),
                    ));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(130, 201, 201, 201),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox c3 = SizedBox(
      height: 500,
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () async {},
                //       child: Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         width: 92,
                //         height: 30,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20),
                //             color: const Color.fromARGB(172, 109, 109, 109)),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: const [
                //             Icon(
                //               Icons.movie_creation_outlined,
                //               color: Colors.white,
                //             ),
                //             Text(
                //               ' Now',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       width: 90,
                //       height: 30,
                //       decoration: BoxDecoration(
                //           border: Border.all(width: 2, color: Colors.white),
                //           borderRadius: BorderRadius.circular(20),
                //           color: const Color.fromARGB(0, 109, 109, 109)),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: const [
                //           Text(
                //             'Details',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold),
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // ),

                Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(113, 158, 158, 158)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.timer_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Coming Soon',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ));

  c2(film, int i) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: film.isEmpty
          ? Container()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ...List.generate(
                      film.length,
                      (index) => Bouncing(
                            onPress: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Screen2(
                                  data: [film[index]],
                                  hero:
                                      "${film[index]["Title"]} $index ${typ[i]}",
                                ),
                              ));
                            },
                            child: Hero(
                              tag: "${film[index]["Title"]} $index ${typ[i]}",
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                height: 210,
                                width: 140,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(22, 244, 67, 54),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${film[index]['Poster']}'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            151, 255, 255, 255))),
                                // child: Text('${movies[index]['posterUrl']}'),
                              ),
                            ),
                          ))
                ],
              ),
            ),
    );
  }
}
