import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easify_chat_network/model/user.dart';
import '../constants/api_constants.dart';
import 'error_handler/error_handler.dart';
import 'interceptor/app_interceptors.dart';
import 'interfaces/i_login_service.dart';

class LoginService implements ILoginService {
  Dio dio = new Dio(
    new BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      validateStatus: (status) {
        return status <= 500;
      },
    ),
  );

  Dio addInterceptors(Dio dio) {
    dio.interceptors.add(AppInterceptors());
  }

  static final LoginService _singleton = new LoginService._internal();

  factory LoginService() {
    return _singleton;
  }

  LoginService._internal() {
    addInterceptors(dio);
  }

  @override
  Future<Either<ErrorHandler, User>> login(
      String userEmail, String userPassword) async {
    try {
      Response response = await dio.post("/login",
          data: {'userPhone': userEmail, 'userPass': userPassword});

      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        return Right(user);
      } else {
        final Map<String, dynamic> decodedMessage =
            json.decode(response.toString());

        return Left(
            ErrorHandler(response.statusCode, decodedMessage['message']));
      }
    } on DioError catch (error) {
      return Left(ErrorHandler(500, error.message));
    }
  }
}
