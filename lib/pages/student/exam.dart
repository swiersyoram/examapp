import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/homepage.dart';
import 'package:examapp/pages/student/succes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'check.dart';

class Exam extends StatefulWidget {
  final template;
  final user;
  Position location;
  Exam(this.template, this.user, this.location, {Key? key}) : super(key: key);

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  CollectionReference examentries =
      FirebaseFirestore.instance.collection("exam_entries");
  DateTime time = new DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    template = widget.template.data();
    for (var question in template['questions']) {
      question["user_answer"] = "";
    }
    super.initState();
  }

  var template;
  @override
  Widget build(BuildContext context) {
    // log(template.toString());
    log(time.toIso8601String());
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 600,
          child: ListView(children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Hey ${widget.user.data()["firstname"]},",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Probeer het examen naar best vermogen op te lossen. Succes!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              template["name"],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
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
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.template.data()['questions'].length,
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
                                Text(
                                  "/${template["questions"][index]["max_credit"]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Question:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(widget.template.data()["questions"][index]
                                ["question"]),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Answer:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            TextFormField(
                              onChanged: (text) {
                                setState(() {
                                  template["questions"][index]['user_answer'] =
                                      text;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  final exam = {
                    "location": {
                      "longitude": widget.location.longitude,
                      "latitude": widget.location.latitude
                    },
                    "user": widget.user.data(),
                    "exam": template,
                    "starttime": time
                  };
                  examentries.add(exam);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Success()),
                    (route) => false,
                  );
                },
                child: Text("Examen indienen "))
          ]),
        ),
      ),
    );
  }
}
