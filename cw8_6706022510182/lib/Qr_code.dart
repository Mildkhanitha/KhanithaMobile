import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodetState();
}

class _QrCodetState extends State<QrCode> {
  String _scanBarcode = 'Unknown';

  @override
  void initState(){
    super.initState();
  }
  Future<void> startBarcodeScanStrem()async{
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666',
      'Cancel', 
      true, 
      ScanMode.BARCODE,
      )!.listen((dynamic barcode)=>print(barcode));
  }
  Future<void> scanQR() async {
    String barcodeScanRes;
    try{
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 
        'Cancel', 
        true, 
        ScanMode.QR,
        );
        print(barcodeScanRes);
    }on PlatformException{
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try{
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 
        'Cancel', 
        true, 
        ScanMode.BARCODE,
        );
        print(barcodeScanRes);
    }on PlatformException{
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode =barcodeScanRes;
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Barcode Scan")
        ,backgroundColor: Colors.orange,),
        body: Builder(
          builder: (BuildContext context){
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => scanBarcodeNormal(), 
                    child: Text("Start Barcode scan"),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () => scanQR(), 
                      child: Text("Start QR Scan"),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () => startBarcodeScanStrem(), 
                        child: Text("Start Barcode scan stream")
                        ),
                        SizedBox(height: 10,),
                        Text("Scan result : $_scanBarcode\n",style: TextStyle(fontSize: 20),)
                ],),

            );
          }),
      ),

    );
  }
  }
