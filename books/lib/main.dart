import 'package:books/generate_route.dart';
import 'package:books/services/book_services.dart';
import 'package:books/views/edit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'views/book_lists.dart';

// Get_It  to load just once instance....
void setUpLocator(){
 GetIt.I.registerLazySingleton(() => BookServices());
}


void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Color(0xFF282c34),
       scaffoldBackgroundColor: Color(0xFF282c34)
      ),

      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      );
  }
}
