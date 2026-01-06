import 'package:flutter/material.dart';
import 'Shopping.dart'; 

class Inputform extends StatefulWidget {
  const Inputform({super.key});

  @override
  State<Inputform> createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  String _productName = "";
  String _customerName = "";
  
  final _productController = TextEditingController();
  final _customerController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _productController.addListener(_updateText);
    _customerController.addListener(_updateText);
  }

  @override
  void dispose() {
    _productController.dispose();
    _customerController.dispose();
    super.dispose();
  }

  void _updateText(){
    setState(() {
      _productName = _productController.text;
      _customerName = _customerController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App bar"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text("Input form", style: TextStyle(fontSize: 20)),
            TextField(
              controller: _productController,
              decoration: const InputDecoration(
                hintText: "Product Name",
                icon: Icon(Icons.verified_user_outlined),
              ),
            ),
            TextFormField(
              controller: _customerController,
              decoration: const InputDecoration(
                labelText: "Customer Name",
                icon: Icon(Icons.verified_user_outlined),
              ),
            ),
            const SizedBox(height: 20),
            
            mybtn(), // เรียกใช้งานปุ่ม
            
            const SizedBox(height: 20),
            
            // แสดงผล
            Text("Product Name is : $_productName", 
              style: const TextStyle(fontSize: 15)),
            Text("Customer Name is : $_customerName",
              style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  OutlinedButton mybtn() {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // ตอนนี้ _productName เป็น String แน่นอนแล้ว เส้นแดงจะหายไปครับ
              return formShopping(productname: _productName);
            },
          ),
        );
      },
      child: const Text("Submit"),
    );
  }
}