import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();
  await DatabaseHelper.instance.initializeUsers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users Management',
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
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
  Future<void> _fetchUsers() async {
    final userMaps = await DatabaseHelper.instance.queryAllusers();
    setState(() {
      _users = userMaps.map((userMaps) => User.fromMap(userMaps)).toList();
    });
  }
  Future<void> deleteUser(int userId) async{
    await DatabaseHelper.instance.deleteUser(userId);
    _fetchUsers();
  }
  void _editUser(User user){
    TextEditingController usernameController = 
    TextEditingController(text: user.username);
    TextEditingController emailController = 
    TextEditingController(text: user.email);

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("edit User"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            final updatedUser = User(
              id: user.id,
              username: usernameController.text,
              email: emailController.text,
            );
            DatabaseHelper.instance.updateUser(updatedUser).then((value){
              _fetchUsers();
            });
            Navigator.pop(context);
          }, 
          child: Text("Save"),
          ),
          TextButton(onPressed: () =>
          Navigator.pop(context), child: Text("Cancel"),
          ),
        ],

      );
    });
  }


  void _addUser() {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    showDialog(
     context: context,
     builder: (BuildContext context){
      return AlertDialog(
        title: Text("Add New User"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            final newUser = User(
              username: usernameController.text, 
              email: emailController.text,
            );
            DatabaseHelper.instance.insertUser(newUser).then((value){
              _fetchUsers();
            });
            Navigator.pop(context);
          }, child: Text("Add"),
          ),
          TextButton(onPressed: () => 
          Navigator.pop(context),
           child: Text("Cancel"),
           ),
        ],
      );
    },
    );
  }
  Future <void> _deleteAllUsers()async{
    await DatabaseHelper.instance.deleteAllUsers();
    _fetchUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 207, 252),
        title: Text("GFG User List"),
        actions: [
          IconButton(
            onPressed: _deleteAllUsers,
            icon: Icon(Icons.delete_forever),
            color: Colors.red,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context,index){
          final user = _users[index];
          return ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.cyan,
            ),
            title: Text(user.username),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () => _editUser(user), icon: Icon(Icons.edit),color: Colors.blue,),
                IconButton(onPressed: () => deleteUser(user.id!), icon: Icon(Icons.delete),color: Colors.red,)
              ],
            ),
          );
        },
        ),
        floatingActionButton: FloatingActionButton(onPressed: _addUser,
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255,7,174,221),
        ),
    );
  }
}
