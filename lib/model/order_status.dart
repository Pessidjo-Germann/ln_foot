// Enum for order status
enum OrderStatus {
  ongoing,
  completed,
  review,
}

// Extension for OrderStatus to get display name
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.ongoing:
        return "En cours";
      case OrderStatus.completed:
        return "Complete";
      case OrderStatus.review:
        return "Revoir";
      default:
        return "";
    }
  }
}
