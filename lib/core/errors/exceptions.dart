class OfflineException implements Exception {
  
}

class ServerException implements Exception {
  
}

class EmptyCacheException implements Exception {
  
}

class DataBaseException implements Exception {
  
}

class GlobalException implements Exception{
  final String message;
  GlobalException({this.message = ''});
}
