part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllReviews extends ReviewEvent {}

class LoadReviewById extends ReviewEvent {
  final String reviewId;

  const LoadReviewById(this.reviewId);

  @override
  List<Object?> get props => [reviewId];
}

class CreateReview extends ReviewEvent {
  final String userId;
  final ReviewDto reviewData;

  const CreateReview({required this.userId, required this.reviewData});

  @override
  List<Object?> get props => [userId, reviewData];
}

class UpdateReview extends ReviewEvent {
  final String reviewId;
  final String userId;
  final ReviewDto reviewData;

  const UpdateReview(
      {required this.reviewId, required this.userId, required this.reviewData});

  @override
  List<Object?> get props => [reviewId, userId, reviewData];
}

class DeleteReview extends ReviewEvent {
  final String reviewId;

  const DeleteReview(this.reviewId);

  @override
  List<Object?> get props => [reviewId];
}
