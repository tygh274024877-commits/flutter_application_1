import 'package:get/get_utils/src/extensions/internacionalization.dart';

Map<int, Map<String, List<Map<String, dynamic>>>> detailedData = {
  2: {
    // 🏨 قسم الفنادق (Hotels)
    "Damascus": [
      {
        "id": "h1",
        "name": "hotel_fs_name".tr,
        "locationName": "hotel_fs_loc".tr,
        "image": "assets/images/hotel1.jpg",
        "description": "hotel_fs_desc".tr,
        "features": ["wifi".tr, "pool".tr, "gym".tr, "spa".tr],
      },
      {
        "id": "h2",
        "name": "hotel_bw_name".tr,
        "locationName": "hotel_bw_loc".tr,
        "image": "assets/images/wali.jpg",
        "description": "hotel_bw_desc".tr,
        "features": ["trad_decor".tr, "wifi".tr, "restaurant_feat".tr],
      },
    ],
    "Lattakia": [
      {
        "id": "h3",
        "name": "hotel_af_name".tr,
        "locationName": "hotel_af_loc".tr,
        "image": "assets/images/afamia.jpg",
        "description": "hotel_af_desc".tr,
        "features": ["beach_access".tr, "pool".tr, "kids_area".tr],
      },
      {
        "id": "h4",
        "name": "hotel_ca_name".tr,
        "locationName": "hotel_ca_loc".tr,
        "image": "assets/images/cote.jpg",
        "description": "hotel_ca_desc".tr,
        "features": ["sea_view".tr, "wifi".tr, "spa".tr],
      },
    ],
    "Aleppo": [
      {
        "id": "h5",
        "name": "hotel_sh_name".tr,
        "locationName": "hotel_sh_loc".tr,
        "image": "assets/images/sheraton_aleppo.jpg",
        "description": "hotel_sh_desc".tr,
        "features": ["central_loc".tr, "wifi".tr, "events_hall".tr],
      },
    ],
  },
  4: {
    // 🍴 قسم المطاعم (Restaurants)
    "Damascus": [
      {
        "id": "r1",
        "name": "rest_naranj_name".tr,
        "locationName": "rest_naranj_loc".tr,
        "image": "assets/images/naranj.jpg",
        "description": "rest_naranj_desc".tr,
        "menu": ["menu_oriental".tr, "menu_appetizers".tr, "menu_grills".tr],
      },
    ],
    "Lattakia": [
      {
        "id": "r2",
        "name": "rest_zaitouna_name".tr,
        "locationName": "rest_zaitouna_loc".tr,
        "image": "assets/images/zaitouna.jpg",
        "description": "rest_zaitouna_desc".tr,
        "menu": ["menu_fish".tr, "menu_seafood".tr, "menu_salads".tr],
      },
    ],
    "Aleppo": [
      {
        "id": "r3",
        "name": "rest_wanes_name".tr,
        "locationName": "rest_wanes_loc".tr,
        "image": "assets/images/wanes.jpg",
        "description": "rest_wanes_desc".tr,
        "menu": ["menu_aleppo_grills".tr, "menu_kibbeh".tr, "menu_sweets".tr],
      },
    ],
  },
};
