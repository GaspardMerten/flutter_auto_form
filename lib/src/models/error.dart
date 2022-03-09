class SubmitException implements Exception {
  SubmitException(this.errorMessage);

  final String errorMessage;
}
