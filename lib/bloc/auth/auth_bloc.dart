import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ln_foot/service.dart';

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
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
      // Ensuite, écoute du flux pour les changements dynamiques
      await for (final isLoggedIn in authService.authStream) {
        if (isLoggedIn) {
          final user = await authService.getUserInfo();
          emit(Authenticated(user!));
        } else {
          emit(Unauthenticated());
        }
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final success = await authService.login();
      if (success) {
        final user = await authService.getUserInfo();
        emit(Authenticated(user!));
      } else {
        emit(AuthError('Login failed'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authService.logout();
      emit(Unauthenticated());
    });

    on<CheckToken>((event, emit) async {
      emit(AuthLoading());
      final token = await authService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthenticatedWithToken(token));
      } else {
        emit(Unauthenticated());
      }
    });

    on<CheckTokenStored>((event, emit) async {
      emit(AuthLoading());
      final isLoggedIn = await authService.isLoggedIn();
      if (isLoggedIn) {
        emit(Authenticated(
            {})); // On ne charge pas l'utilisateur, juste l'état connecté
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
