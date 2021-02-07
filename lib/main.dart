import 'package:flutter/material.dart';
import 'package:tab_animation/responsive_safe_area.dart';
import 'package:tab_animation/tab_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Builder(
          builder: (context) {
            return ResponsiveSafeArea(
              builder: (context, size) {
                return TabAnimation(
                  safeAreaHeight: size.height,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
