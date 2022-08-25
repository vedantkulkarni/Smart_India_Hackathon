part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class Authenticated extends AuthState {}
class SignOut extends AuthState {}
class CredentialsNotCorrect extends AuthState {}
