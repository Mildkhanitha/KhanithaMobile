import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'test2', home: MyAPP());
  }
}

class MyAPP extends StatefulWidget {
  const MyAPP({super.key});

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test App 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กดปุ่ม เพื่อเพิ่มค่าตัวเลข",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            Text(count.toString(), style: TextStyle(fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.access_alarm_outlined),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.delete_forever),
                ),

                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      count--;
                    });
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(height: 20),
            Image(
              image: NetworkImage(
                "https://github.com/Mildkhanitha/Image/blob/main/518812126_4134149246905705_837317520878488251_n.jpg?raw=true",
              ),
            ),
          ],
        ),
      ),
    );
  }
}