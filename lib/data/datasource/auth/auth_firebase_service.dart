import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spotify_application_1/data/model/auth/create_user_request.dart';
import 'package:flutter_spotify_application_1/data/model/auth/signin_user_req.dart';
import 'package:flutter_spotify_application_1/data/model/auth/user.dart';
import 'package:flutter_spotify_application_1/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> getUser();
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String itemId);
  Future<void> removeFavorite(String itemId);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      return right('Sign in was successful');
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-email') {
        message = 'No user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      } else {
        message = e.message ?? 'Sign in failed due to an unknown error.';
      }
      return left(message);
    } catch (e) {
      return left('Sign in error: ${e.toString()}');
    }
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user?.uid)
          .set({
            'name': createUserRequest.fullName,
            'email': data.user?.email,
            'favorites': [], // Initialize empty favorites list
          });
      return right('Sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'Password provided is too weak at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with this email';
      } else {
        message = e.message ?? 'Signup failed due to an unknown error.';
      }
      return left(message);
    } catch (e) {
      return left('Sign up error: \${e.toString()}');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data() ?? {});
      UserEntity userEntity = userModel.toEntity();
      return right(userEntity);
    } catch (e) {
      return left('Get user error: ${e.toString()}');
    }
  }

  Future<List<String>> getFavorites() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not signed in");
    final doc = await firebaseFirestore.collection('Users').doc(userId).get();
    final data = doc.data();
    if (data == null) return [];
    return List<String>.from(data['favorites'] ?? []);
  }

  Future<void> addFavorite(String itemId) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not signed in");
    final userRef = firebaseFirestore.collection('Users').doc(userId);
    await userRef.update({
      'favorites': FieldValue.arrayUnion([itemId]),
    });
  }

  Future<void> removeFavorite(String itemId) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not signed in");
    final userRef = firebaseFirestore.collection('Users').doc(userId);
    await userRef.update({
      'favorites': FieldValue.arrayRemove([itemId]),
    });
  }
}
