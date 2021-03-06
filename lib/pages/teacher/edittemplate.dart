import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  bool switchValue = false;
  @override
  void initState() {
    super.initState();
    if (widget.template != null) {
      namecontroller.text = widget.template["name"];
      if (widget.template["questions"] != null) {
        questions = widget.template["questions"];
      }
      switchValue = widget.template["active"];
    }
  }

  List questions = [];
  @override
  Widget build(BuildContext context) {
    // log(widget.template.data().toString());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 600,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Exam Template",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Questions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      setState(() {
                        questions.add(
                            {"question": "", "answer": "", "max_credit": null});
                        // log(questions.toString());
                      });
                    },
                    child: const Text("add question"))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            questions.isNotEmpty
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
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Question ${index + 1}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                questions.removeAt(index);
                                              });
                                            },
                                            child: const FaIcon(
                                              FontAwesomeIcons.trashCan,
                                            )),
                                      ],
                                    ),
                                    const Text(
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
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
                : const Text("There are no questions yet, add a question"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel")),
                const SizedBox(
                  width: 80,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      if (widget.template != null) {
                        templates.doc(widget.template.id).update({
                          'name': namecontroller.text,
                          'questions': questions,
                          'active': switchValue
                        }).then((value) => Navigator.pop(context));
                      } else {
                        // log(questions.toString());
                        templates.add({
                          'name': namecontroller.text,
                          'questions': questions,
                          'active': switchValue
                        }).then((value) => Navigator.pop(context));
                      }
                    },
                    child: const Text("save"))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
