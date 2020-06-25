import 'package:books/models/api_services.dart';
import 'package:books/models/books.dart';
import 'package:books/models/edit.dart';
import 'package:books/models/register.dart';
import 'package:books/models/stars.dart';
import 'package:books/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookServices {


  static const API = 'http://10.0.2.2:8000/api/books/';
  static const Auth = 'http://10.0.2.2:8000/auth/';
  static const registerAuth = 'http://10.0.2.2:8000/api/users/';
  static const header = {
    'Authentication': 'Token 6ad165aff6f5e3bf80bd95a9c6a4e337d648a8f7',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<Books>>> getNoteslists() {
    return http.get(API, headers: header).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        // the lists of books ....
        final notes = <Books>[];

        for(var item in jsonData){
           notes.add(Books.fromJson(item));
        }
        return  APIResponse<List<Books>>(data: notes);
       }
      return APIResponse<List<Books>>(error: true, message: 'not working .....');
    });
  }




  // giving a stars to a book ....
  Future<APIResponse<bool>> sendStar(Stars stars, int id){
    return http.post(API+'$id/rateBook/', headers: header, body:json.encode(stars.toJson()))
        .then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      print(id);
      return APIResponse<bool>(error: true, message: 'some error ');
    }).catchError((_) => APIResponse<bool>(error: true, message: 'an error occure'));

  }


  // title and description updates..

  Future<APIResponse<bool>> Update(EditTexts editTexts, int id){
    return http.put(API+'$id/', headers: header, body:json.encode(editTexts.tooJson()))
        .then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      print(id);
      return APIResponse<bool>(error: true, message: 'some error ');
    }).catchError((_) => APIResponse<bool>(error: true, message: 'an error occure'));

  }


  // new title and description ...
  Future<APIResponse<bool>> Insert(EditTexts editTexts){
    return http.post(API, headers: header, body:json.encode(editTexts.tooJson()))
        .then((data){
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message: 'some error ');
    }).catchError((_) => APIResponse<bool>(error: true, message: 'an error occure'));

  }


  Future<APIResponse<bool>> DeleteBook(int id){
    return http.delete(API + '$id/', headers: header)
        .then((data){
      if(data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message: 'some error ');
    })
        .catchError((_) => APIResponse<bool>(error: true, message: 'an error occure'));

  }


  Future<APIResponse<bool>> User(UserAuth user){
    return http.post(Auth,headers: {'Content-Type':'application/json'}, body: json.encode(user.toJson())).then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message: 'cannot logged a user ,');
    });
  }



  Future<APIResponse<bool>> RegisterAuth(Register user){
    return http.post(registerAuth,headers: {'Content-Type':'application/json'}, body: json.encode(user.toJson())).then((data){
      if(data.statusCode == 200){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, message: 'cannot create a user ,');
    });
  }



}
