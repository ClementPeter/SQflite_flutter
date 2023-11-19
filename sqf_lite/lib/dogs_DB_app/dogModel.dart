// //Define Dog Model to specify the data to be held by the class

// class DogModel {
//   int id;
//   String name;
//   int age;

//   DogModel({required this.age, required this.id, required this.name});

//   //After creating the sqfliteDB

//   //Creating a toMap function for our Dog class
//   //Convert Dog into a Map ; Key must match the column names of our DB created

//   //we need to specify a toMap fuction in our class
//   //inorder to pass value to the DB using key-value pair

//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "name": name,
//       "age": age,
//     };
//   }

//   dynamic fromMap(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     age = json['age'];
//   }

//   // User.fromJson(Map<String, dynamic> json) {
//   // id = json['id'];
//   // firstname = json['first_name'];
//   // lastName = json['last_name'];
//   // email = json['email'];
//   // phoneNumber = json['phone_number'];
//   // isLoggedIn = json['isLoggedIn'];

//   //implement a toString Method to make it easier to see information about
//   // each dog when using the print statement.

//   @override
//   String toString() {
//     return 'Dog{id:$id,name: $name,age: $age}';
//   }
// }
