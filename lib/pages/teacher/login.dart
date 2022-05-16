import 'dart:developer';

import 'package:examapp/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  // final LoginTeacher({Key? key}) : super(key: key);
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  bool showerror = false;

  @override
  Widget build(BuildContext context) {
    emailcontroller.text = "yoram@swiers.be";
    passwordcontroller.text = "test123";

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.co_present,
                color: Colors.grey,
                size: 100,
              ),
              const Text(
                "Teacher login",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: "email",
                    hintText: "Enter email address",
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
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: "password",
                  hintText: "Enter password",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
                enableSuggestions: false,
              ),
              Container(
                  child: showerror
                      ? Column(children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "wrong email or password!",
                            style: TextStyle(color: Colors.red),
                          )
                        ])
                      : null),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(left: 50, right: 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () async {
                    final code = await context
                        .read<AuthenticationService>()
                        .signIn(
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                    if (code == "user-not-found" || code == "wrong-password") {
                      setState(() {
                        log(code);

                        showerror = true;
                      });
                    }
                  },
                  child: const Text("login")),
            ],
          ),
        ),
      ),
    );
  }
}
