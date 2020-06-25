import 'package:books/views/book_lists.dart';
import 'package:books/views/login.dart';
import 'package:books/views/rating.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class RouteGenerator{

  static Route<dynamic>  generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/booklists':
        return MaterialPageRoute(builder: (_) => BookLists());
      case '/rating':
        return MaterialPageRoute(builder: (_) =>
            Ratings(id: args,
                title: args,
                desc: args,
                avgRating: args,
                totalRating: args)
        );
    default:
    return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder:(_) {
      return Scaffold(
          body:Center(child:Text('Route not fount !!...'),)
      );
    });
  }
}