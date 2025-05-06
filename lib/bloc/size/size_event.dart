part of 'size_bloc.dart';

abstract class SizeEvent extends Equatable {
  const SizeEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllSizes extends SizeEvent {}

class LoadSizeById extends SizeEvent {
  final String sizeId;

  const LoadSizeById(this.sizeId);

  @override
  List<Object?> get props => [sizeId];
}

class CreateSize extends SizeEvent {
  final SizeDto sizeData;

  const CreateSize({required this.sizeData});

  @override
  List<Object?> get props => [sizeData];
}

class UpdateSize extends SizeEvent {
  final String sizeId;
  final SizeDto sizeData;

  const UpdateSize({required this.sizeId, required this.sizeData});

  @override
  List<Object?> get props => [sizeId, sizeData];
}

class DeleteSize extends SizeEvent {
  final String sizeId;

  const DeleteSize(this.sizeId);

  @override
  List<Object?> get props => [sizeId];
}
