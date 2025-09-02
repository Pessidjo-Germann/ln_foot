import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/keycloak_service.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final Map<String, dynamic> userInfo;

  Authenticated(this.userInfo);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final KeycloakService keycloakService;

  AuthenticationBloc(this.keycloakService) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      await for (final isLoggedIn in keycloakService.authStream) {
        if (isLoggedIn) {
          final info = await keycloakService.getUserInfo();
          emit(Authenticated(info!));
        } else {
          emit(Unauthenticated());
        }
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await keycloakService.login();
      if (success) {
        final info = await keycloakService.getUserInfo();
        emit(Authenticated(info!));
      } else {
        emit(AuthError("Login failed"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await keycloakService.logout();
      emit(Unauthenticated());
    });
  }
}
