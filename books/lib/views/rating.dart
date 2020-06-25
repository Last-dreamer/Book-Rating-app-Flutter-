import 'package:books/models/stars.dart';
import 'package:books/services/book_services.dart';
import 'package:books/views/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';



class Ratings extends StatefulWidget {
  Ratings({@required this.id, @required this.title, @required this.desc,@required this.avgRating, @required this.totalRating});
  String title;
  String desc;
  var avgRating;
  var totalRating;
  int id;

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {


  BookServices get getService => GetIt.I<BookServices>();

  double mStar;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF282c34),
          scaffoldBackgroundColor: Color(0xFF282c34)),
      home: Scaffold(
        appBar: AppBar(
          // for back arrow on top ....
          leading: Navigator.canPop(context) ? IconButton(icon: Icon(Icons.arrow_back, color:Colors.white),
          onPressed: (){ Navigator.of(context).pop();},): null,

          title: Text(widget.title, style:TextStyle(fontSize: 30)),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            FlatButton(
              splashColor: Colors.deepOrange,
                onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder:(_) => Edit(
                    id: widget.id,
                    title: widget.title,
                    desc: widget.desc))),
                child: Text('Edit', style:TextStyle(color:Colors.white, fontSize: 20)))
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height:60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RatingBar(
                    ignoreGestures: true,
                    glowColor: Colors.deepOrange,
                    glowRadius: 55,
                    initialRating: widget.avgRating?? 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                  ),
                  Text('(${widget.totalRating} ratings)', style:TextStyle(color:Colors.white, fontSize: 25))
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(widget.desc,
                    style: TextStyle(color: Colors.white, fontSize: 23)),
              ),

              Divider(
                color: Colors.white,
                height: 100,

              ),

              Container(

                margin: EdgeInsets.only(right:150),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:BorderSide(
                      width: 8,
                      color:Colors.white
                    )
                  )
                ),
                  child: Text('Rate it !!!', style:TextStyle(color: Colors.orange, fontSize: 30))),

              SizedBox(
                height: 50,
              ),
              RatingBar(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 60,
                itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                onRatingUpdate: (rating) {
                  mStar = rating ;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: RaisedButton(
                        padding:EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        color: Colors.orange,
                        splashColor: Colors.deepOrange,
                        onPressed: () async {
                          final star = Stars(stars: mStar.toInt());
                           final result = await getService.sendStar(star,widget.id);

                           final mtitle = 'Done';
                           final mcontent = result.error ? result.message ?? 'asdf' : 'created ..';

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
                                Navigator.of(context).pop()
                              }
                           });

                        },
                        child: Text('Rate',
                            style: TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
