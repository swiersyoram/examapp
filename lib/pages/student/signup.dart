import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/pages/student/examlist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstnamecontroller = TextEditingController();
    final TextEditingController lastnamecontroller = TextEditingController();
    final TextEditingController studentidcontroller = TextEditingController();
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Center(
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Student check-in",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                  controller: firstnamecontroller,
                  decoration: InputDecoration(
                    labelText: "First name",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              TextField(
                  controller: lastnamecontroller,
                  decoration: InputDecoration(
                    labelText: "Last name",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              TextField(
                  controller: studentidcontroller,
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(left: 50, right: 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () async {
                    final user = await users
                        .where("studentid", isEqualTo: studentidcontroller.text)
                        .get()
                        .then((value) {
                      if (value.docs.isNotEmpty) {
                        // log(value.docs.first.id);
                        return value.docs.first;
                      } else {
                        log("no document found");
                        final user = {
                          "firstname": firstnamecontroller.text,
                          "lastname": lastnamecontroller.text,
                          "studentid": studentidcontroller.text
                        };
                        return users.add(user).then((value) {
                          return users.doc(value.id).get();
                        });
                      }
                    });
                    // log(user.toString());
                    // log(userid.toString());
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ExamList(user)),
                      (route) => false,
                    );
                  },
                  child: const Text("Check-in")),
            ],
          ),
        ),
      ),
    );
  }
}
