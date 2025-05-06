part of 'size_bloc.dart';

abstract class SizeState extends Equatable {
  const SizeState();

  @override
  List<Object?> get props => [];
}

class SizeInitial extends SizeState {}

class SizeLoading extends SizeState {}

class SizesLoaded extends SizeState {
  final List<SizeDto> sizes;

  const SizesLoaded(this.sizes);

  @override
  List<Object?> get props => [sizes];
}

class SizeLoaded extends SizeState {
  final SizeDto size;

  const SizeLoaded(this.size);

  @override
  List<Object?> get props => [size];
}

class SizeCreated extends SizeState {
  final SizeDto size;

  const SizeCreated(this.size);

  @override
  List<Object?> get props => [size];
}

class SizeUpdated extends SizeState {
  final SizeDto size;

  const SizeUpdated(this.size);

  @override
  List<Object?> get props => [size];
}

class SizeDeleted extends SizeState {}

class SizeError extends SizeState {
  final String message;

  const SizeError(this.message);

  @override
  List<Object?> get props => [message];
}
