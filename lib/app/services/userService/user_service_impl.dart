
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_provider/app/repositories/user_repository.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({
    required UserRepository userRepository
  }):_userRepository = userRepository;
  
  
  @override
  Future<User?> register(String email, String password)=> _userRepository.register(email, password);
  
  @override
  Future<User?> login(String email, String password) => _userRepository.login(email, password);
  
  @override
  Future<void> forgotPassword(String email) => _userRepository.forgotPassaword(email);
  
  @override
  Future<User?> signInWithGoogle() => _userRepository.signWithGoogle();
  
  @override
  Future<void> logout() => _userRepository.singOutOfGoogleAcount();
  
  @override
  Future<void> updateName(String name) => _userRepository.updateDisplayName(name);
}
