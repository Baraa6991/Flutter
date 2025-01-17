// ignore_for_file: file_names

class Urls {
  static String ip = "192.168.1.6";
  static String baseUrl = "http://$ip:8000/api";
  static String auth = "$baseUrl/auth";
  static String login = '$auth/login';
  static String register = '$auth/register';
  static String home = '$auth/categories';
  static String logout = '$auth/logout';

  static String updateProfile(int userId) {
    return '$auth/update/$userId';
  }

  static String getImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    return "$auth/$imagePath";
  }

  static String getStoresByCategory(int categoryId) {
    return '$auth/categories/$categoryId/stores';
  }

  static String getProductsByStores(int categoryId, int storeId) {
    return '$auth/categories/$categoryId/stores/$storeId/products';
  }

  static String getDicikrebtionByProducts(
      int categoryId, int storeId, int productId) {
        
    return '$auth/categories/$categoryId/stores/$storeId/products/$productId';
    

  }
}
