import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/core/exception/auth_exception.dart';
import 'package:todo_list_provider/app/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      if (e.code == 'email-already-in-use') {
        throw AuthException(message: "Email ja cadastrado");
      }
      throw AuthException(
          message: "Email ou senha inválido verifique os dados");
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      throw PlatformException(code: e.message ?? 'Erro ao Logar o usuário');
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      if (e.code == 'invalid-credential') {
        throw AuthException(message: "Email  ou senha inválidos");
      }
      throw AuthException(message: e.message ?? "Erro ao logar o Usuario");
    }
  }

  @override
  Future<void> forgotPassaword(String email) async {
    try {
      //TODO verificar tipo de login que o usario fez
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      AuthException(message: e.message ?? "Erro ao Resetar a senha");
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      AuthException(message: "Erro desconhecido");
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      AuthException(message: "Erro desconhecido");
    }
  }

  @override
  Future<User?> signWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        //todo rever este metodo
        final loginMethods =  await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(message: "Conta não cadastrada com o google");
        } else {
          final authentication = await googleUser.authentication;
          final cred = GoogleAuthProvider.credential(
              accessToken: authentication.accessToken,
              idToken: authentication.idToken
              );
          final userCredencial = await _firebaseAuth.signInWithCredential(cred);
          return userCredencial.user;
        }
      }
      return null;
     } on PlatformException catch (e,s){
        print(e);
        print(s);
        throw AuthException(message: e.message ?? "Erro ao na platforma");
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      switch (e.code) {
        case "provider-already-linked":
          throw AuthException(
              message: "O provedor já foi vinculado ao usuário");
        // print("The provider has already been linked to the user.");
        case "invalid-credential":
          throw AuthException(message: "A credencial do provedor não é válida");
        // print("The provider's credential is not valid.");
        case "credential-already-in-use":
          throw AuthException(
              message:
                  "A conta correspondente à credencial já existe,ou já está vinculado a um usuário do Firebase");
        // print("The account corresponding to the credential already exists,or is already linked to a Firebase User.");
        // See the API reference for the full list of error codes.
        default:
          throw AuthException(message: "Erro Desconhecido");
        //print("Unknown error.");
      }
    }
  }
  
  @override
  Future<void> singOutOfGoogleAcount() async {
     GoogleSignIn().signOut();
     _firebaseAuth.signOut();
  }
  
  @override
  Future<void> updateDisplayName(String name) async {
    final user  =  _firebaseAuth.currentUser;
       if(user != null){
       await  user.updateDisplayName(name);
        await user.reload();
       }
  }
}
