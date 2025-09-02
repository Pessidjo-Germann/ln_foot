class ErrorMessages {
  static const String loginFailed =
      'Échec de la connexion. Veuillez réessayer.';
  static const String userInfoLoadFailed =
      'Impossible de charger vos informations. Veuillez réessayer.';
  static const String tokenError =
      'Votre session a expiré. Veuillez vous reconnecter.';
  static const String networkError =
      'Erreur de connexion au réseau. Veuillez vérifier votre connexion internet.';
  static const String unknownError =
      'Une erreur inattendue est survenue. Veuillez réessayer.';

  // Messages d'erreur pour les commandes
  static const String orderCreateFailed =
      'Impossible de créer votre commande. Veuillez réessayer.';
  static const String orderUpdateFailed =
      'La mise à jour de votre commande a échoué. Veuillez réessayer.';
  static const String orderDeleteFailed =
      'La suppression de votre commande a échoué. Veuillez réessayer.';
  static const String orderLoadFailed =
      'Impossible de charger les détails de votre commande. Veuillez réessayer.';

  // Messages d'erreur pour les produits
  static const String productLoadFailed =
      'Impossible de charger les produits. Veuillez réessayer.';
  static const String productDetailsFailed =
      'Impossible de charger les détails du produit. Veuillez réessayer.';
  static const String productUpdateFailed =
      'La mise à jour du produit a échoué. Veuillez réessayer.';
}
