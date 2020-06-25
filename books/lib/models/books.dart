
class Books {
  int id;
  String title;
  String description;
  int totalRating;
  var avgRating;

  Books({this.id, this.title, this.description, this.totalRating, this.avgRating});

  factory Books.fromJson(Map<String, dynamic> item){
    return  Books(id:item['id'],
        title:item['title'],
        description:item['description'],
        totalRating: item['total_no_rating'],
        avgRating: item['avg_no_rating']);
  }

}