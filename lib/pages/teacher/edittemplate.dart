import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditTemplate extends StatefulWidget {
  const EditTemplate([this.template]);

  final template;

  @override
  State<EditTemplate> createState() => _EditTemplateState();
}

class _EditTemplateState extends State<EditTemplate> {
  final TextEditingController namecontroller = TextEditingController();
  CollectionReference templates =
      FirebaseFirestore.instance.collection("exam_templates");
  @override
  void initState() {
    super.initState();
    if (widget.template != null) {
      namecontroller.text = widget.template["name"];
      if (widget.template["questions"] != null)
        questions = widget.template["questions"];
    }
  }

  List questions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 600,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Exam Template",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter a name for the exam",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Questions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      setState(() {
                        questions.add(
                            {"question": "", "answer": "", "max_credit": null});
                        // log(questions.toString());
                      });
                    },
                    child: Text("add question"))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            questions.length > 0
                ? Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 3)),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Question ${index + 1}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                questions.removeAt(index);
                                              });
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.trashCan,
                                            )),
                                      ],
                                    ),
                                    Text(
                                      "Question:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    TextFormField(
                                      initialValue: questions[index]
                                          ["question"],
                                      onChanged: (text) {
                                        setState(() {
                                          questions[index]["question"] = text;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Answer:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    TextFormField(
                                      initialValue: questions[index]["answer"],
                                      onChanged: (text) {
                                        setState(() {
                                          questions[index]["answer"] = text;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Max credit:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: questions[index]
                                          ["max_credit"],
                                      onChanged: (text) {
                                        setState(() {
                                          questions[index]["max_credit"] = text;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }))
                : Text("There are no questions yet, add a question"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel")),
                SizedBox(
                  width: 80,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      if (widget.template != null) {
                        templates.doc(widget.template.id).update({
                          'name': namecontroller.text,
                          'questions': questions
                        }).then((value) => Navigator.pop(context));
                      } else {
                        // log(questions.toString());
                        templates.add({
                          'name': namecontroller.text,
                          'questions': questions
                        }).then((value) => Navigator.pop(context));
                      }
                    },
                    child: Text("save"))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
