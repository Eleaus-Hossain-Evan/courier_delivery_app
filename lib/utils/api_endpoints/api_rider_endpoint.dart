// ignore_for_file: constant_identifier_names

class EndPointRider {
  static const String DUMMY_PERSON = 'https://i.pravatar.cc/300';
  static const String WEB_URL = "";

  static const String BASE_URL = "https://api.courier.b2gsoft.xyz/";
  // static const String BASE_URL = "https://api.senaiyah.com/";
  // static const String BASE_URL_LOCAL = "http://192.168.68.118:3697/";
  static const String API_V1 = "api/v1/";

  //#<<---------------- AUTH ------------------>>
  static const String SIGN_UP = "${API_V1}merchant/registration";
  static const String LOGIN = "${API_V1}rider/login";
  static const String PROFILE_VIEW = "${API_V1}rider/single-fetch/";
  static const String PASSWORD_UPDATE =
      "${API_V1}merchant/password-update-by-himself";

  //#<<---------------- SHOP ------------------>>
  static const String ADD_SHOP = "${API_V1}merchant/add-shop-by-himself";
  static const String FETCH_ALL_SHOP =
      "${API_V1}merchant/fetch-all-shop-by-himself";
  static const String UPDATE_SHOP = "${API_V1}merchant/update-shop-by-himself/";
  static const String DELETE_SHOP = "${API_V1}merchant/delete-shop-by-himself/";

  //#<<---------------- Courier Merchant ------------------>>

  static const String HOME = "${API_V1}home-page/view";

  //#<<----------------Profile------------------>>
  static const String ALL_DISTRICT = "${API_V1}location/all-districts";
  static const String ALL_AREA_BY_DISTRICT =
      "${API_V1}location/district-areas/";
  static const String IMAGE_UPLOAD =
      "${API_V1}merchant/image-update-by-himself";
  static const String PROFILE_UPDATE = "${API_V1}merchant/update-by-himself";

  //#<<----------------Parcel------------------>>
  static const String PARCEL_PICKUPMAN = "${API_V1}parcel/rider-parcels?";
  static const String UPDATE_PARCEL_PICKUPMAN =
      "${API_V1}parcel/update-parcels-status-by-rider/";
}
