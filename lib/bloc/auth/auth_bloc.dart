import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ln_foot/service.dart';
import 'package:ln_foot/constants/error_messages.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      // Vérification immédiate du token
      final token = await authService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final user = await authService.getUserInfo();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          // Si le token est présent mais les infos utilisateur ne peuvent pas être chargées
          emit(AuthError(ErrorMessages.userInfoLoadFailed));
          await authService
              .logout(); // Forcer la déconnexion si les infos utilisateur ne peuvent pas être chargées
        }
      } else {
        emit(Unauthenticated());
      }

      // Ensuite, écoute du flux pour les changements dynamiques
      await for (final isLoggedIn in authService.authStream) {
        if (isLoggedIn) {
          final user = await authService.getUserInfo();
          if (user != null) {
            emit(Authenticated(user));
          } else {
            // Si le stream dit connecté mais qu'on ne peut pas avoir l'utilisateur
            emit(AuthError(ErrorMessages.userInfoLoadFailed));
            await authService.logout(); // Gérer ce cas comme une déconnexion
          }
        } else {
          // C'est ici qu'on gère la déconnexion provenant de KeycloakWrapper ou d'un appel à logout
          emit(Unauthenticated()); // <-- IMPORTANT : Émettre Unauthenticated
        }
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authService.login();
      if (success) {
        final user = await authService.getUserInfo();
        print("result $user");
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError(ErrorMessages.userInfoLoadFailed));
          await authService
              .logout(); // Si le login réussit mais pas les infos user
        }
      } else {
        emit(AuthError(ErrorMessages.loginFailed));
      }
    });

    on<LogoutRequested>((event, emit) async {
    await authService.logout();
      emit(
          Unauthenticated()); // L'état Unauthenticated sera émis ici et via le stream
    });

    on<CheckToken>((event, emit) async {
      emit(AuthLoading());
      final token = await authService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthenticatedWithToken(token));
      } else {
        emit(AuthError(ErrorMessages.tokenError));
      }
    });

    on<CheckTokenStored>((event, emit) async {
      emit(AuthLoading());
      final isLoggedIn = await authService.isLoggedIn();
      if (isLoggedIn) {
        // Idéalement, charger les infos user ici ou avoir un AuthState.authenticated avec user info.
        // Pour l'instant, on suppose que si isLoggedIn est vrai, on est connecté.
        // Si tu veux vraiment charger les infos user, tu peux le faire ici:
        final user = await authService.getUserInfo();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError(ErrorMessages.userInfoLoadFailed));
          await authService
              .logout(); // Déconnexion si le token est là mais pas les infos user
        }
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
