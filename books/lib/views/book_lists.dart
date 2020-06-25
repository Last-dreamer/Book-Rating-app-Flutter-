import 'package:books/models/api_services.dart';
import 'package:books/services/book_services.dart';
import 'package:books/views/bookDialog.dart';
import 'package:books/views/edit.dart';
import 'package:books/views/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:books/models/books.dart';
import 'package:get_it/get_it.dart';

class BookLists extends StatefulWidget {
  @override
  _BookListsState createState() => _BookListsState();
}

class _BookListsState extends State<BookLists> {

  BookServices get service => GetIt.I<BookServices>();

  APIResponse<List<Books>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchBooks();
    super.initState();
  }

  _fetchBooks() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNoteslists();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Lists',
        style: TextStyle(color: Colors.orange, fontStyle: FontStyle.italic),),
        actions: <Widget>[
          FlatButton(onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => Edit()));
          },
              child: Text(
                'Add', style: TextStyle(color: Colors.orange, fontSize: 23),))
        ],
      ),
      body: Column(
        children: <Widget>[
          Image.asset('images/logo.png', width: 300, height: 100),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Builder(
                builder: (_) {
                  if (_isLoading) {
                    return CircularProgressIndicator();
                  }

                  if (_apiResponse.error) {
                    return Center(
                      child: Text(_apiResponse.message),
                    );
                  }

                  return ListView.separated(
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: Colors.transparent),
                      itemBuilder: (_, index) {
                        return Card(
                          shadowColor: Colors.white.withOpacity(0.5),
                          color: Color(0xFF282c34),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 4, color: Colors.orange),
                              ),
                            ),
                            child: InkWell(
                              onTap: () =>
                              {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder:
                                      (_) =>
                                      Ratings(id: _apiResponse.data[index].id,
                                        title: _apiResponse.data[index].title,
                                        desc: _apiResponse.data[index]
                                            .description,
                                        totalRating: _apiResponse.data[index]
                                            .totalRating,
                                        avgRating: _apiResponse.data[index]
                                            .avgRating,
                                      )
                                  ),).then((_) {
                                    // if call on back to fetch data again...
                                  _fetchBooks();
                                })
                              },
                              splashColor: Colors.white.withOpacity(0.3),
                              child: Dismissible(
                                key: ValueKey(_apiResponse.data[index].id),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {},
                                confirmDismiss: (direction) async {
                                  final result = await showDialog(
                                      context: context,
                                      builder: (_) => BookDialog());

                                  if(result){
                                    var dataResult  = await service.DeleteBook(_apiResponse.data[index].id);
                                    var message;
                                    if(dataResult.data = true && dataResult != null){
                                      message = 'deleted';
                                    }else{
                                      message ="some error may be ";
                                    }

                                    showDialog(
                                        context: context, builder: (_) => CupertinoAlertDialog(
                                        title:Text("Done"),
                                        content: Text(message),
                                        actions: <Widget>[
                                          FlatButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text('Ok'))
                                        ]
                                      ));
                                      return dataResult?.data ?? false;
                                  }
                                  return result;
                                },
                                background: Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    child: Icon(
                                        Icons.delete, color: Colors.white),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(_apiResponse.data[index].title,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(1))),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _apiResponse.data.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

