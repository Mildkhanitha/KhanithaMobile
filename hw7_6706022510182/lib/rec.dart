import 'package:flutter/material.dart';

class Rec extends StatelessWidget {
  final double width;
  final double height;
  final double depth;
  final bool isVolume;

  Rec({
    required this.width, 
    required this.height, 
    this.depth = 0, 
    required this.isVolume
  });

  @override
  Widget build(BuildContext context) {
   
    double result = isVolume ? (width * height * depth) : (width * height);
    String title = isVolume ? 'Rectangle Volume' : 'Rectangle Area';

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
                Icon(Icons.crop_square, size: 80, color: Colors.teal),
                SizedBox(height: 20),
                Text('Width: $width', style: TextStyle(fontSize: 18)),
                Text('Height: $height', style: TextStyle(fontSize: 18)),
                if(isVolume) Text('Depth: $depth', style: TextStyle(fontSize: 18)),
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