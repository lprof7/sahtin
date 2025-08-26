class ApiConfig {
  static const String baseUrl = 'https://api.example.com';

  // User endpoints
  static const String userById = '/users/{id}';
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // Dish endpoints
  static const String dishById = '/dishes/{id}';
  static const String allDishes = '/dishes';

  // Vendor endpoints
  static const String vendorById = '/vendors/{id}';
  static const String allVendors = '/vendors';

  // Menu endpoints
  static const String menuById = '/menus/{id}';
  static const String menusByVendor = '/vendors/{vendorId}/menus';

  // Cart endpoints
  static const String cartByUser = '/users/{userId}/cart';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';

  // Order endpoints
  static const String orderById = '/orders/{id}';
  static const String ordersByUser = '/users/{userId}/orders';
  static const String createOrder = '/orders';

  // Payment endpoints
  static const String processPayment = '/payments/process';
  static const String paymentByOrder = '/orders/{orderId}/payment';

  // Review endpoints
  static const String reviewsByVendor = '/vendors/{vendorId}/reviews';
  static const String addReview = '/reviews';

  // Location endpoints
  static const String locationByUser = '/users/{userId}/location';
  static const String saveLocation = '/locations';

  // Notification endpoints
  static const String notificationsByUser = '/users/{userId}/notifications';
  static const String markNotificationRead = '/notifications/{id}/read';
}
