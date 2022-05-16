import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'exam.dart';

class Check extends StatefulWidget {
  final template;
  final user;
  const Check(this.template, this.user, {Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

Future<Position> _determinePosition() async {
  // log('determin pos');
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class _CheckState extends State<Check> {
  bool locationReady = false;

  late Position position;
  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      // log(value.toString());
      setState(() {
        locationReady = true;
        position = value;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Exam Checks",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Before we can let you start an exam we have to check your location to prevent cheating.",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 600,
              child: Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FaIcon(
                        FontAwesomeIcons.locationPin,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    locationReady ? "Ready" : "Not ready",
                    style: TextStyle(
                        color: locationReady ? Colors.green : Colors.red),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: locationReady ? Colors.green : Colors.grey),
                onPressed: () {
                  if (locationReady) {
                    // log(position.longitude.toString());
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Exam(widget.template, widget.user, position)),
                      (route) => false,
                    );
                  }
                },
                child:
                    Text(locationReady ? "start exam" : 'waiting for location'))
          ],
        ),
      ),
    );
  }
}
