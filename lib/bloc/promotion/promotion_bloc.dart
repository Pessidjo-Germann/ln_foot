import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart'; // Import depuis le package API lnFoot_api
import 'package:meta/meta.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  // Injection DIRECTE du contrôleur API
  final PromotionControllerApi promotionControllerApi;

  PromotionBloc({required this.promotionControllerApi})
      : super(PromotionInitial()) {
    on<LoadAllPromotions>(_onLoadAllPromotions);
    on<LoadPromotionById>(_onLoadPromotionById);
    on<CreatePromotion>(_onCreatePromotion);
    on<CreatePromotions>(_onCreatePromotions); // Ajout du handler pour le batch
    on<UpdatePromotion>(_onUpdatePromotion);
    on<DeletePromotion>(_onDeletePromotion);
  }

  Future<void> _onLoadAllPromotions(
      LoadAllPromotions event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      final promotions = await promotionControllerApi.getAllPromotions();
      emit(PromotionsLoaded(promotions ?? []));
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadPromotionById(
      LoadPromotionById event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      final promotion =
          await promotionControllerApi.getPromotionById(event.promotionId);
      if (promotion != null) {
        emit(PromotionLoaded(promotion));
      } else {
        emit(const PromotionError('Promotion not found.'));
      }
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreatePromotion(
      CreatePromotion event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      final createdPromotion =
          await promotionControllerApi.createPromotion(event.promotionData);
      if (createdPromotion != null) {
        emit(PromotionCreated(createdPromotion));
        // Optionnel: Recharger toutes les promotions après création
        // add(LoadAllPromotions());
      } else {
        emit(const PromotionError('Promotion creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreatePromotions(
      CreatePromotions event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      final createdPromotions =
          await promotionControllerApi.createPromotions(event.promotionsData);
      if (createdPromotions != null) {
        emit(PromotionsCreated(createdPromotions));
        // Optionnel: Recharger toutes les promotions après création en batch
        // add(LoadAllPromotions());
      } else {
        emit(const PromotionError('Batch promotion creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdatePromotion(
      UpdatePromotion event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      final updatedPromotion = await promotionControllerApi.updatePromotion(
          event.promotionId, event.promotionData);
      if (updatedPromotion != null) {
        emit(PromotionUpdated(updatedPromotion));
        // Optionnel: Recharger toutes les promotions après mise à jour
        // add(LoadAllPromotions());
      } else {
        emit(const PromotionError('Promotion update failed silently.'));
      }
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeletePromotion(
      DeletePromotion event, Emitter<PromotionState> emit) async {
    emit(PromotionLoading());
    try {
      await promotionControllerApi.deletePromotion(event.promotionId);
      emit(PromotionDeleted());
      // Optionnel: Recharger toutes les promotions après suppression
      // add(LoadAllPromotions());
    } on ApiException catch (e) {
      emit(PromotionError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(PromotionError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
