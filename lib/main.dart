import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/Core/Firebase/firebasemodel.dart';

import 'Core/Home/home.dart';
import 'Core/Reports/reportview.dart';

var F = FirebaseModal();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.storage.request();

  await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
      );

  FlutterDownloader.registerCallback(TestClass.callback);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Demo extends StatefulWidget {
  static void callback(String id, DownloadTaskStatus status, int progress) {}

  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TestClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    if (progress == 100) {
      isPDFloading = false;
    }
  }
}
