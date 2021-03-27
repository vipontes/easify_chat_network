import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easify_chat_network/model/user.dart';
import '../constants/api_constants.dart';
import 'error_handler/error_handler.dart';
import 'interceptor/app_interceptors.dart';
import 'interfaces/i_user_service.dart';

class UserService implements IUserService {
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

  static final UserService _singleton = new UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal() {
    addInterceptors(dio);
  }

  @override
  Future<Either<ErrorHandler, List<User>>> getContacts() async {
    Options options = Options(headers: {
      ApiConstants.requiresToken: true,
    });

    try {
      Response response = await dio.get("/user/contacts", options: options);

      if (response.statusCode == 200) {
        List<User> users = User.listFromJson(response.data);
        return Right(users);
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
