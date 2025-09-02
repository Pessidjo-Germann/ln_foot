import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ln_foot/model/saved_product_dto.dart';

part 'saved_items_event.dart';
part 'saved_items_state.dart';

const _savedItemsKey = 'favorite_products';

class SavedItemsBloc extends Bloc<SavedItemsEvent, SavedItemsState> {
  SavedItemsBloc() : super(SavedItemsInitial()) {
    on<LoadSavedItems>(_onLoadSavedItems);
    on<AddSavedItem>(_onAddSavedItem);
    on<RemoveSavedItem>(_onRemoveSavedItem);
  }
  Future<void> _onLoadSavedItems(
    LoadSavedItems event,
    Emitter<SavedItemsState> emit,
  ) async {
    debugPrint('DEBUG: LoadSavedItems event received');
    emit(SavedItemsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedItemsJson = prefs.getStringList(_savedItemsKey) ?? [];
      debugPrint(
          'DEBUG: Found ${savedItemsJson.length} saved items in SharedPreferences');

      final List<SavedProductDto> items = [];

      for (final itemJson in savedItemsJson) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(itemJson);
          final item = SavedProductDto.fromJson(jsonMap);
          items.add(item);
        } catch (e) {
          debugPrint(
              'DEBUG: Error parsing saved item, skipping: ${e.toString()}');
          // Skip corrupted entries
        }
      }

      // If we had to skip some items due to format changes, save the clean list
      if (items.length != savedItemsJson.length) {
        debugPrint('DEBUG: Cleaned up corrupted entries, saving clean list');
        final cleanItemsJson =
            items.map((item) => jsonEncode(item.toJson())).toList();
        await prefs.setStringList(_savedItemsKey, cleanItemsJson);
      }

      debugPrint('DEBUG: Successfully loaded ${items.length} favorite items');
      emit(SavedItemsLoaded(items));
    } catch (e) {
      debugPrint('DEBUG: Critical error loading saved items: ${e.toString()}');
      // Clear corrupted data and start fresh
      debugPrint('DEBUG: Clearing corrupted data and starting fresh');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_savedItemsKey);
      emit(SavedItemsLoaded([]));
    }
  }

  Future<void> _onAddSavedItem(
    AddSavedItem event,
    Emitter<SavedItemsState> emit,
  ) async {
    debugPrint(
        'DEBUG: AddSavedItem event received for product: ${event.product.product.name}');
    if (state is SavedItemsLoaded) {
      final currentState = state as SavedItemsLoaded;
      try {
        final prefs = await SharedPreferences.getInstance();
        final updatedItems = List<SavedProductDto>.from(currentState.items)
          ..add(event.product);
        final updatedItemsJson =
            updatedItems.map((item) => jsonEncode(item.toJson())).toList();
        await prefs.setStringList(_savedItemsKey, updatedItemsJson);
        debugPrint(
            'DEBUG: Product ${event.product.product.name} added to favorites successfully');
        emit(SavedItemsLoaded(updatedItems));
      } catch (e) {
        debugPrint('DEBUG: Error adding favorite: ${e.toString()}');
        emit(SavedItemsError(
            'Erreur lors de l\'ajout du favori: ${e.toString()}'));
        // Optionnel: revenir à l'état précédent en cas d'erreur
        // emit(currentState);
      }
    } else {
      debugPrint(
          'DEBUG: State is not SavedItemsLoaded, current state: ${state.runtimeType}');
      // Gérer le cas où l'état n'est pas SavedItemsLoaded (ex: charger d'abord)
      add(LoadSavedItems()); // Charger les items avant d'ajouter
    }
  }

  Future<void> _onRemoveSavedItem(
    RemoveSavedItem event,
    Emitter<SavedItemsState> emit,
  ) async {
    debugPrint(
        'DEBUG: RemoveSavedItem event received for product ID: ${event.productId}');
    if (state is SavedItemsLoaded) {
      final currentState = state as SavedItemsLoaded;
      try {
        final prefs = await SharedPreferences.getInstance();
        final updatedItems = currentState.items
            .where((item) => item.product.id != event.productId)
            .toList();
        final updatedItemsJson =
            updatedItems.map((item) => jsonEncode(item.toJson())).toList();
        await prefs.setStringList(_savedItemsKey, updatedItemsJson);
        debugPrint(
            'DEBUG: Product ID ${event.productId} removed from favorites successfully');
        emit(SavedItemsLoaded(updatedItems));
      } catch (e) {
        debugPrint('DEBUG: Error removing favorite: ${e.toString()}');
        emit(SavedItemsError(
            'Erreur lors de la suppression du favori: ${e.toString()}'));
        // Optionnel: revenir à l'état précédent en cas d'erreur
        // emit(currentState);
      }
    } else {
      debugPrint(
          'DEBUG: State is not SavedItemsLoaded for removal, current state: ${state.runtimeType}');
      // Gérer le cas où l'état n'est pas SavedItemsLoaded
      add(LoadSavedItems()); // Charger les items si nécessaire
    }
  }
}
