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
    Foodmenu("กุ้งเผา", "500","assets/images/m6.jpg","อาหารทะเล"),
    Foodmenu("กะเพราหมู", "80","assets/images/m1.jpg","อาหารจานด่วน"),
    Foodmenu("ผัดไท", "75","assets/images/m2.jpg","อาหารจานด่วน"),
    Foodmenu("ต้มมะระ", "170","assets/images/m7.jpg","ต้ม"),
    Foodmenu("ปลาทอดกรอบ", "250","assets/images/m8.jpg","อาหารจานด่วน"),
    Foodmenu("ซาลาเปา", "50","assets/images/m5.jpg","กินเล่น"),
    Foodmenu("แหนมเนือง", "80","assets/images/m9.jpg","กินเล่น"),
    Foodmenu("ซูชิ", "60","assets/images/m3.jpg","อาหารญี่ปุ่น"),
    Foodmenu("บาร์บิคิว", "90","assets/images/m4.jpg","กินเล่น"),
    Foodmenu('แฮมเบอร์เกอร์', "190","assets/images/m10.jpg","อาหารจานด่วน"),
    Foodmenu("ไก่ย่าง", "50","assets/images/m11.jpg","กินเล่น"),
    Foodmenu("เทมปุระกุ้ง", "85", "assets/images/m12.jpg","อาหารญี่ปุ่น"),
    Foodmenu("ทงคัตสึ", "120", "assets/images/m13.jpg","อาหารญี่ปุ่น"),
    Foodmenu("คาราอะเกะ", "115", "assets/images/m14.jpg","อาหารญี่ปุ่น"),
    Foodmenu("เกี๊ยวซ่า", "93", "assets/images/m15.jpg","อาหารญี่ปุ่น"),
    Foodmenu("ต้มยำกุ้งน้ำข้น", "125", "assets/images/m16.jpg","อาหารญี่ปุ่น"),
    Foodmenu("ต้มจืด", "80", "assets/images/m17.jpg","ต้ม"),
    Foodmenu("ต้มข่าไก่", "115", "assets/images/m18.png","ต้ม"),
    Foodmenu("ไข่เจียวหมูสับ", "70", "assets/images/m19.jpg","อาหารจานด่วน"),
    Foodmenu("กะเพราหมูกรอบ", "75", "assets/images/m20.jpg","อาหารจานด่วน")


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
          leading: Image.asset(food.img,width: 100,height: 100,fit: BoxFit.cover,alignment: Alignment.center),
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
    );
  }
}
