
class Register{
  String username;
  String pass;

  Register({this.username, this.pass});


  Map<String, dynamic> toJson(){
    return {
      'username': username,
      'password': pass
    };
  }

}