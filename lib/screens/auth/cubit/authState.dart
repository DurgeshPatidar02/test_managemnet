abstract class AuthStates{}

class AuthInitial extends AuthStates{}
class AuthLoading extends AuthStates{}
class AuthSuccess extends AuthStates{
  final UserId;
  AuthSuccess({required this.UserId});
}
class AuthError extends AuthStates{
  String msg;
  AuthError({required this.msg});
}

class LogOutSuccess extends AuthStates{}
class LogOutError extends AuthStates{
  String msg;
  LogOutError({required this.msg});
}
class LogInSuccess extends AuthStates{
  final UserId;
  LogInSuccess({required this.UserId});
}
class LogInError extends AuthStates{
  String msg;
  LogInError({required this.msg});
}
class NoUserFound extends AuthStates{}

