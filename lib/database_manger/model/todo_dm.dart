class TodoDm {
  static  TodoDm? currentUser;
  static String collectionName = 'todo';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TodoDm(
      {required this.title, required this.id, required this.dateTime, required this.description, required this.isDone});

  Map<String, dynamic> toFireStore() =>
      {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime,
        'IsDone': isDone,
      };

  TodoDm.fromFireStore(Map<String, dynamic> data) :this(
    id: data['id'],
    title: data['title'],
    description: data['description'],
    dateTime: data['dateTime'].toDate(),
    isDone: data['IsDone'],
  );
  Map<String, dynamic> upDateFireStore(String id) =>
      {
        'id': id,
        'title': title,
        'description':description,
        'dateTime': dateTime,
        'IsDone': isDone,
      };
}