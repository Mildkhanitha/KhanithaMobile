import 'package:flutter/material.dart';
import 'result.dart'; // *** อย่าลืม Import ไฟล์ปลายทาง

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // --- ตัวแปรเหมือนเดิม ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surController = TextEditingController();
  final TextEditingController _score1Controller = TextEditingController(); 
  final TextEditingController _score2Controller = TextEditingController(); 
  final TextEditingController _score3Controller = TextEditingController(); 


  String? selectedMajor; 
  String? selectedSubject; 
  
  final List<String> subjects = [
    "Mobile App Development",
    "Data Communication",
    "Network Security",
    "System Admin"
  ];

  // (ลบตัวแปร resultText ออก เพราะเราจะไปโชว์หน้าอื่นแล้ว)

  // --- ฟังก์ชันคำนวณและเปลี่ยนหน้า ---
  void calculateAndGo() {
    FocusScope.of(context).unfocus(); // ซ่อนคีย์บอร์ด

    // Validation เช็คค่าว่าง
    if (_nameController.text.isEmpty || _surController.text.isEmpty || selectedMajor == null || selectedSubject == null) {
      // แจ้งเตือนแบบ Popup (AlertDialog) หรือ SnackBar ก็ได้
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน!'), backgroundColor: Colors.red),
      );
      return;
    }
    if (double.tryParse(_score1Controller.text) == null ||
        double.tryParse(_score2Controller.text) == null ||
        double.tryParse(_score3Controller.text) == null) {
      
      // ถ้าตัวใดตัวหนึ่งแปลงเป็นเลขไม่ได้ (เป็น null) ให้แจ้งเตือนทันที
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกคะแนนเป็นตัวเลขเท่านั้น (ห้ามใส่ตัวอักษร)'), backgroundColor: Colors.red),
      );
      return; // จบการทำงาน ไม่ไปต่อ
    }


    // คำนวณ
    double s1 = double.tryParse(_score1Controller.text) ?? 0;
    double s2 = double.tryParse(_score2Controller.text) ?? 0;
    double s3 = double.tryParse(_score3Controller.text) ?? 0;

    double total = s1 + s2 + s3;
    String grade = "";

    if (total >= 80) grade = "A";
    else if (total >= 70) grade = "B";
    else if (total >= 60) grade = "C";
    else if (total >= 50) grade = "D";
    else grade = "F";

    // *** จุดสำคัญ: สั่งเปลี่ยนหน้าพร้อมส่งข้อมูล ***
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          name: _nameController.text,
          major: selectedMajor!,      // ใส่ ! เพราะเราเช็คแล้วว่าไม่ null แน่ๆ
          subject: selectedSubject!,
          totalScore: total,
          grade: grade,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("คำนวณเกรด (หน้าแรก)")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Code UI ส่วน Input เหมือนเดิมเป๊ะ ก๊อปมาวางได้เลย) ...
              
              const Text("ชื่อ:", style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 15),
              const Text("นามสกุล:",style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                controller: _surController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),

              const Text("เลือกสาขาวิชา:", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("INE"),
                      value: "INE",
                      groupValue: selectedMajor,
                      onChanged: (value) => setState(() => selectedMajor = value),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("INET"),
                      value: "INET",
                      groupValue: selectedMajor,
                      onChanged: (value) => setState(() => selectedMajor = value),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 15),

              const Text("เลือกรายวิชา:", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text("กรุณาเลือกวิชา"),
                value: selectedSubject,
                items: subjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => selectedSubject = val),
              ),
              const SizedBox(height: 20),

              const Text("กรอกคะแนน:", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(child: _buildScoreInput("เก็บ (30)", _score1Controller)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildScoreInput("กลาง (30)", _score2Controller)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildScoreInput("ปลาย (40)", _score3Controller)),
                ],
              ),
              const SizedBox(height: 30),

              // ปุ่มกด
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: calculateAndGo, // เรียกฟังก์ชันเปลี่ยนหน้า
                  child: const Text("คำนวณและดูผล", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    );
  }
}