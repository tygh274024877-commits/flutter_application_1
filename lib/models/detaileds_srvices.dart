Map<int, Map<String, List<Map<String, dynamic>>>> detailedData = {
  2: {
    // 🏨 قسم الفنادق (Hotels)
    "Damascus": [
      {
        "id": "h1",
        "name": "Four Seasons",
        "locationName": "دمشق - ساحة الأمويين",
        "image": "assets/images/hotel1.jpg",
        "description":
            "فندق فاخر يوفر إطلالات بانورامية على المدينة وخدمات عالمية من فئة 5 نجوم.",
        "features": ["WiFi", "Pool", "Gym", "Spa"],
      },
      {
        "id": "h2",
        "name": "Beit Al Wali",
        "locationName": "دمشق القديمة - باب توما",
        "image": "assets/images/wali.jpg",
        "description":
            "تجربة تراثية فريدة في قلب دمشق القديمة، يتميز بالعمارة الشامية الأصيلة.",
        "features": ["Traditional Decor", "WiFi", "Restaurant"],
      },
    ],
    "Lattakia": [
      {
        "id": "h3",
        "name": "Afamia Resort",
        "locationName": "اللاذقية - الشاطئ الأزرق",
        "image": "assets/images/afamia.jpg",
        "description":
            "منتجع سياحي متكامل بخصوصية عالية، مثالي للعطلات العائلية على البحر.",
        "features": ["Beach Access", "Pool", "Kids Area"],
      },
      {
        "id": "h4",
        "name": "Cote d'Azur",
        "locationName": "اللاذقية - الكورنيش الجنوبي",
        "image": "assets/images/cote.jpg",
        "description":
            "فندق عصري بإطلالة مباشرة على المتوسط، يجمع بين الهدوء والرفاهية.",
        "features": ["Sea View", "WiFi", "Spa"],
      },
    ],
    "Aleppo": [
      {
        "id": "h5",
        "name": "Sheraton Aleppo",
        "locationName": "حلب - مركز المدينة",
        "image": "assets/images/sheraton_aleppo.jpg",
        "description":
            "فندق عريق يقع في منطقة حيوية، يقدم خدمات فندقية راقية لرجال الأعمال والسياح.",
        "features": ["Central Location", "WiFi", "Events Hall"],
      },
    ],
  },
  4: {
    // 🍴 قسم المطاعم (Restaurants)
    "Damascus": [
      {
        "id": "r1",
        "name": "Naranj Restaurant",
        "locationName": "دمشق - الشارع المستقيم",
        "image": "assets/images/naranj.jpg",
        "description":
            "أحد أشهر مطاعم دمشق القديمة، يقدم أشهى المأكولات الشامية التقليدية.",
        "menu": ["شرقي", "مقبلات شامية", "مشاوي"],
      },
    ],
    "Lattakia": [
      {
        "id": "r2",
        "name": "Zaitouna Restaurant",
        "locationName": "اللاذقية - الكورنيش الغربي",
        "image": "assets/images/zaitouna.jpg",
        "description":
            "مطعم متخصص بالمأكولات البحرية الطازجة مع جلسات هادئة على البحر مباشرة.",
        "menu": ["أسماك", "ثمار البحر", "سلطات"],
      },
    ],
    "Aleppo": [
      {
        "id": "r3",
        "name": "Wanes Restaurant",
        "locationName": "حلب - العزيزية",
        "image": "assets/images/wanes.jpg",
        "description":
            "مطعم حلبي أصيل يشتهر بتقديم الكبب الحلبية والمشاوي بنكهة لا تُنسى.",
        "menu": ["مشاوي حلبية", "كبة بأنواعها", "حلويات"],
      },
    ],
  },
};
