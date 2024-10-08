class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString(){
    return '$_prefix$_message';
  }

}


class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication');
}


class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}


class UnAuthorizeException extends AppException {
  UnAuthorizeException([String? message]) : super(message, 'Unauthorized request');
}


class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid input');
}


class TimeoutException extends AppException {
  TimeoutException([String? message]) : super(message, 'Request time out');
}