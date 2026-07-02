import 'dart:io';

class AuthEntity {
  final int id;
  final String name;
  final String email;
  final File? photo;
  final int? score;

  AuthEntity({
    required this.id,
    required this.name,
    required this.email,
     this.photo,  this.score,
  });
}
