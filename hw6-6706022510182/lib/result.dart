import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  // 1. ประกาศตัวแปรสำหรับรอรับข้อมูล
  final String name;
  final String major;
  final String subject;
  final double totalScore;
  final String grade;

  // 2. Constructor (ประตูรับของ)
  const ResultPage({
    super.key,
    required this.name,
    required this.major,
    required this.subject,
    required this.totalScore,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ผลการเรียน"),
        backgroundColor: Colors.green, // เปลี่ยนสีหน่อยจะได้รู้ว่าคนละหน้า
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("สรุปผลการเรียน", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              
              // แสดงข้อมูลที่รับมา
              Text("ชื่อ: $name", style: const TextStyle(fontSize: 18)),
              Text("สาขา: $major", style: const TextStyle(fontSize: 18)),
              Text("วิชา: $subject", style: const TextStyle(fontSize: 18)),
              
              const Divider(thickness: 2, height: 40), // เส้นขีดคั่น
              
              Text("คะแนนรวม: $totalScore", style: const TextStyle(fontSize: 20)),
              Text("เกรดที่ได้", style: const TextStyle(fontSize: 20)),
              
              // โชว์เกรดตัวใหญ่ๆ
              Text(
                grade, 
                style: TextStyle(
                  fontSize: 100, 
                  fontWeight: FontWeight.bold,
                  // ถ้าเกรด F ให้สีแดง, เกรดอื่นสีเขียว
                  color: grade == "F" ? Colors.red : Colors.green 
                )
              ),

              const SizedBox(height: 40),
              
              // ปุ่มย้อนกลับ
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // ปิดหน้านี้ (กลับไปหน้าเดิม)
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("กลับไปคำนวณใหม่"),
              )
            ],
          ),
        ),
      ),
    );
  }
}