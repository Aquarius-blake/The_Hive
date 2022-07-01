
// Custom User Class


class User1{

  late final  String? UID;
  late final String? Email;
  late final String? Password;
  late final bool? Guest;
  dynamic profilepic;
  late final String? Username;
  late final Future<DateTime?>? DOB;


  User1({ this.UID, this.profilepic,this.Guest,this.Username,this.Email,this.Password,this.DOB});

}