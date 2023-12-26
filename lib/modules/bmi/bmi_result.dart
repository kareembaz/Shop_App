import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final int result;
  final int age;
  final bool isMale;
  BmiResultScreen({
    required this.result,
    required this.isMale,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            'BMI Calculator',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 108, 76, 197),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale ? 'Male' : 'Female'} ',
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              'Result : $result',
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              'Age : $age',
              style: TextStyle(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
