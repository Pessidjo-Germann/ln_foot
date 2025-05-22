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
        return "pending";
      case OrderStatus.completed:
        return "completed";
      case OrderStatus.review:
        return "failed";
      default:
        return "";
    }
  }
}
