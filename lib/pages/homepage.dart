import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutorial/Services/auth_service.dart';
import 'package:tutorial/pages/add_todo_page.dart';
import 'package:tutorial/pages/signup_page.dart';
import 'package:tutorial/pages/todocard_page.dart';
import 'package:tutorial/pages/viewdata.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthCalss authCalss = AuthCalss();
  var date = DateTime.now();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> select = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 230, 112, 151),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
          ])),
        ),
        title: Text(
          "Today's Shedule",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await authCalss.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                  (route) => false);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              radius: 25,
            ),
          ),
          SizedBox(
            width: 25,
          )
        ],
        bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  DateFormat('EEEE, d MMM').format(date).toString(),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        focusColor: Colors.red,
        hoverColor: Colors.red,
        backgroundColor: Colors.red,
        foregroundColor: Color.fromARGB(255, 7, 52, 255),
        splashColor: Color.fromARGB(255, 76, 244, 54),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddTodoPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(color: Colors.transparent),
      //   child: BottomNavigationBar(
      //       backgroundColor: Colors.transparent,
      //       elevation: 0,
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.home,
      //               size: 32,
      //               color: Colors.white,
      //             ),
      //             label: ""),
      //         BottomNavigationBarItem(
      //             icon: InkWell(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (builder) => AddTodoPage()));
      //               },
      //               child: Container(
      //                 height: 52,
      //                 width: 53,
      //                 decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     gradient: LinearGradient(colors: [
      //                       Color.fromARGB(255, 45, 73, 235),
      //                       Color.fromARGB(255, 255, 44, 7)
      //                     ])),
      //                 child: Icon(
      //                   Icons.add,
      //                   size: 32,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //             label: ""),
      //         BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.settings,
      //               size: 32,
      //               color: Colors.white,
      //             ),
      //             label: ""),
      //       ]),

      body: StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      (snapshot.data! as QuerySnapshot).docs[index].data()
                          as Map<String, dynamic>;
                  switch (document["category"]) {
                    case "Food":
                      iconData = (Icons.local_grocery_store);
                      iconColor = Color.fromARGB(255, 60, 244, 54);
                      break;
                    case "WorkOut":
                      iconData = (Icons.run_circle_rounded);
                      iconColor = Colors.red;
                      break;
                    case "Work":
                      iconData = (Icons.alarm);
                      iconColor = Color.fromARGB(255, 244, 54, 101);
                      break;
                    case "Desing":
                      iconData = (Icons.pin);
                      iconColor = Color.fromARGB(255, 73, 54, 244);
                      break;
                    default:
                      iconData = (Icons.run_circle);
                      iconColor = Color.fromARGB(255, 56, 46, 196);
                  }
                  select.add(Select(
                      id: (snapshot.data! as QuerySnapshot).docs[index].id,
                      checkValue: false));
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPageData(
                                    document: document,
                                    id: (snapshot.data! as QuerySnapshot)
                                        .docs[index]
                                        .id,
                                  )));
                    },
                    child: TodoCardPage(
                        title: document["title"] == null
                            ? "Hey There"
                            : document["title"],
                        iconData: iconData,
                        iconColor: iconColor,
                        time: "10 Am",
                        index: index,
                        onChange: onChange,
                        value: select[index].checkValue,
                        iconBgColor: Colors.white),
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      select[index].checkValue = !select[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue;
  Select({required this.id, required this.checkValue});
}

class ListCards extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 114, 146, 208)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.1000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.0536000, size.height * 0.4913333,
        size.width * 0.1000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.1375000, size.height * 0.2000000,
        size.width * 0.1500000, size.height * 0.2000000);
    path0.quadraticBezierTo(size.width * 0.1625000, size.height * 0.2000000,
        size.width * 0.2000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.2375000, size.height * 0.2040000,
        size.width * 0.2500000, size.height * 0.2053333);
    path0.quadraticBezierTo(size.width * 0.2625000, size.height * 0.2040000,
        size.width * 0.3000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.3359000, size.height * 0.2053333,
        size.width * 0.3484000, size.height * 0.2053333);
    path0.quadraticBezierTo(size.width * 0.3609000, size.height * 0.2053333,
        size.width * 0.4000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.4375000, size.height * 0.2053333,
        size.width * 0.4500000, size.height * 0.2053333);
    path0.quadraticBezierTo(size.width * 0.4625000, size.height * 0.2053333,
        size.width * 0.5000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.5375000, size.height * 0.2053333,
        size.width * 0.5500000, size.height * 0.2053333);
    path0.quadraticBezierTo(size.width * 0.5625000, size.height * 0.2053333,
        size.width * 0.6000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.6375000, size.height * 0.2000000,
        size.width * 0.6500000, size.height * 0.2000000);
    path0.quadraticBezierTo(size.width * 0.6625000, size.height * 0.2000000,
        size.width * 0.7000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.7375000, size.height * 0.2000000,
        size.width * 0.7500000, size.height * 0.2000000);
    path0.quadraticBezierTo(size.width * 0.7625000, size.height * 0.2000000,
        size.width * 0.8000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.8375000, size.height * 0.2000000,
        size.width * 0.8500000, size.height * 0.2000000);
    path0.quadraticBezierTo(size.width * 0.8625000, size.height * 0.2000000,
        size.width * 0.9000000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.9464000, size.height * 0.5033333,
        size.width * 0.9000000, size.height * 0.6666667);
    path0.cubicTo(
        size.width * 0.8879000,
        size.height * 0.7000000,
        size.width * 0.8641000,
        size.height * 0.8000000,
        size.width * 0.8516000,
        size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.8391000, size.height * 0.8000000,
        size.width * 0.8000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.7625000, size.height * 0.8000000,
        size.width * 0.7500000, size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.7375000, size.height * 0.8000000,
        size.width * 0.7000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.6625000, size.height * 0.8053333,
        size.width * 0.6500000, size.height * 0.8053333);
    path0.quadraticBezierTo(size.width * 0.6375000, size.height * 0.8053333,
        size.width * 0.6000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.5625000, size.height * 0.8000000,
        size.width * 0.5500000, size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.5375000, size.height * 0.7983333,
        size.width * 0.5000000, size.height * 0.6600000);
    path0.quadraticBezierTo(size.width * 0.4625000, size.height * 0.7983333,
        size.width * 0.4500000, size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.4375000, size.height * 0.8000000,
        size.width * 0.4000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.3641000, size.height * 0.8000000,
        size.width * 0.3516000, size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.3391000, size.height * 0.8000000,
        size.width * 0.3000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.2625000, size.height * 0.8000000,
        size.width * 0.2500000, size.height * 0.8000000);
    path0.quadraticBezierTo(size.width * 0.2375000, size.height * 0.8000000,
        size.width * 0.2000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.1641000, size.height * 0.8053333,
        size.width * 0.1516000, size.height * 0.8053333);
    path0.cubicTo(
        size.width * 0.1391000,
        size.height * 0.8053333,
        size.width * 0.1387000,
        size.height * 0.7706667,
        size.width * 0.1000000,
        size.height * 0.6666667);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


//  IconButton(
//               onPressed: () async {
//                 await authCalss.logout();
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUp()),
//                     (route) => false);
//               },
//               icon: Icon(Icons.logout_sharp))
