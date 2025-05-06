import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lnFoot_api/api.dart'; // Assurez-vous que le nom du package est correct

part 'size_event.dart';
part 'size_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  final SizeControllerApi sizeControllerApi;

  SizeBloc({required this.sizeControllerApi}) : super(SizeInitial()) {
    on<LoadAllSizes>(_onLoadAllSizes);
    on<LoadSizeById>(_onLoadSizeById);
    on<CreateSize>(_onCreateSize);
    on<UpdateSize>(_onUpdateSize);
    on<DeleteSize>(_onDeleteSize);
  }

  Future<void> _onLoadAllSizes(
      LoadAllSizes event, Emitter<SizeState> emit) async {
    emit(SizeLoading());
    try {
      final sizes = await sizeControllerApi.getAllSizes();
      emit(SizesLoaded(sizes ?? []));
    } on ApiException catch (e) {
      emit(SizeError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(SizeError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onLoadSizeById(
      LoadSizeById event, Emitter<SizeState> emit) async {
    emit(SizeLoading());
    try {
      final size = await sizeControllerApi.getSizeById(event.sizeId);
      if (size != null) {
        emit(SizeLoaded(size));
      } else {
        emit(const SizeError('Size not found.'));
      }
    } on ApiException catch (e) {
      emit(SizeError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(SizeError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onCreateSize(CreateSize event, Emitter<SizeState> emit) async {
    emit(SizeLoading());
    try {
      final createdSize = await sizeControllerApi.createSize(
        event.sizeData,
      );
      if (createdSize != null) {
        emit(SizeCreated(createdSize));
        // Optionnel : add(LoadAllSizes()); // Pour rafraîchir la liste
      } else {
        emit(const SizeError('Size creation failed silently.'));
      }
    } on ApiException catch (e) {
      emit(SizeError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(SizeError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateSize(UpdateSize event, Emitter<SizeState> emit) async {
    emit(SizeLoading());
    try {
      final updatedSize = await sizeControllerApi.updateSize(
        event.sizeId,
        event.sizeData,
      );
      if (updatedSize != null) {
        emit(SizeUpdated(updatedSize));
        // Optionnel : add(LoadAllSizes()); // Pour rafraîchir la liste
      } else {
        emit(const SizeError('Size update failed silently.'));
      }
    } on ApiException catch (e) {
      emit(SizeError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(SizeError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteSize(DeleteSize event, Emitter<SizeState> emit) async {
    emit(SizeLoading());
    try {
      await sizeControllerApi.deleteSize(event.sizeId);
      emit(SizeDeleted());
      // Optionnel : add(LoadAllSizes()); // Pour rafraîchir la liste
    } on ApiException catch (e) {
      emit(SizeError('API Error ${e.code}: ${e.message ?? e.toString()}'));
    } catch (e) {
      emit(SizeError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
