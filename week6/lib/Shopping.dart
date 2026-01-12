import 'package:flutter/material.dart';



class formShopping extends StatelessWidget {
  formShopping({Key? key, required this.productname,required this.productDes}) 
  : super(key: key);
  final String productname,productDes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Screen"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
         icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text(productname),
            ),
          ],
   
        ),
      ),

    );
  }
}
