import 'package:flutter/material.dart';
import 'rec.dart';
import 'tri.dart';
import 'cir.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String selectedShape = 'Rectangle';
  int _selectedIndex = 0; 


  final heightController = TextEditingController();
  final widthController = TextEditingController();
  final baseController = TextEditingController();
  final radiusController = TextEditingController();
  final depthController = TextEditingController(); 

  final _formKey = GlobalKey<FormState>();

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (double.tryParse(value) == null) return 'Invalid Number';
    return null;
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isVolume = _selectedIndex == 1; 

    return Scaffold(
      appBar: AppBar(
        title: Text(isVolume ? 'Geometric Volume' : 'Geometric Area'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Card(
                elevation: 4,
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Rectangle (สี่เหลี่ยม)'),
                      value: 'Rectangle',
                      groupValue: selectedShape,
                      onChanged: (value) => setState(() => selectedShape = value!),
                      secondary: Icon(Icons.crop_square, color: Colors.teal),
                    ),
                    RadioListTile<String>(
                      title: Text('Triangle (สามเหลี่ยม)'),
                      value: 'Triangle',
                      groupValue: selectedShape,
                      onChanged: (value) => setState(() => selectedShape = value!),
                      secondary: Icon(Icons.change_history, color: Colors.teal),
                    ),
                    RadioListTile<String>(
                      title: Text('Circle (วงกลม)'),
                      value: 'Circle',
                      groupValue: selectedShape,
                      onChanged: (value) => setState(() => selectedShape = value!),
                      secondary: Icon(Icons.circle_outlined, color: Colors.teal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

             
              if (selectedShape == 'Rectangle') ...[
                _buildInput(widthController, 'Width (กว้าง)'),
                _buildInput(heightController, 'Height (ยาว/สูง)'),
                if (isVolume) _buildInput(depthController, 'Depth (ลึก/หนา)'),
              ],

              if (selectedShape == 'Triangle') ...[
                _buildInput(baseController, 'Base (ฐาน)'),
                _buildInput(heightController, 'Height (สูง)'),
                if (isVolume) _buildInput(depthController, 'Length (ความยาวแท่ง)'),
              ],

              if (selectedShape == 'Circle') ...[
                _buildInput(radiusController, 'Radius (รัศมี)'),

              ],

              SizedBox(height: 30),


              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _navigateToResult(context, isVolume);
                    }
                  },
                  child: Text(
                    isVolume ? 'Calculate Volume' : 'Calculate Area',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Area',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar),
            label: 'Volume',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  // Widget ช่วยสร้างช่องกรอกจะได้ไม่รก
  Widget _buildInput(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.edit),
        ),
        keyboardType: TextInputType.number,
        validator: validateNumber,
      ),
    );
  }
  void _navigateToResult(BuildContext context, bool isVolume) {
    double? d = isVolume ? double.tryParse(depthController.text) ?? 0 : 0;
    
    if (selectedShape == 'Rectangle') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Rec(
        width: double.parse(widthController.text),
        height: double.parse(heightController.text),
        depth: d,
        isVolume: isVolume,
      )));
    } else if (selectedShape == 'Triangle') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Tri(
        base: double.parse(baseController.text),
        height: double.parse(heightController.text),
        depth: d,
        isVolume: isVolume,
      )));
    } else if (selectedShape == 'Circle') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Cir(
        radius: double.parse(radiusController.text),
        isVolume: isVolume,
      )));
    }
  }
}