
class Stars{
  int stars;

  Stars({this.stars});

  Map<String , dynamic> toJson() {
   return {
     'stars': stars
   };
  }


}