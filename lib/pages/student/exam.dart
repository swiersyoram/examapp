import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/student/succes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
  DateTime time = DateTime.now();
  @override
  void initState() {
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
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hey ${widget.user.data()["firstname"]},",
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Probeer het examen naar best vermogen op te lossen. Succes!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              template["name"],
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Questions',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
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
                                Text(
                                  "/${template["questions"][index]["max_credit"]}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Text(
                              "Question:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(widget.template.data()["questions"][index]
                                ["question"]),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
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
                child: const Text("Examen indienen "))
          ]),
        ),
      ),
    );
  }
}
