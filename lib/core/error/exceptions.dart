class ServerException implements Exception {
  final String error;
  const ServerException({required this.error});
}
