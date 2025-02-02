

class UserDm{
  static  UserDm? currentUser;
  static const String collectionName = 'user';
  String id;
  String fullName;
  String userName;
  String email;
  UserDm({required this.email, required this.fullName , required this.userName,required this.id});
  Map<String, dynamic> toFireStore() =>
      {
        'id' : id,
        'fullName' :fullName,
        'userName' : userName,
        'email' :email,
      };
  UserDm.fromFireStore(Map<String,dynamic>data) : this(
    id: data['id'],
    fullName: data['fullName'],
    userName: data['userName'],
    email: data['email']
  );
}