import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lnFoot_api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

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
    emit(SavedItemsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedItemsJson = prefs.getStringList(_savedItemsKey) ?? [];
      final items = savedItemsJson
          .map((itemJson) => ProductDto.fromJson(jsonDecode(itemJson)))
          .toList();
      emit(SavedItemsLoaded(items.whereType<ProductDto>().toList()));
    } catch (e) {
      emit(SavedItemsError(
          'Erreur lors du chargement des favoris: ${e.toString()}'));
    }
  }

  Future<void> _onAddSavedItem(
    AddSavedItem event,
    Emitter<SavedItemsState> emit,
  ) async {
    if (state is SavedItemsLoaded) {
      final currentState = state as SavedItemsLoaded;
      try {
        final prefs = await SharedPreferences.getInstance();
        final updatedItems = List<ProductDto>.from(currentState.items)
          ..add(event.product);
        final updatedItemsJson =
            updatedItems.map((item) => jsonEncode(item.toJson())).toList();
        await prefs.setStringList(_savedItemsKey, updatedItemsJson);
        emit(SavedItemsLoaded(updatedItems));
      } catch (e) {
        emit(SavedItemsError(
            'Erreur lors de l\'ajout du favori: ${e.toString()}'));
        // Optionnel: revenir à l'état précédent en cas d'erreur
        // emit(currentState);
      }
    } else {
      // Gérer le cas où l'état n'est pas SavedItemsLoaded (ex: charger d'abord)
      add(LoadSavedItems()); // Charger les items avant d'ajouter
    }
  }

  Future<void> _onRemoveSavedItem(
    RemoveSavedItem event,
    Emitter<SavedItemsState> emit,
  ) async {
    if (state is SavedItemsLoaded) {
      final currentState = state as SavedItemsLoaded;
      try {
        final prefs = await SharedPreferences.getInstance();
        final updatedItems = currentState.items
            .where((item) => item.id != event.productId)
            .toList();
        final updatedItemsJson =
            updatedItems.map((item) => jsonEncode(item.toJson())).toList();
        await prefs.setStringList(_savedItemsKey, updatedItemsJson);
        emit(SavedItemsLoaded(updatedItems));
      } catch (e) {
        emit(SavedItemsError(
            'Erreur lors de la suppression du favori: ${e.toString()}'));
        // Optionnel: revenir à l'état précédent en cas d'erreur
        // emit(currentState);
      }
    } else {
      // Gérer le cas où l'état n'est pas SavedItemsLoaded
      add(LoadSavedItems()); // Charger les items si nécessaire
    }
  }
}
