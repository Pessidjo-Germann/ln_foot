import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart'; // For HeadingControllerApi and HeadingDto

part 'heading_event.dart';
part 'heading_state.dart';

class HeadingBloc extends Bloc<HeadingEvent, HeadingState> {
  final HeadingControllerApi _headingControllerApi;
  List<HeadingDto> _cachedHeadings = [];
  DateTime? _lastFetchTime;
  static const Duration _cacheExpiration = Duration(minutes: 5);

  HeadingBloc({required HeadingControllerApi headingControllerApi})
      : _headingControllerApi = headingControllerApi,
        super(HeadingInitial()) {
    on<LoadHeadings>(_onLoadHeadings);
  }

  Future<void> _onLoadHeadings(
      LoadHeadings event, Emitter<HeadingState> emit) async {
    final now = DateTime.now();
    final isCacheExpired = _lastFetchTime == null || 
        now.difference(_lastFetchTime!) > _cacheExpiration;
        
    // Utiliser le cache si : pas de forceRefresh ET cache non vide ET cache non expiré
    if (!event.forceRefresh && _cachedHeadings.isNotEmpty && !isCacheExpired) {
      emit(HeadingsLoaded(_cachedHeadings));
      return;
    }

    emit(HeadingLoading());
    try {
      final headings = await _headingControllerApi.getHeadings();
      _cachedHeadings = headings ?? [];
      _lastFetchTime = now; // Mettre à jour le timestamp du cache
      emit(HeadingsLoaded(_cachedHeadings));
    } on ApiException catch (e) {
      emit(HeadingError(e.message ?? 'API Error fetching headings'));
    } catch (e) {
      emit(HeadingError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
