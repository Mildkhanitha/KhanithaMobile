import 'package:flutter/material.dart';


class MyForm extends StatelessWidget {
  const MyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: My(context),
    );
  }

  Center My(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, 
          children: [
            Text("Go to Shopping "),
            Icon(Icons.add_shopping_cart_outlined),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const formShopping(); 
              },
            ),
          );
        },
      ),
    );
  }
}


class formShopping extends StatelessWidget {
  const formShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // ปุ่มสำหรับย้อนกลับ
          },
          child: const Text("Go Back"),
        ),
      ),
    );
  }
}