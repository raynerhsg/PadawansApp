class TodosDTO {
  int userId;
  int id;
  String title;
  bool completed;

  TodosDTO({this.userId, this.id, this.title, this.completed});

  TodosDTO.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
}