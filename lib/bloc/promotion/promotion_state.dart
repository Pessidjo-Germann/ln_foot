// part of 'promotion_bloc.dart';

// @immutable
// abstract class PromotionState extends Equatable {
//   const PromotionState();

//   @override
//   List<Object?> get props => [];
// }

// // État initial
// class PromotionInitial extends PromotionState {}

// // État de chargement
// class PromotionLoading extends PromotionState {}

// // État lorsque toutes les promotions sont chargées
// class PromotionsLoaded extends PromotionState {
//   final List<Promotion> promotions;

//   const PromotionsLoaded(this.promotions);

//   @override
//   List<Object?> get props => [promotions];
// }

// // État lorsqu'une promotion spécifique est chargée
// class PromotionLoaded extends PromotionState {
//   final Promotion promotion;

//   const PromotionLoaded(this.promotion);

//   @override
//   List<Object?> get props => [promotion];
// }

// // État après la création réussie d'une promotion
// class PromotionCreated extends PromotionState {
//   final Promotion promotion;

//   const PromotionCreated(this.promotion);

//   @override
//   List<Object?> get props => [promotion];
// }

// // État après la création réussie de plusieurs promotions
// class PromotionsCreated extends PromotionState {
//   final List<Promotion> promotions;

//   const PromotionsCreated(this.promotions);

//   @override
//   List<Object?> get props => [promotions];
// }

// // État après la mise à jour réussie d'une promotion
// class PromotionUpdated extends PromotionState {
//   final Promotion promotion;

//   const PromotionUpdated(this.promotion);

//   @override
//   List<Object?> get props => [promotion];
// }

// // État après la suppression réussie d'une promotion
// class PromotionDeleted extends PromotionState {}

// // État en cas d'erreur
// class PromotionError extends PromotionState {
//   final String message;

//   const PromotionError(this.message);

//   @override
//   List<Object?> get props => [message];
// }
