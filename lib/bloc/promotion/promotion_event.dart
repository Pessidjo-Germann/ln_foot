// part of 'promotion_bloc.dart';

// @immutable
// abstract class PromotionEvent extends Equatable {
//   const PromotionEvent();

//   @override
//   List<Object?> get props => [];
// }

// // Événement pour charger toutes les promotions
// class LoadAllPromotions extends PromotionEvent {}

// // Événement pour charger une promotion par son ID
// class LoadPromotionById extends PromotionEvent {
//   final String promotionId;

//   const LoadPromotionById(this.promotionId);

//   @override
//   List<Object?> get props => [promotionId];
// }

// // Événement pour créer une nouvelle promotion
// class CreatePromotion extends PromotionEvent {
//   final PromotionDto promotionData;

//   const CreatePromotion(this.promotionData);

//   @override
//   List<Object?> get props => [promotionData];
// }

// // Événement pour créer plusieurs promotions en batch
// class CreatePromotions extends PromotionEvent {
//   final List<PromotionDto> promotionsData;

//   const CreatePromotions(this.promotionsData);

//   @override
//   List<Object?> get props => [promotionsData];
// }

// // Événement pour mettre à jour une promotion existante
// class UpdatePromotion extends PromotionEvent {
//   final String promotionId;
//   final PromotionDto promotionData;

//   const UpdatePromotion(this.promotionId, this.promotionData);

//   @override
//   List<Object?> get props => [promotionId, promotionData];
// }

// // Événement pour supprimer une promotion
// class DeletePromotion extends PromotionEvent {
//   final String promotionId;

//   const DeletePromotion(this.promotionId);

//   @override
//   List<Object?> get props => [promotionId];
// }
