import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.pink, Colors.yellow])),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 4,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Todo",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 10,
                    ),
                    title("Task Title"),
                    SizedBox(
                      height: 20,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelector("Important", Colors.green),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelector(
                            "Planned", Color.fromARGB(255, 83, 76, 175)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 10,
                    ),
                    description("Description"),
                    SizedBox(
                      height: 20,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        descriptionSelector("Food", Colors.green),
                        SizedBox(
                          width: 20,
                        ),
                        descriptionSelector(
                            "WorkOut", Color.fromARGB(255, 83, 76, 175)),
                        SizedBox(
                          width: 20,
                        ),
                        descriptionSelector(
                            "Work", Color.fromARGB(255, 175, 76, 92)),
                        descriptionSelector(
                            "Desing", Color.fromARGB(255, 173, 175, 76)),
                        SizedBox(
                          width: 20,
                        ),
                        descriptionSelector(
                            "Run", Color.fromARGB(255, 76, 152, 175)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    button(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").add({
          "title": _taskController.text,
          "task_type": type,
          "description": _descriptionController.text,
          "category": category,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blueGrey, Colors.blue]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            "Add Todo",
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 3,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget description(String title) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
          controller: _descriptionController,
          maxLines: null,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Task Title",
              contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              hintStyle: TextStyle(fontSize: 18, color: Colors.white38))),
    );
  }

  Widget taskSelector(String chipname, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = chipname;
        });
      },
      child: Chip(
        labelStyle: TextStyle(
            fontSize: 15,
            color: type == chipname ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4),
        backgroundColor: type == chipname ? Colors.white : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(chipname),
        labelPadding: EdgeInsets.symmetric(vertical: 3.5, horizontal: 17),
      ),
    );
  }

  Widget descriptionSelector(String chipname, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = chipname;
        });
      },
      child: Chip(
        labelStyle: TextStyle(
            fontSize: 15,
            color: category == chipname
                ? Color.fromARGB(255, 0, 0, 0)
                : Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4),
        backgroundColor:
            category == chipname ? Color.fromARGB(255, 255, 255, 255) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(chipname),
        labelPadding: EdgeInsets.symmetric(vertical: 3.5, horizontal: 17),
      ),
    );
  }

  Widget title(String title) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
          controller: _taskController,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Task Title",
              contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              hintStyle: TextStyle(fontSize: 18, color: Colors.white38))),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          letterSpacing: 0.2,
          fontSize: 16.5,
          fontWeight: FontWeight.w600,
          color: Colors.white),
    );
  }
}
