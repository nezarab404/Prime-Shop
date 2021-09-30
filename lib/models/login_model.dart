class LoginData {
  late bool status;
  late String message;
  UserData? data;

  LoginData.fromJson(json){
    status = json['status'];
    message = json['message'];
    data = json['data']!=null ? UserData.fromJson(json['data']) :null;
  }

}

class UserData {
  int? id;
  String? name;
  String? email;
  String? image;
  String? phone;
  String? token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}


// {
//     "status": true,
//     "message": "تم تسجيل الدخول بنجاح",
//     "data": {
//         "id": 3070,
//         "name": "Nezar Ab",
//         "email": "nezzz@gmail.com",
//         "phone": "09876543210",
//         "image": "https://student.valuxapps.com/storage/uploads/users/4DPLD8ymml_1629735692.jpeg",
//         "points": 0,
//         "credit": 0,
//         "token": "s5PzY5RjWx1F1lDzH1NJcdLJ1XyymGQ8RS3NrSimsWU2eAYXb5CteSPH0YieSXtTC9VZOa"
//     }
// }
