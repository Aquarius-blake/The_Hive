
// Custom User Class


class User1{

  late final  String? UID;
  late final String? Email;
  late final String? Password;
  late final bool? Guest;
  dynamic profilepic;
  late final String? Username;
  late final DateTime? DOB;
  late final String? imageurl;
  late final String? ppurl;


  User1({ this.UID,
    this.profilepic,
    this.Guest,
    this.Username,
    this.Email,
    this.Password,
    this.DOB,
    this.imageurl});

  Map<String,dynamic> toJson()=>{
    "username":Username,
    "uid":UID,
    "email":Email,


  };
}