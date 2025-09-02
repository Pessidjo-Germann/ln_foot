import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ln_foot/service.dart';
import 'package:ln_foot/constants/error_messages.dart';
import 'package:ln_foot/model/logout_result.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  StreamSubscription<bool>? _authStreamSubscription;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckToken>(_onCheckToken);
    on<CheckTokenStored>(_onCheckTokenStored);
    on<_AuthStreamChanged>(_onAuthStreamChanged); // Nouvel événement interne

    // Écouter le stream d'authentification
    _startListeningToAuthStream();
  }

  void _startListeningToAuthStream() {
    _authStreamSubscription = authService.authStream.listen(
      (isLoggedIn) => add(_AuthStreamChanged(isLoggedIn)),
    );
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    try {
      // Vérifier d'abord si on a un token valide stocké
      if (await authService.isTokenValid()) {
        final user = await authService.getUserInfo();
        if (user != null) {
          emit(Authenticated(user));
          return;
        }
      }
      
      // Tenter un refresh si on a un refresh token
      if (await authService.refreshTokenIfNeeded()) {
        final user = await authService.getUserInfo();
        if (user != null) {
          emit(Authenticated(user));
          return;
        }
      }
      
      // Aucune authentification valide trouvée
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Erreur lors de l\'initialisation: $e'));
    }
  }

  // Simplifier la gestion des changements de stream
  Future<void> _onAuthStreamChanged(
      _AuthStreamChanged event, Emitter<AuthState> emit) async {
    if (!event.isLoggedIn) {
      emit(Unauthenticated());
      return;
    }
    
    try {
      final user = await authService.getUserInfo();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError(ErrorMessages.userInfoLoadFailed));
        await authService.logout();
      }
    } catch (e) {
      emit(AuthError('Erreur lors de la récupération des informations utilisateur: $e'));
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final success = await authService.login();
    if (success) {
      final user = await authService.getUserInfo();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError(ErrorMessages.userInfoLoadFailed));
        await authService.logout();
      }
    } else {
      emit(AuthError(ErrorMessages.loginFailed));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoggingOut());
    
    try {
      final result = await authService.logout();
      
      if (result.isSuccess) {
        // Déconnexion réussie
        if (result.type == LogoutType.localOnly) {
          // Informer que la déconnexion était locale uniquement
          emit(Unauthenticated());
          // Optionnellement, vous pourriez émettre un événement différent
          // pour indiquer que c'était une déconnexion locale
        } else {
          emit(Unauthenticated());
        }
      } else {
        // Échec de la déconnexion - mais nettoyer quand même
        emit(AuthError('Déconnexion partielle: ${result.error}'));
        // Après un délai court, passer à Unauthenticated pour forcer la déconnexion
        await Future.delayed(const Duration(seconds: 2));
        emit(Unauthenticated());
      }
    } catch (e) {
      // Erreur critique - forcer la déconnexion
      emit(AuthError('Erreur critique lors de la déconnexion: $e'));
      await Future.delayed(const Duration(seconds: 2));
      emit(Unauthenticated());
    }
  }

  Future<void> _onCheckToken(CheckToken event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final token = await authService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      emit(AuthenticatedWithToken(token));
    } else {
      emit(AuthError(ErrorMessages.tokenError));
    }
  }

  Future<void> _onCheckTokenStored(
      CheckTokenStored event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final isLoggedIn = await authService.isLoggedIn();
    if (isLoggedIn) {
      final user = await authService.getUserInfo();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError(ErrorMessages.userInfoLoadFailed));
        await authService.logout();
      }
    } else {
      emit(Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authStreamSubscription?.cancel();
    return super.close();
  }
}

// Nouvel événement interne pour gérer les changements du stream
class _AuthStreamChanged extends AuthEvent {
  final bool isLoggedIn;

  _AuthStreamChanged(this.isLoggedIn);

  @override
  List<Object?> get props => [isLoggedIn];
}
