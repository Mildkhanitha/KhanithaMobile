import 'package:flutter/material.dart';
import 'MoneyBox.dart';

void main() {
  runApp(const MyApp());
}

class Inputnew extends StatelessWidget {
  const Inputnew ({super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Acount Name",
        labelStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
  final Color color = states.contains(WidgetState.error)
      ? Theme.of(context).colorScheme.error
      : Colors.orange;
  return TextStyle(color: color, letterSpacing: 1.3);
}),
      
      ),
      validator: (value) {
        if (value == null || value == '') {
          return "Enter name";
          
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,

    );
  }
  
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test Container"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: 120,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Inputnew(),
              ),
      
              Moneybox("ยอดคงเหลือ", 30000.512, 120, Colors.lightBlue,30),
              SizedBox(height: 5),
              Moneybox("รายรับ", 10000, 100, Colors.green,30),
              SizedBox(height: 5),
              Moneybox("รายจ่าย", 80000, 100, Colors.orange,30),
              SizedBox(height: 5),
              Moneybox("ค้างจ่าย", 30000, 100, Colors.yellow,30),
              Container(
                child: TextButton(

                  onPressed: (){}, child: Text("button",style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),

                  )
                
              ),
            ],
          ),
        ),
      ),
  


      
    );
  }
}

