
import 'package:Savitar/util/exception.dart';
import 'package:jaguar_auth/hasher/hasher.dart';


import 'package:jaguar/jaguar.dart';

/// An [Authenticator] for standard username password form style login.
/// It expects a `application/x-www-form-urlencoded` encoded body where the
/// username and password form fields must be called `username` and `password`
/// respectively.
///
/// Arguments:
/// It uses [userFetcher] to fetch user model for the authentication request
/// and authenticate against the password
///
/// Outputs ans Variables:
/// The authenticated user model is injected into the context as input
class FormAuth<UserModel extends PasswordUser>
    implements Interceptor<UserModel> {
  /// Model manager is used to fetch user model for the authentication request
  /// and authenticate against the password
  final UserFetcher<UserModel> userFetcher;

  final Hasher hasher;

  /// The key by which authorizationId shall be stored in session data
  final String authorizationIdKey;

  /// Specifies whether the interceptor should create/update the session data
  /// on authentication success.
  ///
  /// If set to false, session creation and update must be done manually
  final bool manageSession;

  const FormAuth(
      {this.userFetcher,
        this.authorizationIdKey: 'username',
        this.manageSession: true,
        this.hasher: const NoHasher()});

  /// Parses the session from request, fetches the user model and authenticates
  /// it against the password.
  ///
  /// On successful login, injects authenticated user model as context input and
  /// session manager as context variable.
  Future<UserModel> call(Context ctx) async {
    Map<String, String> form = await ctx.bodyAsUrlEncodedForm();

    if (form is! Map<String, String>)
      throw UnauthorizedException.invalidRequest;

    final String username = form['username'];
    final String password = form['password'] ?? '';

    if (username == null) throw UnauthorizedException.invalidRequest;

    UserFetcher<UserModel> fetcher = userFetcher ?? ctx.userFetchers[UserModel];
    final subject = await fetcher.byAuthenticationId(ctx, username);

    if (subject == null) throw UnauthorizedException.subjectNotFound;

    if (!hasher.verify(subject.password, password))
      throw UnauthorizedException.invalidPassword;

    if (manageSession is bool && manageSession) {
      final Session session = await ctx.session;
      // Invalidate old session data
      session.clear();
      // Add new session data
      session.addAll(
          <String, String>{authorizationIdKey: subject.authorizationId});
    }

    ctx.addVariable(subject);
    return subject;
  }

  static Future<UserModel> authenticate<UserModel extends PasswordUser>(
      Context ctx,
      {UserFetcher<UserModel> userFetcher,
        String authorizationIdKey: 'username',
        bool manageSession: true,
        Hasher hasher: const NoHasher()}) async {
    await FormAuth<UserModel>(
        userFetcher: userFetcher,
        authorizationIdKey: authorizationIdKey,
        manageSession: manageSession,
        hasher: hasher)
        .call(ctx);
    return ctx.getVariable<UserModel>();
  }
}
