class Model {
  final String id;
  final String name;
  final String address;
  final String email; 
  final String age;
  final String subject;

  Model._({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.age,
    required this.subject
  }); 

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model._(
      id: json['id'].toString(),
      name: json['name'],
      address: json['address'],
      email: json['email'],
      age: json['age'].toString(),
      subject: json['subject'].toString(),

    );
  } 
}