import 'package:flutter/material.dart';

import 'Raiting_Bar_Widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'High-End Rating Bar Demo',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('High-End Rating Bar')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: HighEndRatingBar(
              initialRating: 3.5,
              starCount: 5,
              onRatingChanged: (rating) {
                print('New rating: $rating');
              },
              filledStarColor: Colors.deepOrangeAccent,
              unfilledStarColor: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
