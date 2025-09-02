class LogoutResult {
  final bool isSuccess;
  final String? error;
  final LogoutType type;

  const LogoutResult._(this.isSuccess, this.error, this.type);

  factory LogoutResult.success([LogoutType type = LogoutType.full]) => 
      LogoutResult._(true, null, type);
  
  factory LogoutResult.error(String error, [LogoutType type = LogoutType.localOnly]) => 
      LogoutResult._(false, error, type);

  bool get isError => !isSuccess;
  
  @override
  String toString() {
    if (isSuccess) {
      return 'LogoutResult.success(type: $type)';
    } else {
      return 'LogoutResult.error($error, type: $type)';
    }
  }
}

enum LogoutType {
  full, // Déconnexion complète (locale + serveur)
  localOnly, // Déconnexion locale uniquement
  serverOnly, // Déconnexion serveur uniquement (cas rare)
}