import 'package:flutter/material.dart';
import 'dart:math';

class Cir extends StatelessWidget {
  final double radius;
  final bool isVolume;

  Cir({required this.radius, required this.isVolume});

  @override
  Widget build(BuildContext context) {
    
    double result;
    if (isVolume) {
      result = (4/3) * pi * pow(radius, 3);
    } else {
      result = pi * pow(radius, 2);
    }
    

    String resultShow = result.toStringAsFixed(2);
    String title = isVolume ? 'Sphere Volume' : 'Circle Area';

    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.teal, foregroundColor: Colors.white,),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle_outlined, size: 80, color: Colors.teal),
                SizedBox(height: 20),
                Text('Radius: $radius', style: TextStyle(fontSize: 18)),
                Divider(),
                Text(
                  '${isVolume ? "Volume" : "Area"}: $resultShow',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}