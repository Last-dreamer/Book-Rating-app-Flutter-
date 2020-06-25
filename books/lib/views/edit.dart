import 'package:books/main.dart';
import 'package:books/models/edit.dart';
import 'package:books/services/book_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';


class Edit extends StatefulWidget {

  Edit({this.id,this.title,this.desc});

  String title;
  String desc;
  int id;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

  TextEditingController mController = new TextEditingController();
  TextEditingController mController2 = new TextEditingController();

  BookServices get service => GetIt.I<BookServices>();

  bool get mId => widget.id != null;


  @override
  void initState() {

    if(mId) {
      mController.text = widget.title;
      mController2.text = widget.desc;
    }
   print(mId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF282c34),
            scaffoldBackgroundColor: Color(0xFF282c34)
        ),
      home: Scaffold(
        body: Column(
           children: <Widget>[
              Padding(
                padding:EdgeInsets.all(20)
              ),
              Expanded(
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(Icons.arrow_back, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                  Text(mId ? 'Edit Page': 'Add a Book', style:Theme.of(context).accentTextTheme.headline3),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              style: TextStyle(color: Colors.white,  fontSize: 25),
                              controller: mController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange, width: 1),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Title',
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.transparent,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  // mController.text  = text;
                                });
                              },
                            )),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              style: TextStyle(color: Colors.white, fontSize: 23),
                              controller: mController2,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange, width: 1),
                                ),
                                filled: true,
                                //   border: OutlineInputBorder(),
                                labelText: 'Description',
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.transparent,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  //  mController2.text = text;
                                });
                              },
                            )),
                      ),
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: RaisedButton(
                              color: Colors.orange,
                              padding:EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                              splashColor: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              onPressed: () async {
                                final data = EditTexts(title:mController.text, description:mController2.text);
                                var result = null;
                                if(mId){
                                  result = await service.Update(data, widget.id??0);
                                }else{
                                  result = await service.Insert(data);
                                }
                                final mtitle = mId ? 'Update': 'Insert';
                                final mcontent = result.error ? result.message ?? 'asdf' : 'Updated ..';

                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(mtitle),
                                      content: Text(mcontent),
                                      actions: <Widget>[
                                        FlatButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text('Ok'))
                                      ],

                                    )
                                ).then((value) => {
                                  if(result.data){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyApp()))
                                  }
                                });

                              }, child: Text(mId ? 'Update': 'Add', style: TextStyle(color: Colors.white, fontSize: 30),),),
                          )
                      ),
                    ],
                  )

                ],),
              ),
           ],
          ),
      ),
    );

  }
}
