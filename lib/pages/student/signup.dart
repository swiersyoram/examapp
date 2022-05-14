import 'package:cloud_firestore/cloud_firestore.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.user,
                color: Colors.grey,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Student check-in",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: studentidcontroller,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                enableSuggestions: false,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 50, right: 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    users.add({
                      "firstname": firstnamecontroller.text,
                      "lastname": lastnamecontroller.text,
                      "studentid": studentidcontroller.text
                    }).then((value) => print("user added"));
                  },
                  child: Text("Check-in")),
            ],
          ),
        ),
      ),
    );
  }
}
