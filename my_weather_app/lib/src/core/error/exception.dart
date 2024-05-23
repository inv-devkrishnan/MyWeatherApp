import 'package:flutter/material.dart';

class ServerException implements Exception {
  final Object exception;
  ServerException(this.exception);
  @override
  String toString() {
    debugPrint(exception.toString());
    return "An unexpected error occured";
  }
}
