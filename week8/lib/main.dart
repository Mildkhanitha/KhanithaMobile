import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'List Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class data {
  late int id;
  late String name;
  late DateTime t;
  data(this.id,this.name,this.t);
  
}


class _MyHomePageState extends State<MyHomePage> {
  String txt = 'N/A';
  List<data> mylist = <data> [];
  int img = 0;
  var list = ['one','two','three','four'];

  final TextEditingController _textController = TextEditingController();

  String getimagePath(int id){
    switch (id) {
      case 1: return 'assets/images/ig.png';
      case 2: return 'assets/images/line.png';
      case 3: return 'assets/images/avenger.png';
      case 4: return 'assets/images/marvel.jpg';
      default: return 'assets/images/rocket.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Radio(value: 1,
                groupValue: img,
                onChanged: (int? value){
                  setState(() {
                    img = 1;
                  });
                }),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/ig.png'),
                ),
                Radio(value: 2,
                groupValue: img,
                onChanged: (int? value){
                  setState(() {
                    img = 2;
                  });
                }),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/line.png'),
                ),
                Radio(value: 3,
                groupValue: img,
                onChanged: (int? value){
                  setState(() {
                    img = 3;
                  });
                }),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avenger.png'),
                ),
                Radio(value: 4,
                groupValue: img,
                onChanged: (int? value){
                  setState(() {
                    img = 4;
                  });
                }),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/marvel.jpg'),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter Item Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              setState(() {
                String nameToAdd = _textController.text.isEmpty ? "No Name" : _textController.text;
                txt = "Add item Succees";
                mylist.add(data(img, nameToAdd, DateTime.now()));
                _textController.clear();
              });
            }, 
            child: const Text("Add Item")),
            Text(
              txt,
              textScaleFactor: 2,
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              height: 550,
              child: ListView.builder(
                itemCount: mylist.length, 
                itemBuilder: (context,index){
                return SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(getimagePath(mylist[index].id)),
                      ),
                      title: Text("${mylist[index].name} (${index + 1})"),
                      subtitle: Text(mylist[index].t.toString()),
                      trailing: IconButton(onPressed: (){
                        setState(() {
                          txt = "${mylist[index].name} (${index + 1}) is removed";
                          mylist.removeAt(index);
                        });
                      }, icon: const Icon(Icons.delete_rounded, size: 30))
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),

    );

      
      
  
  }
}
