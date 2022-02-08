class HttpException implements Exception {
  final _message;

  HttpException([this._message]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException(String message)
      : super(message);
}

class BadRequestException extends HttpException {
  BadRequestException([message]) : super(message);
}

class ValidationException extends HttpException {
  ValidationException([message]) : super(message);
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends HttpException {
  InvalidInputException(String message) : super(message);
}

class AlreadySyncedException extends HttpException {
  AlreadySyncedException(String message) : super(message);
}

class DataParseException extends HttpException {
  DataParseException(String message) : super(message);
}
