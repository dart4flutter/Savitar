import 'dart:async';
import 'package:Savitar/entity/user.dart';
import 'package:jaguar/jaguar.dart';


class DummyUserFetcher implements UserFetcher<User> {
  final UserBean userBean;

  const DummyUserFetcher(UserBean userBean,)
      : userBean = userBean ;

//身份验证
  Future<User> byAuthenticationId(Context ctx, String authenticationId) async =>
      await userBean.findOneWhere(userBean.username.eq(authenticationId));

//授权书
  Future<User> byAuthorizationId(Context ctx, String sessionId) async =>
      await userBean.findOneWhere(userBean.username.eq(sessionId));
}