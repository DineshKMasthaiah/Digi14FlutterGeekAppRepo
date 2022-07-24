///Define local application error codes here and use them everywhere in the code including
///printing in the logging statements and showing in the error dialog when app is running in debug mode.
///This class is a central place to edit and manage the errors
class GELocalErrorCodes {
  static ErrorCode errorInParsingJson = ErrorCode(-1, "JSON parsing error");
}

class ErrorCode {
  int code = 0;
  String message = "unknown";

  ErrorCode(this.code, this.message);
}
