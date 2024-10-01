class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class NetworkException implements Exception {
  final String message;
  final String? responseStatusErrorText;

  NetworkException(this.message, {this.responseStatusErrorText});
}

class NotFoundException implements Exception {
  final String message;
  final String? responseStatusErrorText;

  NotFoundException(this.message, {this.responseStatusErrorText});
}

class AlreadyExistException implements Exception {
  final String message;
  final String? responseStatusErrorText;

  AlreadyExistException(this.message, {this.responseStatusErrorText});
}

class InvalidPhoneException implements Exception {
  final String message;
  InvalidPhoneException(this.message);
}

class LoginException implements Exception {
  final String message;
  LoginException(this.message);
}

class HealthCheckException implements Exception {
  final String message;
  HealthCheckException(this.message);
}

class DuplicateDataException implements Exception {
  final String message;
  DuplicateDataException(this.message);
}
