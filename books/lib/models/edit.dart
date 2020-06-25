
class EditTexts{
  String title;
  String description;

  EditTexts({this.title, this.description});

  Map<String, dynamic> tooJson(){
    return {
      'title':title,
      'description': description
    };
  }
}