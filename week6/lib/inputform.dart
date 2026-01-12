
import 'dart:ui';
import 'package:flutter/material.dart';
import 'shopping.dart'; 

enum ProductTypeEnum { Downloadable, Deliverable,Onshop,Reserver }

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  }) : super(key: key);
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(
            myIcon,
            color: prefixIconColor,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade300),
          ),
          labelStyle: const TextStyle(color: Colors.deepPurple)),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // 2. กำหนดค่าเริ่มต้นเป็น "" เพื่อกัน Error เรื่อง Null
  String _productName = "";
  String _productDes = "";

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();

  //ProductTypeEnum? _productTypeEnum;
  final _productSizesList = ["Small","Meduim","Large","Xlarge"];
  String? _selectedVal = "";
  _MyFormState(){
    _selectedVal = _productSizesList[0];
  }

  bool? _listTileCheckbox = false;

  @override
  void initState() {
    super.initState();
    _productController.addListener(_updateText);
    _productDesController.addListener(_updateText);
  }

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _productName = _productController.text;
      _productDes = _productDesController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text("Product App", style: TextStyle(fontSize: 30)),
            const Text("App Product detail in the form"),
            const SizedBox(height: 10.0),
            TextField(
              controller: _productController,
              decoration: const InputDecoration(
                  hintText: "Product Name",
                  icon: Icon(Icons.pin_drop_sharp),
                  prefixIconColor: Colors.deepPurple),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _productDesController,
              decoration: const InputDecoration(
                  labelText: "Product Description",
                  icon: Icon(Icons.pin_drop_sharp),
                  prefixIconColor: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: _listTileCheckbox,
              title: const Text("Top Product"),
              onChanged: (val) {
                setState(() {
                  _listTileCheckbox = val;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            DropdownButtonFormField(value: _selectedVal,items: _productSizesList.map((e) => DropdownMenuItem(child: Text(e),
            value: e,
            ))
            .toList(), onChanged: (val){
              setState(() {
                _selectedVal = val as String;
              });
            },
            icon: const Icon(Icons.arrow_drop_down_circle,
            color: Colors.deepPurple),
            dropdownColor: Colors.deepPurple.shade50,
            decoration: InputDecoration(
              labelText: "Product Sizes",
              prefixIcon: Icon(Icons.accessibility_new_rounded,
              color: Colors.deepPurple),
              border: OutlineInputBorder()
            ),
            ),
            /*RadioListTile<ProductTypeEnum>(
              title: Text(ProductTypeEnum.Deliverable.name),
              value: ProductTypeEnum.Deliverable, // แก้ให้ value ตรงกับ Title
              groupValue: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val;
                });
              },
            ),
             RadioListTile<ProductTypeEnum>(
              title: Text(ProductTypeEnum.Downloadable.name), // เพิ่มอีกตัวเลือกเพื่อให้ครบ
              value: ProductTypeEnum.Downloadable,
              groupValue: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val;
                });
              },
            ),
            RadioListTile<ProductTypeEnum>(
              title: Text(ProductTypeEnum.Onshop.name), // เพิ่มอีกตัวเลือกเพื่อให้ครบ
              value: ProductTypeEnum.Onshop,
              groupValue: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val;
                });
              },
            ),
            RadioListTile<ProductTypeEnum>(
              title: Text(ProductTypeEnum.Reserver.name), // เพิ่มอีกตัวเลือกเพื่อให้ครบ
              value: ProductTypeEnum.Reserver,
              groupValue: _productTypeEnum,
              onChanged: (val) {
                setState(() {
                  _productTypeEnum = val;
                });
              },
            ),
            const SizedBox(height: 20.0),
            mybtn(), // ปุ่ม Submit
            const SizedBox(height: 40.0),*/
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
              // ส่งค่าไปหน้า formShopping
              return formShopping(
                productname: _productName, 
                productDes: _productDes
              );
            },
          ),
        );
      },
      child: const Text("Submit"),
    );
  }
}