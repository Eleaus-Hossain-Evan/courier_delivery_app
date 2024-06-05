// ignore_for_file: constant_identifier_names

class EndPointPickUp {
  static const String DUMMY_PERSON = 'https://i.pravatar.cc/300';
  static const String WEB_URL = "";

  // static const String BASE_URL = "https://api.courier.b2gsoft.xyz/";
  static const String BASE_URL = "https://server.greenmaxcourier.com/";
  // static const String BASE_URL_LOCAL = "http://192.168.68.118:3697/";
  static const String API_V1 = "api/v1/";

  //#<<---------------- AUTH ------------------>>

  static const String LOGIN = "${API_V1}pickupman/login";
  static const String PROFILE_VIEW = "${API_V1}pickupman/single-fetch/";
  static const String PASSWORD_UPDATE =
      "${API_V1}pickupman/password-update-by-himself";

  //#<<---------------- Courier Merchant ------------------>>

  static const String HOME = "${API_V1}home-page/view";
  static const String DASHBOARD = "${API_V1}pickupman/dashboard";

  //#<<----------------Profile------------------>>
  static const String ALL_DISTRICT = "${API_V1}location/all-districts";
  static const String ALL_AREA_BY_DISTRICT =
      "${API_V1}location/district-areas/";
  static const String IMAGE_UPLOAD =
      "${API_V1}pickupman/image-update-by-himself";

  //#<<----------------Parcel------------------>>
  static const String PARCEL_PICKUPMAN = "${API_V1}parcel/pickupman-parcels?";
  static const String UPDATE_PARCEL_PICKUPMAN =
      "${API_V1}parcel/update-parcels-status-by-pickupman/";
}
