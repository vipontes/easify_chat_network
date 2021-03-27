import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easify_chat_network/constants/api_constants.dart';
import 'package:easify_chat_network/utils/jwt_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    if (options.headers.containsKey(ApiConstants.requiresToken)) {
      options.headers.remove(ApiConstants.requiresToken);

      final prefs = await SharedPreferences.getInstance();

      var token = prefs.get(ApiConstants.token);
      final tokenDecoded = JwtHelper.parseJwt(token);
      var expiresAt = tokenDecoded[ApiConstants.expiresAt];

      DateTime parsedDate =
          DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
      final now = DateTime.now();
      var difference = parsedDate.difference(now).inSeconds;
      if (difference > 0) {
        options.headers.addAll({"Authorization": "Bearer $token"});
      } else {
        final refreshToken = prefs.get(ApiConstants.refreshToken);
        final refreshTokenDecoded = JwtHelper.parseJwt(refreshToken);
        expiresAt = refreshTokenDecoded[ApiConstants.expiresAt];
        parsedDate = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
        difference = parsedDate.difference(now).inSeconds;
        if (difference > 0) {
          // LoginService().refreshToken(refreshToken).then((res) async {
          //   var decodedResponse = res.fold((error) => error, (val) => val);
          //   if (decodedResponse is Usuario) {
          //     await LoginService().saveLocalUser(decodedResponse, blockDefined);
          //     token = decodedResponse.usuarioToken;
          //     options.headers.addAll({"Authorization": "Bearer $token"});
          //   } else {
          //     await LoginService().logout();
          //     navigatorKey.currentState.pushNamedAndRemoveUntil(
          //         Routes.login, (Route<dynamic> route) => false);
          //   }
          // });
        }
      }
    }

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}
