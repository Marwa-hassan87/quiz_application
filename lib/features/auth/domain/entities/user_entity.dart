import 'dart:io';

class UserEntity {
  final int id;
  final String name;
  final String email;
  final File? photo;
  final int? score;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
     this.photo,  this.score,
  });
}
