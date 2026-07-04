import 'package:quiz_application/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
     super.photo,
     super.score,
  });
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      photo: jsonData['photo'],
      score: jsonData['score'] ?? 0 ,
    );
  }
  Map<String, dynamic> toJson(UserModel model) {
    return {
      'uid': model.id,
      'name': model.name,
      'email': model.email,
      'photo': model.photo,
      'score': model.score ?? 0,
    };
  }
}
