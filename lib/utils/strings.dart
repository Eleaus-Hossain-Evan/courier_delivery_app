class AppStrings {
  AppStrings._();

  static const String appName = 'Courier Delivery App';
  static const String token = 'token';
  static const String user = 'user';
  static const String firebaseToken = 'firebaseToken';
  static const String onBoard = "onBoard-key";
  static const String cacheBox = 'cacheBox';
  static const String tkSymbol = "\u{09F3}";
  static const String theme = "theme";

  //#----------------  Profile ----------------
  static const String profile = "Profile";
  static const String password = "Password";
  static const String changePassword = "Change Password";
  static const String logout = "Logout";
  static const String save = "Save";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "Email";
  static const String phoneNumber = "Phone Number";
  static const String phoneNumberOrEmail = "Phone Number or Email";
  static const String contactUs = "Contact Us";
  static const String privacyPolicy = "Privacy & Policy";
  static const String bankDetail = "Bank Details";
  static const String paymentMethod = "Payment Methods";
  static const String updateHub = "Update Hub";

  //#----------------  Home ----------------
  static const String home = "Home";
  static String welcome(String user) => "Welcome $user";

  //#----------------  Delivery ----------------
  static const String deliverDashboard = "Delivery Dashboard";
  static const String totalPendingOrders = "Total Pending Orders";

  //#----------------  Auth ----------------
  static const String signup = "Sign Up";
  static const String login = "Sign In";
  static const String signupBelowText =
      "Press the signup button for create a new account";
  static const String loginBelowText =
      "Press the login button for logged into the app";
  static const String remember = "Remember Me";
  static const String forgotPassword = "Forgot Password";
  static const String dontHaveAccount = "Don't have account yet?";
  static const String alreadyHaveAccount = "Already have an Account";
  static const String createAccount = "Create Account";
  static const String orSignupWith = "or Sign up with";
  static const String signUpPrivacyPolicy =
      "By clicking Sign Up, you agree to our Terms of Use and our Privacy Policy.";
}
