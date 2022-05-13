import 'package:examapp/pages/teacher/teacherdashboard.dart';
import 'package:examapp/pages/teacher/teacherlogin.dart';
import 'package:examapp/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./pages/homepage.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)),
          // StreamProvider(
          //     create: (context) =>
          //         context.read<AuthenticationService>().authStateChanges,
          //     initialData: null)
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'AP ExamApp',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => HomePage(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/teacherlogin': (context) => TeacherLogin(),
            '/teacherdashboard': (context) => TeacherDashboard(),
          },
        ));
  }
}
