import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; 

class ShowInf extends StatefulWidget {
  const ShowInf({Key? key}) : super(key: key);

  @override
  State<ShowInf> createState() => _ShowInfState(); 
}

class _ShowInfState extends State<ShowInf> {
  List list = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _AgeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  // 1. ดึงข้อมูลจาก API [cite: 778-798]
  Future<String> listData() async {
    var response = await http.get(
      Uri.http('10.0.2.2:5000', 'emp'), 
      headers: {"Accept": "application/json"},
    );
    
    setState(() {
      list = jsonDecode(response.body);
    });
    return "Success"; 
  }

  @override
  void initState() {
    super.initState();
    listData();
  }

  // 2. ฟังก์ชันเพิ่มข้อมูล (แก้ไข Key เป็นตัวเล็ก) [cite: 1180-1183]
  void add_data() async {
    Map data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'age': _AgeController.text,      // แก้เป็น 'age'
      'subject': _subjectController.text // แก้เป็น 'subject'
    };
    
    var body = jsonEncode(data);
    await http.post(
      Uri.http('10.0.2.2:5000', 'create'),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: body,
    ); 
    listData(); 
  }

  // 3. ฟังก์ชันลบข้อมูล [cite: 1194-1196]
  void del_data(int id) async {
    await http.delete(
      Uri.http('10.0.2.2:5000', 'delete/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8', "Accept": "application/json"},
    );
    listData();
  }

  // 4. ฟังก์ชันแก้ไขข้อมูล (แก้ไข Key เป็นตัวเล็ก) [cite: 1283-1296]
  void edit_data(id) async {
    Map data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'age': _AgeController.text,      // แก้เป็น 'age'
      'subject': _subjectController.text // แก้เป็น 'subject'
    };
    
    var body = jsonEncode(data); 
    await http.put(
      Uri.http('10.0.2.2:5000', 'update/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: body,
    ); 
    listData();
  }

  // --- UI Dialogs ---

  Future<void> _addNewDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เพิ่มข้อมูลใหม่'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name:')),
                TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email:')),
                TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone:')),
                TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address:')),
                TextField(controller: _AgeController, decoration: const InputDecoration(labelText: "Age")),
                TextField(controller: _subjectController, decoration: const InputDecoration(labelText: "Subject")),
                const Text('กรอกข้อมูลให้เรียบร้อยแล้วกด ยืนยัน'), 
              ],
            ),
          ),
          actions: [
            TextButton(child: const Text('ยกเลิก'), onPressed: () => Navigator.pop(context)),
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () { add_data(); Navigator.of(context).pop(); },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDel(int id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ลบข้อมูล ID: $id'), // เพิ่ม $id 
        content: const Text('คุณยืนยันที่จะลบข้อมูลนี้ใช่หรือไม่?'),
        actions: [
          TextButton(child: const Text('ยกเลิก'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('ยืนยัน'), onPressed: () { del_data(id); Navigator.pop(context); }),
        ],
      ),
    );
  }

  Future<void> _showedit(Map data) async {
    _nameController.text = data['name'];
    _emailController.text = data['email'];
    _phoneController.text = data['phone'] ?? "";
    _addressController.text = data['address'] ?? "";
    _AgeController.text = data["age"]?.toString() ?? "";     // แก้เป็น 'age' [cite: 1201-1209]
    _subjectController.text = data["subject"]?.toString() ?? ""; // แก้เป็น 'subject' [cite: 1201-1209]

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('แก้ไขข้อมูล'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name:')),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email:')),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone:')),
              TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address:')),
              TextField(controller: _AgeController, decoration: const InputDecoration(labelText: "Age")),
              TextField(controller: _subjectController, decoration: const InputDecoration(labelText: "Subject")),
            ],
          ),
        ),
        actions: [
          TextButton(child: const Text('ยกเลิก'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('ยืนยัน'), onPressed: () { edit_data(data['id']); Navigator.pop(context); }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DB Test")), 
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text((index + 1).toString()), // ลำดับที่
              title: Text(list[index]['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${list[index]['email']}"),
                  Text("อายุ: ${list[index]['age']} | สาขาวิชา: ${list[index]['subject']}"), // แก้ Key ตัวเล็ก
                ],
              ), 
              trailing: Wrap(
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.green), onPressed: () => _showedit(list[index])), 
                  IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => _showDel(list[index]['id'])), 
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _nameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _addressController.clear();
          _subjectController.clear();
          _AgeController.clear();
          _addNewDialog();
        }
      ),
    );
  }
}