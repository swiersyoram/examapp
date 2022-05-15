import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/teacher/examentry.dart';
import 'package:flutter/material.dart';

class ExamEntries extends StatelessWidget {
  const ExamEntries({Key? key}) : super(key: key);
  double maxCredit(questions) {
    double sum = 0;
    for (var question in questions) {
      sum += double.parse(question["max_credit"]);
    }
    return sum;
  }

  double? credit(questions) {
    double sum = 0;
    if (questions.first.containsKey("credit")) {
      for (var question in questions) {
        sum += double.parse(question["credit"]);
      }
      return sum;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Exam entries",
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Container(
              width: 600,
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("exam_entries")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("data loading");
                  }
                  final data = snapshot.requireData;
                  // log(data.docs);
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        String id = data.docs[index].id;
                        return ListTile(
                          tileColor: index.isEven ? Colors.grey[300] : null,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date: ${DateTime.parse(data.docs[index]["starttime"].toDate().toString())}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                              Text(
                                "Student: ${data.docs[index]["user"]["firstname"]} ${data.docs[index]["user"]["lastname"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                              Text(
                                "Exam: ${data.docs[index]["exam"]["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                              Text(
                                "Score: ${credit(data.docs[index]["exam"]["questions"]) == null ? "Not corrected" : credit(data.docs[index]["exam"]["questions"])} /${maxCredit(data.docs[index]["exam"]["questions"])}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          trailing: Wrap(children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ExamEntry(data.docs[index]),
                                    ),
                                  );
                                },
                                child: Text("inspect"))
                          ]),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
