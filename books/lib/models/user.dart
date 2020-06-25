

class UserAuth{
  String token;
  String username;
  String pass;

  UserAuth({this.username, this.pass, this.token});


  Map<String, dynamic> toJson(){
    return {
      'username': username,
      'password': pass,
      'token': token
    };
  }

}