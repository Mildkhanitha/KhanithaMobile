import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 186, 207, 224)),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            
            padding: const EdgeInsets.symmetric(vertical: 20),
            foregroundColor: const Color.fromARGB(255, 90, 89, 89),

            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      home: const MyHomePage(title: 'My Calculator'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget myButton(String text,[Color? buttonColor, Color? textColor]) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5), 
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
  
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget myIconButton(IconData icon, [Color? textColor]) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Icon(icon, size: 30),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),      
              child: Text(
                "0", 
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height:50),
            Divider(thickness: 1),
            SizedBox(height:15),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton("%"),
                myButton("C",null,Colors.deepOrangeAccent),
                myIconButton(Icons.backspace_outlined,Colors.deepOrangeAccent),
                myButton("/")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton("7"),
                myButton("8"),
                myButton("9"),
                myButton("x")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton("4"),
                myButton("5"),
                myButton("6"),
                myButton("-")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton("1"),
                myButton("2"),
                myButton("3"),
                myButton("+")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton("+/-"),
                myButton("0"),
                myButton("."),
                myButton("=",const Color.fromARGB(255, 137, 180, 254),Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }
}
