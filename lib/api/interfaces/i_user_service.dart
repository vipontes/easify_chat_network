import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:easify_chat_network/api/error_handler/error_handler.dart';
import 'package:easify_chat_network/model/user.dart';


abstract class IUserService {
  Future<Either<ErrorHandler, List<User>>> getContacts();
}
