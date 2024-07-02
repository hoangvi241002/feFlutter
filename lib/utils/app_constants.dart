class AppConstants {
  static const String APP_NAME = "DBMedicalItem";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://10.0.2.2:8000";
  // static const String BASE_URL = "https://dbf.dbestech.com";
  // static const String BASE_URL = "http://192.168.1.7:8001";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String SEARCH_PRODUCT_URI = "/api/v1/products/search";

  static const String UPLOAD_URL = "/uploads/";

  // user and auth EndPoint
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";

  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String SEARCH_LOCATION_URI = "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URI = "/api/v1/config/place-api-details";

  static const String PLACE_ORDER_URI = "/api/v1/customer/order/place";
  static const String ORDER_LIST_URI = "/api/v1/customer/order/list";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  // static const String SEARCH_PRODUCT_URI = "search";

  static const String clientId = "AZQdFU9m3fKNTcccNS2vd26KKrL3Bza0360D65LJ6ssQMKLfa3dTUuhA9GMlCQVo09Lw8UGDiSBzvPSZ";
  static const String secretKey = "EM_OAa3_v_3sxU60df-r2wji7dpX3qh1-Gab8jfzY2u4vKiqCVI-w1wsw763tfCAjHtG9mLOAZ7xdpas";
  static const String returnURL = "https://samplesite.com/return";
  static const String cancelURL = "https://samplesite.com/cancel";
}