import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_6706022510182/result.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller= TextEditingController();
  final TextEditingController _controller1= TextEditingController();
  final TextEditingController _controller2= TextEditingController();
  final TextEditingController _controller3= TextEditingController();

  String? errorText;
  void checkNumber(){
    if (_controller.text.isEmpty || _controller1.text.isEmpty || _controller2.text.isEmpty | _controller3.text.isEmpty) {
      setState(() {
        errorText = "กรุณากรอกตัวเลข";
      });
      return;
    }
    String combinedNumber = _controller.text + _controller1.text + _controller2.text;
    final int? money = int.tryParse(_controller3.text);
    final int? number = int.tryParse(combinedNumber);
    if (number == null || money == null ) {
      setState(() {
        errorText = "กรุณากรอกเป็นตัวเลขเท่านั้น";
      });
      return;
    }
    Navigator.push
    (context,
     MaterialPageRoute(builder: (context) => Result(number : number, amount: money),
     ),
     );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("หวย"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    labelText: "หลักที่ 1",
                    errorText: errorText
                  ),
                  
                ),
                ),
                SizedBox(width: 30,),
                SizedBox(width: 50,
                child: TextField(
                  controller: _controller1,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    labelText: "หลักที่ 2",
                    errorText: errorText
                  ),
                ),
                ),
                SizedBox(width: 30,),
                SizedBox(width: 50,
                child: TextField(
                  controller: _controller2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    labelText: "หลักที่ 3",
                    errorText: errorText
                  ),
                ),
                ),
           
              ],
            ),
            SizedBox(height: 60,),
            Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("จำนวนเงินที่ต้องการซื้อ",style: TextStyle(fontSize: 20),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controller3,
                      keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: errorText
                    )
                  ),
                ),
                SizedBox(width: 20,),
                Text("บาท")
                ],
              ),
            ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: checkNumber, child: const Text("คลิก ตรวจรางวัล"))
          ],
        ),
      ),

     
    );

  }
}

