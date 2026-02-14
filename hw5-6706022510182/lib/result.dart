import 'package:flutter/material.dart';
import 'dart:math';

class Result extends StatelessWidget {
  final int number;
  final int amount;
  const Result({super.key,required this.number,required this.amount});


  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int luckyNumber = random.nextInt(1000);
    bool isWin = (number == luckyNumber);
    String showNumber = luckyNumber.toString().padLeft(3, '0');
    int prizeMoney = isWin ? (amount * 100) : 0;



    return Scaffold(
      appBar: AppBar(title: Text("ตรวจหวย")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("เลขที่คุณซื้อ $number", style: TextStyle(fontSize: 24)),
            Text("จำนวนเงินที่ต้องการซื้อ คือ $amount บาท ",style: TextStyle(fontSize: 24)),
            SizedBox(height: 20,),
            const Text("เลขที่ออก", style: TextStyle(fontSize: 24)),
            Text(showNumber,style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 20,),
            if (isWin) ...[
              // ถ้าถูกรางวัล (True) ให้แสดงชุดนี้
              const Text("ยินดีด้วย!", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),
              Text("รับเงินรางวัล $prizeMoney บาท", style: const TextStyle(color: Colors.green, fontSize: 24)),
            ] else ...[
              // ถ้าผิดรางวัล (False) ให้แสดงชุดนี้
              const Text("เสียใจด้วยนะ", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold)),
              const Text("คุณไม่ถูกรางวัล", style: TextStyle(color: Colors.grey, fontSize: 20)),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("คลิก กลับหน้าหลัก"))
            ],
            
          ],
        ),
      )

    );
  }
}

