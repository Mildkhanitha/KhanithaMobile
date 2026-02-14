import 'package:flutter/material.dart';
import 'Database_helper.dart';
import 'User.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  await DatabaseHelper.instance.initializeUsers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'User Manaagement',
      
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});


  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users = [];

  @override
  void initState(){
    super.initState();
    _fetchUsers();
  }
  Future<void> _fetchUsers() async{
    final userMaps = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
    });
  }
  Future<void> _deleteUser(int userId) async{
    await DatabaseHelper.instance.deleteUser(userId);
    _fetchUsers();
  }
  void _editUser(User user){
    TextEditingController usernameController = TextEditingController(text: user.username);
    TextEditingController emailController = TextEditingController(text: user.email);
    TextEditingController pwdcontroller = TextEditingController(text: user.pwd);
    TextEditingController weightController = TextEditingController(text: user.weight.toString());
    TextEditingController heightController = TextEditingController(text: user.height.toString());

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: pwdcontroller,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
            ),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: "Height(cm)"),
            ),
            
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            final double weight = double.parse(weightController.text);
            final double height = double.parse(heightController.text);
            final updatedUser = User(id: user.id,
              username: usernameController.text,
              email: emailController.text, 
              pwd: pwdcontroller.text, 
              height: double.parse(weightController.text), 
              weight: double.parse(heightController.text),
              );
              DatabaseHelper.instance.updateUser(updatedUser).then((value){
                _fetchUsers();
              });
          }, child: const Text("Save")
          ),
          TextButton(onPressed: ()=>
          Navigator.pop(context), child: const Text("Cancel")
          ),
        ],
      );
    }
    );
  }
  void _addUser(){
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController pwdcontroller = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Add New Users"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "email"),
            ),
            TextField(
              controller: pwdcontroller,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Weight(kg)"),
            ),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: "Height(cm)"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            final double weight = double.parse(weightController.text);
            final double height = double.parse(heightController.text);
            final newUser = User(
                username: usernameController.text,
                email: emailController.text,
                pwd: pwdcontroller.text,
                weight: double.parse(weightController.text),
                height: double.parse(heightController.text),
              );
              DatabaseHelper.instance.insertUser(newUser).then((value) {
                _fetchUsers(); // Refresh the user list
                Navigator.pop(context); // Close the dialog
              });
          }, child: const Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    });

  }
  Future<void> deleteAllUser() async {
    await DatabaseHelper.instance.deleteAllUser(); // ลบข้อมูลผู้ใช้ทั้งหมด [cite: 139]
    _fetchUsers(); // อัปเดตข้อมูลใหม่ [cite: 141]
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show User List'),
        backgroundColor: Colors.cyan, 
        actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: deleteAllUser, // ลบข้อมูลทั้งหมดเมื่อกด [cite: 224]
          color: Colors.red, 
        ),
      ],
      ),
      body: ListView.builder(
      itemCount: _users.length, 
      itemBuilder: (context, index) {
        final user = _users[index]; 
        Widget _getBmiImage(String bmiType) {
          String imagePath;
          switch (bmiType) {
            case "Underweight":
              imagePath = "assets/images/bmi-1.png"; // ตัวอย่าง URL รูป
              break;
            case "Normal":
              imagePath = "assets/images/bmi-2.png";
              break;
            case "Risk to Overweight":
              imagePath = "assets/images/bmi-3.png";
              break;
            case "Overweight":
              imagePath = "assets/images/bmi-4.png";
              break;
            case "Obese":
            default:
              imagePath = "assets/images/bmi-5.png";
              break;
          }
          return Image.asset(imagePath, width: 50, height: 50,fit:BoxFit.contain);
        }
        return ListTile(
          
          leading: _getBmiImage(user.bmiType),
          title: Text("Username: ${user.username}"), 
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text("Email: ${user.email}"), 
              const SizedBox(height: 5),
              Text("Password: ${user.pwd}"), 
              const SizedBox(height: 5),
              Text("Weight: ${user.weight} kg"), 
              const SizedBox(height: 5),
              Text("Height: ${user.height} cm"), 
              const SizedBox(height: 5),
              Text("BMI: ${user.bmi}"), 
              const SizedBox(height: 5),
              Text("BMI TYPE: ${user.bmiType}"), 
              Text("${user.weightAdj}",
              style: TextStyle(
                color: user.bmiType == "Normal" ? Colors.green :Colors.red,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editUser(user), // Edit action [cite: 259]
                color: Colors.blue, 
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteUser(user.id!), // Delete action [cite: 264]
                color: Colors.red, 
              ),
            ],
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(onPressed: _addUser,
    backgroundColor: const Color.fromARGB(255, 7, 174, 221),
    child: const Icon(Icons.add),
    ),
    );
  }
}
   
