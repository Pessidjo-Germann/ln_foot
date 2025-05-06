import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart';
 
part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
   
  final ReviewControllerApi reviewControllerApi;

  ReviewBloc({required this.reviewControllerApi}) : super(ReviewInitial()) {
    on<LoadAllReviews>(_onLoadAllReviews);
    on<LoadReviewById>(_onLoadReviewById);
    on<CreateReview>(_onCreateReview);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
  }

  Future<void> _onLoadAllReviews(
      LoadAllReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final reviews = await reviewControllerApi.getAllReviews();
      emit(ReviewsLoaded(reviews ?? [])); // Gérer la nullabilité potentielle
    } on ApiException catch (e) {
      emit(ReviewError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ReviewError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadReviewById(
      LoadReviewById event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final review = await reviewControllerApi.getReviewById(event.reviewId);
      if (review != null) {
        emit(ReviewLoaded(review));
      } else {
        emit(const ReviewError('Review not found.'));
      }
    } on ApiException catch (e) {
      emit(ReviewError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ReviewError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreateReview(
      CreateReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final createdReview = await reviewControllerApi.createReview(
        event.userId,
        event.reviewData,
      );
      if (createdReview != null) {
        emit(ReviewCreated(createdReview));
        // Optionnel : rafraîchir la liste après création
        // add(LoadAllReviews());
      } else {
        emit(const ReviewError('Review creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(ReviewError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ReviewError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateReview(
      UpdateReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final updatedReview = await reviewControllerApi.updateReview(
        event.reviewId,
        event.userId,
        event.reviewData,
      );
      if (updatedReview != null) {
        emit(ReviewUpdated(updatedReview));
        // Optionnel : rafraîchir la liste après mise à jour
        // add(LoadAllReviews());
      } else {
        emit(const ReviewError('Review update failed silently.'));
      }
    } on ApiException catch (e) {
      emit(ReviewError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ReviewError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteReview(
      DeleteReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await reviewControllerApi.deleteReview(event.reviewId);
      emit(ReviewDeleted());
      // Optionnel : rafraîchir la liste après suppression
      // add(LoadAllReviews());
    } on ApiException catch (e) {
      emit(ReviewError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(ReviewError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
