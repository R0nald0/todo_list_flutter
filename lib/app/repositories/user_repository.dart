import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
   
   Future<User?> register(String email , String password) ;
   Future<User?> login(String email , String password) ;
   Future <void> forgotPassaword(String email);

   Future<User?> signWithGoogle() ;
   Future<void>  singOutOfGoogleAcount();
   Future<void>  updateDisplayName(String name);
}