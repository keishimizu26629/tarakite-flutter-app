import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarakite/infrastructure/authRepository.dart';
import 'package:tarakite/infrastructure/userRepository.dart';
import 'package:tarakite/domain/entity/user.dart';
import '../presentation_provider.dart';
import '../../domain/interfaces/i_auth_repository.dart';

final signUpViewModelProvider = Provider<SignUpViewModel>((ref) {
  return SignUpViewModel(
    ref: ref,
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  );
});

class SignUpViewModel {
  final ProviderRef ref;
  final IauthRepository _authRepository;
  final UserRepository _userRepository;

  SignUpViewModel({
    required ref,
    required authRepository,
    required userRepository,
  })  : ref = ref,
        _authRepository = authRepository,
        _userRepository = userRepository;

  TextEditingController get userNameController =>
      ref.read(userNameControllerStateProvider.state).state;

  TextEditingController get emailAddressController =>
      ref.read(emailAddressControllerStateProvider.state).state;

  TextEditingController get dateOfBirthController =>
      ref.read(dateOfBirthControllerStateProvider.state).state;

  TextEditingController get passwordController =>
      ref.read(passwordControllerStateProvider.state).state;

  Future<void> signUp() async {
    if (emailAddressController.text.isEmpty) {
      throw 'メールアドレスを入力してください';
    }
    if (passwordController.text.isEmpty) {
      throw 'パスワードを入力してください';
    }
    await _authRepository.signUp(
        email: emailAddressController.text, password: passwordController.text);
    final uid = _authRepository.getUid();
    await _userRepository.create(
      user: User(
        id: uid!,
        email: emailAddressController.text,
        name: userNameController.text,
        dateOfBirth: dateOfBirthController.text
      )
    );
    userNameController.text = '';
    emailAddressController.text = '';
    dateOfBirthController.text = '';
    passwordController.text = '';
  }
}
