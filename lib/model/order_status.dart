// Enum for order status
enum OrderStatus {
  created,
  paymentPending,
  paid,
  processing,
  shipped,
  delivered,
  cancelled,
  failed,
}

// Extension for OrderStatus to get display name and API status mapping
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.created:
        return "Créée";
      case OrderStatus.paymentPending:
        return "En attente de paiement";
      case OrderStatus.paid:
        return "Payée";
      case OrderStatus.processing:
        return "En traitement";
      case OrderStatus.shipped:
        return "Expédiée";
      case OrderStatus.delivered:
        return "Livrée";
      case OrderStatus.cancelled:
        return "Annulée";
      case OrderStatus.failed:
        return "Échec";
    }
  }

  String get apiStatus {
    switch (this) {
      case OrderStatus.created:
        return "CREATED";
      case OrderStatus.paymentPending:
        return "PAYMENT_PENDING";
      case OrderStatus.paid:
        return "PAID";
      case OrderStatus.processing:
        return "PROCESSING";
      case OrderStatus.shipped:
        return "SHIPPED";
      case OrderStatus.delivered:
        return "DELIVERED";
      case OrderStatus.cancelled:
        return "CANCELLED";
      case OrderStatus.failed:
        return "FAILED";
    }
  }

  // Determine which tab this status belongs to
  OrderTab get tab {
    switch (this) {
      case OrderStatus.created:
      case OrderStatus.paymentPending:
      case OrderStatus.paid:
      case OrderStatus.processing:
      case OrderStatus.shipped:
        return OrderTab.ongoing;
      case OrderStatus.delivered:
        return OrderTab.completed;
      case OrderStatus.cancelled:
      case OrderStatus.failed:
        return OrderTab.cancelled;
    }
  }

  // Check if payment is required
  bool get requiresPayment {
    return this == OrderStatus.created || this == OrderStatus.paymentPending;
  }

  // Check if order can be cancelled
  bool get canBeCancelled {
    return this == OrderStatus.created || 
           this == OrderStatus.paymentPending || 
           this == OrderStatus.paid;
  }
}

// Enum for order tabs
enum OrderTab {
  ongoing,
  completed,
  cancelled,
}

extension OrderTabExtension on OrderTab {
  String get displayName {
    switch (this) {
      case OrderTab.ongoing:
        return "En cours";
      case OrderTab.completed:
        return "Terminées";
      case OrderTab.cancelled:
        return "Annulées";
    }
  }
}

// Helper function to parse API status to OrderStatus
OrderStatus parseOrderStatus(String? apiStatus) {
  switch (apiStatus?.toUpperCase()) {
    case "CREATED":
      return OrderStatus.created;
    case "PAYMENT_PENDING":
      return OrderStatus.paymentPending;
    case "PAID":
      return OrderStatus.paid;
    case "PROCESSING":
      return OrderStatus.processing;
    case "SHIPPED":
      return OrderStatus.shipped;
    case "DELIVERED":
      return OrderStatus.delivered;
    case "CANCELLED":
      return OrderStatus.cancelled;
    case "FAILED":
      return OrderStatus.failed;
    default:
      return OrderStatus.created; // Default fallback
  }
}
