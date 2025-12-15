import 'package:flutter/material.dart';
void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context){
    return MyHomePage();
  }
}
class MyHomePage extends StatefulWidget{ 
  const MyHomePage({super.key});
  @override
  State<MyHomePage > createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
 int num = 0;
 String num2 ="";
 String num1 = "";
 String operator = "";
 String showval = "0";
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Myapp",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(showval.toString(),style: TextStyle(fontSize: 40),),SizedBox(height: 17,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: (){
                  setState(() {
                    if (operator.isEmpty) {
                      num1 +="7";
                      showval = num1;
                    }else{
                      num2 += "7";
                      showval = num2;
                    }
                });
                },child: Text("7"),
                ),SizedBox(width: 17,),

                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="8";
                      showval = num1;
                    }else{
                      num2 += "8";
                      showval = num2;
                    }
                  
                });},child: Text("8"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="9";
                      showval = num1;
                    }else{
                      num2 += "9";
                      showval = num2;
                    }
                });},child: Text("9"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  setState(() {
                    operator = "+";
                  });
            
                });},child: Text("+"),),SizedBox(width: 17,),
              ],
            ),
            SizedBox(height: 17,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="4";
                      showval = num1;
                    }else{
                      num2 += "4";
                      showval = num2;
                    }
                });},child: Text("4"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="5";
                      showval = num1;
                    }else{
                      num2 += "5";
                      showval = num2;
                    }
                });},child: Text("5"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="6";
                      showval = num1;
                    }else{
                      num2 += "6";
                      showval = num2;
                    }
                });},child: Text("6"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  setState(() {
                    operator="-";
                  });
              
                });},child: Text("-"),),SizedBox(width: 17,),
              ],
            ),
            SizedBox(height: 17,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="1";
                      showval = num1;
                    }else{
                      num2 += "1";
                      showval = num2;
                    }
                });},child: Text("1"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="2";
                      showval = num1;
                    }else{
                      num2 += "2";
                      showval = num2;
                    }
                });},child: Text("2"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="3";
                      showval = num1;
                    }else{
                      num2 += "3";
                      showval = num2;
                    }
                });},child: Text("3"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){
                  setState(() {
                    operator = "*";
                  });
                },child: Text("*"),),SizedBox(width: 17,),
              ],
            ),
            SizedBox(height: 17,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: (){setState(() {
                  if (operator.isEmpty) {
                      num1 +="0";
                      showval = num1;
                    }else{
                      num2 += "0";
                      showval = num2;
                    }
                });},child: Text("0"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  num1 = "";
                  num2="";
                  showval="0";
                  operator="";


                });},child: Text("C"),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){setState(() {
                  if (num1==""||num2=="")return; 
                  double Newnum1 = double.parse(num1);
                  double Newnum2 = double.parse(num2);
                  double result = 0;
                  if (operator == "+") result = Newnum1+Newnum2; 
                  if (operator == "-") result = Newnum1-Newnum2; 
                  if (operator == "*") result = Newnum1*Newnum2; 
                  if (operator == "/") result = Newnum1 / Newnum2; 
                  showval = result.toString();
                  num1="";
                  num2="";
                  operator="";
                });
                  
                },child: Text("="),),SizedBox(width: 17,),
                FloatingActionButton(onPressed: (){},child: Text("/"),),SizedBox(width: 17,),
              ],
            )
            
          ],
        )),
      ),
    );
  }
}