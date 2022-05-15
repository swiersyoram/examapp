import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamEntry extends StatefulWidget {
  ExamEntry(this.exam, {Key? key}) : super(key: key);
  final exam;

  @override
  State<ExamEntry> createState() => _ExamEntryState();
}

class _ExamEntryState extends State<ExamEntry> {
  // MapController mapController = MapController();
  CollectionReference entries =
      FirebaseFirestore.instance.collection("exam_entries");
  var exam;
  @override
  void initState() {
    // TODO: implement initState
    exam = widget.exam.data();
    if (!exam["exam"]["questions"].first.containsKey("credit")) {
      for (var question in exam["exam"]["questions"]) {
        question["credit"] = "0";
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.exam.id.toString());
    // log(widget.exam.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Exam from ${widget.exam["user"]["firstname"]} ${widget.exam["user"]["lastname"]}",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Date: ${DateTime.parse(widget.exam["starttime"].toDate().toString())}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700]),
            ),
            Text(
              "Student: ${widget.exam["user"]["firstname"]} ${widget.exam["user"]["lastname"]}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700]),
            ),
            Text(
              "Exam: ${widget.exam["exam"]["name"]}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700]),
            ),
            Text(
              "Location: lon: ${widget.exam["location"]["longitude"]} lat: ${widget.exam["location"]["latitude"]}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700]),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Questions',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.exam["exam"]["questions"].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 3)),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Question ${index + 1}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "${exam["exam"]["questions"][index]["credit"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "/${widget.exam["exam"]["questions"][index]["max_credit"]}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  "Question:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(widget.exam["exam"]["questions"][index]
                                    ["question"]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Answer:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(widget.exam["exam"]["questions"][index]
                                    ["answer"]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Answer Student:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(widget.exam["exam"]["questions"][index]
                                    ["user_answer"]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Score:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: exam["exam"]["questions"][index]
                                          ["credit"]
                                      .toString(),
                                  onChanged: (text) {
                                    setState(() {
                                      exam["exam"]["questions"][index]
                                          ["credit"] = text;
                                    });
                                  },
                                )
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // Text(
                                //   "Max credit:",
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 16),
                                // ),
                                // TextFormField(
                                //   keyboardType: TextInputType.number,
                                //   initialValue: questions[index]["max_credit"],
                                //   onChanged: (text) {
                                //     setState(() {
                                //       questions[index]["max_credit"] = text;
                                //     });
                                //   },
                                // )
                              ],
                            ),
                          ],
                        ),
                      );
                    })),
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
                      entries
                          .doc(widget.exam.id)
                          .update(exam)
                          .then((value) => Navigator.pop(context));
                    },
                    child: Text("save"))
              ],
            )
          ]),
        ),
      ),
    );
    ;
  }
}
