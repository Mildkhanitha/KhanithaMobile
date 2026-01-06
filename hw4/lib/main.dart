import 'package:flutter/material.dart';
import 'foodmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Food'),
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
  int totalorders = 0;
  int totalprice = 0;
  void addOrder(String price){
    setState(() {
      totalorders = totalorders +1;
      totalprice = totalprice + int.parse(price);
    });
  }
  List<Foodmenu> menu = [
    Foodmenu("กุ้งเผา", "500","อาหารทะเล"),
    Foodmenu("กะเพราหมู", "80","อาหารจานด่วน"),
    Foodmenu("ผัดไท", "75","อาหารจานด่วน"),
    Foodmenu("ต้มมะระ", "170","ต้ม"),
    Foodmenu("ปลาทอดกรอบ", "250","อาหารจานด่วน"),
    Foodmenu("ซาลาเปา", "50","กินเล่น"),
    Foodmenu("แหนมเนือง", "80","กินเล่น"),

  ];
  void addorder(){
    setState(() {
      menu.add(Foodmenu(
        "เมนูใหม่ ${menu.length + 1}", "100", "ประเภทใหม่ ${menu.length + 1}"));
    });
  }
  void removeoder(){
    setState(() {
      if (menu.isNotEmpty) {
        menu.removeLast();
        
      }
    });
  }

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
          title: Text(
            "${index +1 }" + "." + food.foodname,style: TextStyle(fontSize: 20),
            ),
          subtitle: Text(food.foodname +" "+  "ราคา"+ " " + food.foodprice + "บาท" +" | "+ food.type  ),
          onTap: (){
            setState(() {
              totalorders = totalorders + 1;
              totalprice = totalprice + int.parse(food.foodprice);
            });
           AlertDialog alert = AlertDialog(
            title: Text("คุณเลือกเมนู คือ" + food.foodname + "สั่งไปแล้วทั้งหมด: $totalorders จาน\n" + "ราคารวมตอนนี้: $totalprice บาท",style: const TextStyle(fontSize: 18),),
           );
           showDialog(context: context, 
            builder: (BuildContext context){
              return alert;
            },
            );
          },
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: addorder,
            tooltip: "Add Menu",
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
            ), SizedBox(width: 10),
          FloatingActionButton(
            onPressed:removeoder,
            tooltip: "Remove Menu",
            backgroundColor: Colors.red,
            child: Icon(Icons.remove),
            ),
        ],
      ),
    );
  }
}
