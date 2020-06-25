import 'package:books/models/books.dart';
import 'package:books/models/register.dart';
import 'package:books/models/user.dart';
import 'package:books/services/book_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  BookServices get service => GetIt.I<BookServices>();


  bool id = true;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF282c34),
          scaffoldBackgroundColor: Color(0xFF282c34)),
      home: Scaffold(
        // appBar: AppBar(title:Text('hello')),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    id ? 'Log In': 'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 20),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'User Name',
                  prefixIcon: Icon(Icons.person_pin, color: Colors.white),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_open, color: Colors.white),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: RaisedButton(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () async {



                          // for login
                          if(id == true){
                            final data = UserAuth(
                                username: usernameController.text,
                                pass: passwordController.text,
                                );
                            final result = await service.User(data);
                            if (result.data && result.data != null) {
                              Navigator.of(context).pushNamed('/booklists');
                              print(data.token);
                            }else{
                              await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text(' some error'),
                                    actions: <Widget>[
                                      FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('OK'))
                                    ],
                                  )
                              );
                            }
                          }else{
                            // for register
                            final data = Register(
                                username: usernameController.text,
                                pass: passwordController.text);

                            final registerResult = await service.RegisterAuth(data);
                            if(registerResult.data != null){
                                Navigator.of(context).pushNamed('/');
                              }else{
                                await showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text(' some error'),
                                      actions: <Widget>[
                                        FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('OK'))
                                      ],
                                    )
                                );
                              }
                            }
                        },
                        child: Text(
                          id ? 'Log In' : 'SignUp',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  id ? 'First Time here? ': 'Already Having Account',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if(id == true){
                        id = false;
                      }else{
                        id = true;
                      }
                    });
                  },
                  child: Text(
                    id ? 'SignUp': "Login",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
