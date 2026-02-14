class User {
  final int? id;
  final String username;
  final String email;
  final String pwd;
  final double weight;
  final double height;
  final double bmi;
  final String bmiType;
  final String weightAdj;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.pwd,
    required this.height,
    required this.weight,
  }) :bmi = calculatebmi(weight,height),bmiType = determineBmiType(calculatebmi(weight,height)),
  weightAdj = calculateWeightAdjustment(weight, height);
  
  static double calculatebmi (double weight,double height){
    return weight/((height/100) * (height/100));
  }

  static String determineBmiType(double bmi){
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 24.9){
      return "Normal";
    } else if (bmi < 29.9){
      return "Overweight";
    }else {
      return "Obese";
    }
  }
  static String calculateWeightAdjustment(double weight, double height) {
    double heightM = height / 100;
    double bmi = weight / (heightM * heightM);
    if (bmi < 18.5) {
      double targetWeight = 18.5 * (heightM * heightM);
      double diff = targetWeight - weight;
      return "ควรเพิ่มน้ำหนักอีก ${diff.toStringAsFixed(1)} kg";
    } else if (bmi > 24.9) {
      double targetWeight = 24.9 * (heightM * heightM);
      double diff = weight - targetWeight;
      return "ควรลดน้ำหนักลง ${diff.toStringAsFixed(1)} kg";
    }
    return "น้ำหนักอยู่ในเกณฑ์ปกติแล้ว";
  }

  Map<String , dynamic> toMap(){
    return {
      "id":id,
      'username':username,
      'email':email,
      'pwd':pwd,
      'weight':weight,
      "height":height,
      "bmi":bmi,
      "bmi_type":bmiType,
      "weight_adj": weightAdj //
    };
  } 

  factory User.fromMap(Map<String,dynamic>map){
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      pwd: map['pwd'],
      weight: map['weight'],
      height: map['height']
    );
  }
}