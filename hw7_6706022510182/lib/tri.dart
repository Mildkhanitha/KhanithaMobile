import 'package:flutter/material.dart';

class Tri extends StatelessWidget {
  final double base;
  final double height;
  final double depth;
  final bool isVolume;

  Tri({
    required this.base, 
    required this.height, 
    this.depth = 0, 
    required this.isVolume
  });

  @override
  Widget build(BuildContext context) {
  
    double area = 0.5 * base * height;
    double result = isVolume ? (area * depth) : area;
    String title = isVolume ? 'Triangle Prism Volume' : 'Triangle Area';

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
                Icon(Icons.change_history, size: 80, color: Colors.teal),
                SizedBox(height: 20),
                Text('Base: $base', style: TextStyle(fontSize: 18)),
                Text('Height: $height', style: TextStyle(fontSize: 18)),
                if(isVolume) Text('Length: $depth', style: TextStyle(fontSize: 18)),
                Divider(),
                Text(
                  '${isVolume ? "Volume" : "Area"}: $result',
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