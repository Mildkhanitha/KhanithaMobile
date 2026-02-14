import 'package:cw8_6706022510182/Qr_code.dart';
import 'package:cw8_6706022510182/web.dart';
import 'package:flutter/material.dart';

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyhomePage> {
  int _selectedIndex = 0;

  final List<Widget> _page = <Widget>[
    QrCode(),
    Web()
  ];
  void _onItem(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.web_asset_outlined),
              label: 'Web'
              ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItem,
        ),
        

    );
  }
}