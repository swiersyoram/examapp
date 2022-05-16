import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/teacher/edittemplate.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExamTemplates extends StatelessWidget {
  const ExamTemplates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Exam Templates",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditTemplate(),
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.plus),
                      SizedBox(
                        width: 10,
                      ),
                      Text("create")
                    ],
                  ))
            ],
          ),
          Container(
            width: 800,
            padding: const EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("exam_templates")
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
                        title: Row(
                          children: [
                            Text(
                              data.docs[index]["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey[700]),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              data.docs[index]["active"]
                                  ? "active"
                                  : "not active",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: data.docs[index]["active"]
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                        trailing: Wrap(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('exam_templates')
                                    .doc(id)
                                    .delete();
                              },
                              child: const FaIcon(FontAwesomeIcons.trashCan)),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditTemplate(data.docs[index]),
                                  ),
                                );
                              },
                              child: const FaIcon(FontAwesomeIcons.penToSquare))
                        ]),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
