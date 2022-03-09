import 'package:flutter/material.dart';

class TodoCardPage extends StatelessWidget {
  const TodoCardPage({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.value,
    required this.iconBgColor,
    required this.onChange,
    required this.index,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool value;
  final Color iconBgColor;
  final Function onChange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255)
      ])),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              primaryColor: Colors.blue,
              unselectedWidgetColor: Color.fromARGB(255, 171, 91, 236),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: value,
                activeColor: Color.fromARGB(255, 132, 218, 175),
                checkColor: Color.fromARGB(255, 23, 80, 48),
                onChanged: (bool? value) {
                  onChange(index);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: 65,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 33,
                    width: 36,
                    decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      iconData,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}


// class TodoCardPage extends StatefulWidget {
//   const TodoCardPage({
//     Key? key,
//     required this.title,
//     required this.iconData,
//     required this.iconColor,
//     required this.time,
//     required this.value,
//     required this.iconBgColor,
//     required this.onChange,
//     required this.index,
//   }) : super(key: key);

//   final String title;
//   final IconData iconData;
//   final Color iconColor;
//   final String time;
//   final bool value;
//   final Color iconBgColor;
//   final Function onChange;
//   final int index;

//   @override
//   State<TodoCardPage> createState() => _TodoCardPageState();
// }

// class _TodoCardPageState extends State<TodoCardPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [Colors.pink, Colors.yellow])),
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           Theme(
//             data: ThemeData(
//               primaryColor: Colors.blue,
//               unselectedWidgetColor: Colors.white,
//             ),
//             child: Transform.scale(
//               scale: 1.5,
//               child: Checkbox(
//                 value: widget.value,
//                 activeColor: Color.fromARGB(255, 132, 218, 175),
//                 checkColor: Color.fromARGB(255, 23, 80, 48),
//                 onChanged: (bool? value) {
//                   ;
//                 },
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5)),
//               ),
//             ),
//           ),
//           Expanded(
//               child: Container(
//             height: 65,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               color: Colors.transparent,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Container(
//                     height: 33,
//                     width: 36,
//                     decoration: BoxDecoration(
//                         color: widget.iconBgColor,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Icon(
//                       widget.iconData,
//                       color: widget.iconColor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: Text(
//                       widget.title,
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                           color: Colors.white),
//                     ),
//                   ),
//                   Text(
//                     widget.time,
//                     style: TextStyle(color: Colors.white, fontSize: 15),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                 ],
//               ),
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }
