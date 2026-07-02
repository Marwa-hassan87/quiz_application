import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_application/core/error/exception.dart';
import 'package:quiz_application/features/auth/data/models/auth_model.dart';
import 'package:quiz_application/features/auth/data/models/signup_model.dart';

abstract class AuthRemoteDatasource {
  Future<Unit> login({required String email, required String password});
  Future<AuthModel> signUp(SignupModel model);
  Future<Unit> logout();
  Future<Unit> createUser(AuthModel model);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;
  @override
  Future<Unit> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> logout() async{
    try{
      await _auth.signOut();
      return unit;
    }catch(e){
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> signUp(SignupModel model) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      return AuthModel(id: credential.user!.uid as int, name: model.name, email: model.email);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createUser(AuthModel model) async {
    try {
      await _firestore
          .collection('userData')
          .doc(model.id.toString())
          .set(model.toJson(model));
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }
}
