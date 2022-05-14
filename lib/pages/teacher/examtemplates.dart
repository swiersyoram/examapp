import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/teacher/edittemplate.dart';

import 'package:firebase_core/firebase_core.dart';
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Exam Templates",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTemplate(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
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
            padding: EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("exam_templates")
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("data loading");
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
                        title: Text(
                          data.docs[index]["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[700]),
                        ),
                        trailing: Wrap(children: [
                          ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('exam_templates')
                                    .doc(id)
                                    .delete();
                              },
                              child: FaIcon(FontAwesomeIcons.trashCan)),
                          SizedBox(
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
                              child: FaIcon(FontAwesomeIcons.penToSquare))
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
