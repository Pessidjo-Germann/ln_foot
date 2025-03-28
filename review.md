# Revue de Code - Écrans d'Authentification (lib/screen/)

Ce document résume les modifications apportées aux écrans d'authentification pour améliorer la qualité du code, réduire la duplication et augmenter la maintenabilité.

## Points d'Amélioration Identifiés

1.  **Duplication de la Logique de Validation :**
    *   La validation des e-mails (`_isValidEmail`) est répétée dans `EmailLoginScreen`, `EmailSignupScreen`, et `ForgotPasswordScreen`.
    *   La validation des mots de passe (longueur minimale, confirmation) est présente dans `EmailSignupScreen` et `ResetPasswordScreen`.
2.  **Duplication de Composants UI :**
    *   Le séparateur "Ou" avec les lignes est utilisé dans `LoginOptionsScreen` et `SignupOptionsScreen`.
    *   Le lien de navigation en bas de page (ex: "Vous n'avez pas de compte? Inscrivez-vous") est utilisé dans `LoginOptionsScreen` et `SignupOptionsScreen`.
3.  **Constantes Répétées :**
    *   La couleur `buttonOrange` est définie localement dans plusieurs fichiers (`EmailLoginScreen`, `LoginOptionsScreen`, `OnboardingScreen`, `OtpVerificationScreen`, `SignupOptionsScreen`). Elle devrait être centralisée (thème ou fichier de constantes).
4.  **Incohérence dans l'Utilisation des Widgets Personnalisés :**
    *   `SignupOptionsScreen` utilise `OutlinedButton` et `ElevatedButton` standards au lieu de `CustomButton` utilisé dans `LoginOptionsScreen`.
5.  **Gestion de la Navigation après `showSuccessBottomSheet` :**
    *   Dans `ResetPasswordScreen`, la navigation après la réussite de la réinitialisation du mot de passe est effectuée après l'appel à `showSuccessBottomSheet`, mais devrait logiquement être déclenchée par l'action de l'utilisateur sur le bottom sheet (via le callback).
6.  **Boilerplate des Formulaires :**
    *   La gestion de `_formKey`, `TextEditingController`, `_isPasswordVisible`, `_autovalidate` est standard mais répétitive. (Moins prioritaire à refactoriser pour l'instant, mais à noter).

## Modifications Effectuées

1.  **Centralisation des Validateurs :**
    *   Création du fichier `lib/utils/validators.dart`.
    *   Déplacement et standardisation des fonctions `validateEmail`, `validatePassword`, `validateConfirmPassword`, et `validateOtp`. Ajout d'un validateur générique `validateRequired`.
    *   Mise à jour des écrans `EmailLoginScreen`, `EmailSignupScreen`, `ForgotPasswordScreen`, `OtpVerificationScreen`, et `ResetPasswordScreen` pour utiliser les validateurs de la classe `Validators`.
    *   Suppression des fonctions de validation locales redondantes dans les écrans.
