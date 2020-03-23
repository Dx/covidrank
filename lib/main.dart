import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covidnumbers/Comparison.dart';
import 'package:covidnumbers/Countries.dart';

void main() => runApp(Covid());

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => Countries(),
        '/comparison': (context) => Comparison(),
        '/detail': (context) => Comparison(),
      }
    );
  }
}

//@override
//Widget build(BuildContext context) {
//  return MaterialApp(
//      theme: ThemeData.dark().copyWith(
//    textTheme: TextTheme(
//      body1: TextStyle(color: Colors.black54),
//    ),
//  ),
//  initialRoute: "/",
//  routes: {
//  '/': (context) => Countries(),
//  '/comparison': (context) => Comparison(),
//  },
//}
//class Covid extends StatelessWidget {
//}


//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//      .then((_) {
//    runApp(
//        MaterialApp(
//          initialRoute: '/comparison',
//          routes: {
//            '/': (context) => Countries(),
//            '/comparison': (context) => Comparison(),
//          },
//        )
//    );
//  });
//}