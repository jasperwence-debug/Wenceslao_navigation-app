class DemoAuth {
  static String? registeredUsername;
  static String? registeredPassword;

  static bool login(String username, String password) {
    final isAdmin = username == 'admin' && password == 'admin123';
    final isRegistered = registeredUsername != null &&
        username == registeredUsername &&
        password == registeredPassword;
    return isAdmin || isRegistered;
  }

  static void register(String username, String password) {
    registeredUsername = username;
    registeredPassword = password;
  }
}
