import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Moneybox extends StatelessWidget {
  String title;
  double amount =0;
  double sizeConHeight = 0;
  Color colorset ;
  double borderRadius;

  Moneybox(this.title,this.amount,this.sizeConHeight,this.colorset,this.borderRadius);

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.all(20.00),
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                decoration: BoxDecoration(
                  color: colorset,
                  borderRadius: BorderRadius.circular(borderRadius)),
                height: sizeConHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                    ),
                     Expanded(
                       child: Text('${NumberFormat("#,###.###").format(amount)}',
                                           style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                                           ),
                                           textAlign: TextAlign.right,
                                           ),
                     ),
                  ],
                )
              );
  }
  
}