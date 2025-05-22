part of 'heading_bloc.dart'; // Will be created next

abstract class HeadingState extends Equatable {
  const HeadingState();

  @override
  List<Object?> get props => [];
}

class HeadingInitial extends HeadingState {}

class HeadingLoading extends HeadingState {}

class HeadingsLoaded extends HeadingState {
  final List<HeadingDto> headings;

  const HeadingsLoaded(this.headings);

  @override
  List<Object?> get props => [headings];
}

class HeadingError extends HeadingState {
  final String message;

  const HeadingError(this.message);

  @override
  List<Object?> get props => [message];
}
