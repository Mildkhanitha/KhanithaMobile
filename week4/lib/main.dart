import 'package:flutter/material.dart';
import 'Foodmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Foodmenu> menu = [
    Foodmenu("กุ้งเผา", "500"),
    Foodmenu("กะเพราหมู", "80"),
    Foodmenu("ข้าวผัด", "60"),

  ];




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context,int index){
          Foodmenu food = menu[index];
        return ListTile(
          title: Text("เมนูที่ ${index +1 }"),
          subtitle: Text(food.foodname +"ราคา"+food.foodprice+"บาท"),
        );
      }),
    );
  }
}
