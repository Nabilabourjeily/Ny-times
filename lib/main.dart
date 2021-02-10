import 'package:flutter/material.dart';
import './router.dart' as router;
import './routing_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New York Times',
      onGenerateRoute: router.generateRoute,
      initialRoute: ArticlesScreenRoute,
    );
  }
}
