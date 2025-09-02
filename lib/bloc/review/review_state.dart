part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<ReviewDto> reviews;

  const ReviewsLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewLoaded extends ReviewState {
  final ReviewDto review;

  const ReviewLoaded(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewCreated extends ReviewState {
  final ReviewDto review;

  const ReviewCreated(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewUpdated extends ReviewState {
  final ReviewDto review;

  const ReviewUpdated(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewDeleted extends ReviewState {}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
