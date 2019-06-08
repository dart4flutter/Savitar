
import 'dart:io';

import 'package:jaguar/jaguar.dart';

class UnauthorizedException implements ExceptionWithResponse {
  final String message;
  const UnauthorizedException(this.message);

  @override
  Response get response =>
      Response(message, statusCode: HttpStatus.unauthorized);

  String toString() => '未认证($message)';

  static const invalidRequest = UnauthorizedException("请求非法!");
  static const notLoggedIn = UnauthorizedException("请先登录!");
  static const subjectNotFound = UnauthorizedException("Subject not found!");
  static const invalidPassword = UnauthorizedException("密码错误!");
}