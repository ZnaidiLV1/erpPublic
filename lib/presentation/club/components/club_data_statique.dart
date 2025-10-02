class ClubData {
  final String nomAr;
  final String nomFr;
  final String descriptionAr;
  final String descriptionFr;

  ClubData({
    required this.nomAr,
    required this.nomFr,
    required this.descriptionAr,
    required this.descriptionFr,
  });
}
final List<String> availableClubImages = [  
   'assets/images/Clubs/Club linguistique/0.png',
    'assets/images/Clubs/Club linguistique/Artboard 1@4x.png',
    'assets/images/Clubs/Club linguistique/Artboard 2@4x.png',
     'assets/images/Clubs/Club linguistique/Artboard 5@4x.png',
      'assets/images/Clubs/Club linguistique/Artboard 6@4x.png',
       'assets/images/Clubs/Club linguistique/Artboard 39@4x.png',
        'assets/images/Clubs/Club linguistique/Artboard 50@4x.png',
         'assets/images/Clubs/Club linguistique/Artboard 51@4x.png',
            'assets/images/Clubs/ete/0.png',
    'assets/images/Clubs/ete/Artboard 25@4x.png',
    'assets/images/Clubs/ete/Artboard 26@4x.png',
    'assets/images/Clubs/ete/Artboard 27@4x.png',
       'assets/images/Clubs/ete/Artboard 48@4x.png',
         'assets/images/Clubs/ete/Artboard 68@4x.png',
            'assets/images/Clubs/cuisine/0.png',
    'assets/images/Clubs/cuisine/Artboard 23@4x.png',
    'assets/images/Clubs/cuisine/Artboard 47@4x.png',
     'assets/images/Clubs/cuisine/Artboard 66@4x.png',
      'assets/images/Clubs/cuisine/Artboard 67@4x.png',
       'assets/images/Clubs/robotique/0.png',
    'assets/images/Clubs/robotique/Artboard 20@4x.png',
    'assets/images/Clubs/robotique/Artboard 46@4x.png',
     'assets/images/Clubs/robotique/Artboard 64@4x.png',
      'assets/images/Clubs/robotique/Artboard 65@4x.png',
       'assets/images/Clubs/tennis/0.png',
    'assets/images/Clubs/tennis/Artboard 19@4x.png',
  'assets/images/Clubs/tennis/Artboard 45@4x.png',
   'assets/images/Clubs/tennis/Artboard 62@4x.png',
   'assets/images/Clubs/tennis/Artboard 63@4x.png',
    'assets/images/Clubs/theatre_danse/Artboard 16@4x.png',
     'assets/images/Clubs/theatre_danse/Artboard 17@4x.png',
      'assets/images/Clubs/theatre_danse/Artboard 44@4x.png',
       'assets/images/Clubs/theatre_danse/Artboard 60@4x.png',
        'assets/images/Clubs/theatre_danse/Artboard 61@4x.png',
];
final Map<String, List<String>> imagesByClubType = {
  'النادي اللغوي': [
    'assets/images/Clubs/Club linguistique/0.png',
    'assets/images/Clubs/Club linguistique/Artboard 1@4x.png',
    'assets/images/Clubs/Club linguistique/Artboard 2@4x.png',
     'assets/images/Clubs/Club linguistique/Artboard 5@4x.png',
      'assets/images/Clubs/Club linguistique/Artboard 6@4x.png',
       'assets/images/Clubs/Club linguistique/Artboard 39@4x.png',
        'assets/images/Clubs/Club linguistique/Artboard 50@4x.png',
         'assets/images/Clubs/Club linguistique/Artboard 51@4x.png',
  ],
  'Club linguistique': [
     'assets/images/Clubs/Club linguistique/0.png',
    'assets/images/Clubs/Club linguistique/Artboard 1@4x.png',
    'assets/images/Clubs/Club linguistique/Artboard 2@4x.png',
     'assets/images/Clubs/Club linguistique/Artboard 5@4x.png',
      'assets/images/Clubs/Club linguistique/Artboard 6@4x.png',
       'assets/images/Clubs/Club linguistique/Artboard 39@4x.png',
        'assets/images/Clubs/Club linguistique/Artboard 50@4x.png',
         'assets/images/Clubs/Club linguistique/Artboard 51@4x.png',
  ],
  'النادي الصيفي': [
    'assets/images/Clubs/ete/0.png',
    'assets/images/Clubs/ete/Artboard 25@4x.png',
    'assets/images/Clubs/ete/Artboard 26@4x.png',
    'assets/images/Clubs/ete/Artboard 27@4x.png',
       'assets/images/Clubs/ete/Artboard 48@4x.png',
         'assets/images/Clubs/ete/Artboard 68@4x.png',
  ],
  'Club d\'été': [
    'assets/images/Clubs/ete/0.png',
    'assets/images/Clubs/ete/Artboard 25@4x.png',
    'assets/images/Clubs/ete/Artboard 26@4x.png',
    'assets/images/Clubs/ete/Artboard 27@4x.png',
       'assets/images/Clubs/ete/Artboard 48@4x.png',
         'assets/images/Clubs/ete/Artboard 68@4x.png',
  ],
  'نادي الطبخ': [
     'assets/images/Clubs/cuisine/0.png',
    'assets/images/Clubs/cuisine/Artboard 23@4x.png',
    'assets/images/Clubs/cuisine/Artboard 47@4x.png',
     'assets/images/Clubs/cuisine/Artboard 66@4x.png',
      'assets/images/Clubs/cuisine/Artboard 67@4x.png',
  ],
  'Club de cuisine': [
    'assets/images/Clubs/cuisine/0.png',
    'assets/images/Clubs/cuisine/Artboard 23@4x.png',
    'assets/images/Clubs/cuisine/Artboard 47@4x.png',
     'assets/images/Clubs/cuisine/Artboard 66@4x.png',
      'assets/images/Clubs/cuisine/Artboard 67@4x.png',
  ],
  'نادي الروبوتيك': [
    'assets/images/Clubs/robotique/0.png',
    'assets/images/Clubs/robotique/Artboard 20@4x.png',
    'assets/images/Clubs/robotique/Artboard 46@4x.png',
     'assets/images/Clubs/robotique/Artboard 64@4x.png',
      'assets/images/Clubs/robotique/Artboard 65@4x.png',
  ],
  'Club de robotique': [
   'assets/images/Clubs/robotique/0.png',
    'assets/images/Clubs/robotique/Artboard 20@4x.png',
    'assets/images/Clubs/robotique/Artboard 46@4x.png',
     'assets/images/Clubs/robotique/Artboard 64@4x.png',
      'assets/images/Clubs/robotique/Artboard 65@4x.png',
  ],
  'نادي التنس': [
    'assets/images/Clubs/tennis/0.png',
    'assets/images/Clubs/tennis/Artboard 19@4x.png',
  'assets/images/Clubs/tennis/Artboard 45@4x.png',
   'assets/images/Clubs/tennis/Artboard 62@4x.png',
   'assets/images/Clubs/tennis/Artboard 63@4x.png',
  ],
  'Club de tennis': [
    'assets/images/Clubs/tennis/0.png',
    'assets/images/Clubs/tennis/Artboard 19@4x.png',
  'assets/images/Clubs/tennis/Artboard 45@4x.png',
   'assets/images/Clubs/tennis/Artboard 62@4x.png',
   'assets/images/Clubs/tennis/Artboard 63@4x.png',
  ],
  'نادي المسرح والرقص': [
 
    'assets/images/Clubs/theatre_danse/Artboard 16@4x.png',
     'assets/images/Clubs/theatre_danse/Artboard 17@4x.png',
      'assets/images/Clubs/theatre_danse/Artboard 44@4x.png',
       'assets/images/Clubs/theatre_danse/Artboard 60@4x.png',
        'assets/images/Clubs/theatre_danse/Artboard 61@4x.png',
  ],
  'Club de théâtre & danse': [
 
    'assets/images/Clubs/theatre_danse/Artboard 14@4x.png',
     'assets/images/Clubs/theatre_danse/Artboard 15@4x.png',
      'assets/images/Clubs/theatre_danse/Artboard 43@4x.png',
       'assets/images/Clubs/theatre_danse/Artboard 58@4x.png',
        'assets/images/Clubs/theatre_danse/Artboard 59@4x.png',
  ],
  'نادي المسرح': [
    'assets/images/Clubs/theatre/Artboard 14@4x.png',
     'assets/images/Clubs/theatre/Artboard 15@4x.png',
      'assets/images/Clubs/theatre/Artboard 43@4x.png',
       'assets/images/Clubs/theatre/Artboard 58@4x.png',
        'assets/images/Clubs/theatre/Artboard 59@4x.png',
  ],
  'Club de théâtre': [
    'assets/images/Clubs/theatre/0.png',
    'assets/images/Clubs/theatre/Artboard 14@4x.png',
     'assets/images/Clubs/theatre/Artboard 15@4x.png',
      'assets/images/Clubs/theatre/Artboard 43@4x.png',
       'assets/images/Clubs/theatre/Artboard 58@4x.png',
        'assets/images/Clubs/theatre/Artboard 59@4x.png',
  ],
  'نادي الرقص والموسيقى': [
    'assets/images/Clubs/danse_musique/Artboard 11@4x.png',
     'assets/images/Clubs/danse_musique/Artboard 12@4x.png',
    'assets/images/Clubs/danse_musique/Artboard 42@4x.png',
    'assets/images/Clubs/danse_musique/Artboard 56@4x.png',
     'assets/images/Clubs/danse_musique/Artboard 57@4x.png',
  ],
  'Club de danse et musique': [
   'assets/images/Clubs/danse_musique/Artboard 11@4x.png',
     'assets/images/Clubs/danse_musique/Artboard 12@4x.png',
    'assets/images/Clubs/danse_musique/Artboard 42@4x.png',
    'assets/images/Clubs/danse_musique/Artboard 56@4x.png',
     'assets/images/Clubs/danse_musique/Artboard 57@4x.png',
  ],
  'نادي الرقص': [
    'assets/images/Clubs/danse/Artboard 9@4x.png',
    'assets/images/Clubs/danse/Artboard 10@4x.png',
     'assets/images/Clubs/danse/Artboard 41@4x.png',
        'assets/images/Clubs/danse/Artboard 54@4x.png',
           'assets/images/Clubs/danse/Artboard 55@4x.png',
  ],
  'Club de danse': [
   'assets/images/Clubs/danse/Artboard 9@4x.png',
    'assets/images/Clubs/danse/Artboard 10@4x.png',
     'assets/images/Clubs/danse/Artboard 41@4x.png',
        'assets/images/Clubs/danse/Artboard 54@4x.png',
           'assets/images/Clubs/danse/Artboard 55@4x.png',
  ],
  'نادي الموسيقى': [

  ],
  'Club de musique': [
 
  ],
  'نادي القرآن': [
  
  ],
  'Club Coran': [

  ],
};

// Données des clubs
final List<ClubData> clubDataList = [
  ClubData(
    nomAr: 'النادي اللغوي',
    nomFr: 'Club linguistique',
    descriptionAr: 'رحلة ممتعة في عالم الكلمات، يتعرف فيها الطفل على اللغة الفرنسية والإنجليزية من خلال الأغاني، والألعاب التفاعلية، والقصص، مما يعزز قدرته على النطق السليم والتواصل بثقة.',
    descriptionFr: 'Un voyage ludique dans l\'univers des mots où l\'enfant découvre le français et l\'anglais à travers chansons, jeux interactifs et histoires, renforçant sa prononciation et sa capacité à communiquer avec assurance.',
  ),
  ClubData(
    nomAr: 'النادي الصيفي',
    nomFr: 'Club d\'été',
    descriptionAr: 'مغامرات صيفية مليئة بالمرح تجمع بين الألعاب المائية، والأنشطة الفنية، والحركية، والحكايات المسلية، في أجواء نابضة بالضحك والاكتشاف.',
    descriptionFr: 'Des aventures estivales pleines de joie réunissant jeux d\'eau, activités artistiques, motricité et contes amusants, dans une ambiance rythmée par les rires et les découvertes.',
  ),
  ClubData(
    nomAr: 'نادي الطبخ',
    nomFr: 'Club de cuisine',
    descriptionAr: 'عالم لذيذ يكتشف فيه الطفل متعة إعداد وصفات بسيطة وملونة، ويتعرف على مكونات صحية من خلال تجربة عملية مليئة بالمتعة والإبداع.',
    descriptionFr: 'Un univers gourmand où l\'enfant découvre le plaisir de préparer des recettes simples et colorées, tout en apprenant à connaître des ingrédients sains dans une expérience pratique et créative.',
  ),
  ClubData(
    nomAr: 'نادي الروبوتيك',
    nomFr: 'Club de robotique',
    descriptionAr: 'فضاء إبداعي يصمم فيه الطفل روبوتات صغيرة، ويتعلم مبادئ البرمجة بأسلوب ممتع يجمع بين اللعب والتفكير المنطقي.',
    descriptionFr: 'Un espace créatif où l\'enfant conçoit de petits robots et découvre les bases de la programmation de manière ludique, combinant jeu et réflexion logique.',
  ),
  ClubData(
    nomAr: 'نادي التنس',
    nomFr: 'Club de tennis',
    descriptionAr: 'نشاط رياضي ممتع يطور لدى الطفل التناسق الحركي، ورد الفعل السريع، وروح المنافسة الإيجابية من خلال لعبة التنس.',
    descriptionFr: 'Une activité sportive amusante qui développe la coordination, les réflexes et l\'esprit de compétition positive chez l\'enfant grâce au tennis.',
  ),
  ClubData(
    nomAr: 'نادي المسرح والرقص',
    nomFr: 'Club de théâtre & danse',
    descriptionAr: 'فضاء فني يجمع بين الحركة والكلمة، حيث يكتشف الطفل المسرح والرقص في مزيج يعزز الإبداع والثقة بالنفس.',
    descriptionFr: 'Un espace artistique combinant mouvement et expression orale, où l\'enfant explore le théâtre et la danse dans une harmonie qui stimule créativité et confiance en soi.',
  ),
  ClubData(
    nomAr: 'نادي المسرح',
    nomFr: 'Club de théâtre',
    descriptionAr: 'منصة خيالية يعيش فيها الطفل أدوارًا مختلفة، ويطور قدرته على التعبير والتواصل من خلال التمثيل والارتجال.',
    descriptionFr: 'Une scène imaginaire où l\'enfant incarne divers rôles et développe son expression et sa communication à travers le jeu théâtral et l\'improvisation.',
  ),
  ClubData(
    nomAr: 'نادي الرقص والموسيقى',
    nomFr: 'Club de danse et musique',
    descriptionAr: 'مهرجان من الإيقاعات والألحان يرقص فيه الطفل ويعزف ويغني، مع تنمية الإحساس بالموسيقى والتناسق الحركي.',
    descriptionFr: 'Un festival de rythmes et de mélodies où l\'enfant danse, joue et chante, tout en développant son sens musical et sa coordination.',
  ),
  ClubData(
    nomAr: 'نادي الرقص',
    nomFr: 'Club de danse',
    descriptionAr: 'فضاء حيوي يتعلم فيه الطفل حركات ورقصات متنوعة، ويطور مرونته وتناسقه البدني.',
    descriptionFr: 'Un espace dynamique où l\'enfant apprend différents mouvements et styles de danse, améliorant sa souplesse et sa coordination.',
  ),
  ClubData(
    nomAr: 'نادي الموسيقى',
    nomFr: 'Club de musique',
    descriptionAr: 'رحلة لحنية يتعرف فيها الطفل على الآلات الموسيقية، ويتعلم العزف والغناء بأسلوب ممتع.',
    descriptionFr: 'Un voyage mélodieux où l\'enfant découvre les instruments de musique et apprend à jouer et chanter de façon ludique.',
  ),
  ClubData(
    nomAr: 'نادي القرآن',
    nomFr: 'Club Coran',
    descriptionAr: 'فضاء روحاني يتعلم فيه الطفل تلاوة القرآن الكريم وحفظه بأسلوب لطيف، مع غرس قيم الاحترام والمحبة.',
    descriptionFr: 'Un espace spirituel où l\'enfant apprend à réciter et mémoriser le Coran avec douceur, tout en cultivant des valeurs de respect et de bienveillance.',
  ),
];

// Listes d'instructeurs et catégories
final List<String> instructorsList = [
  'Ahmed Ben Salah',
  'Fatma Bouzid', 
  'Mohamed Trabelsi',
  'Amel Gharbi',
  'Karim Mansouri',
  'Leila Khodja',
  'Nizar Bouaziz',
  'Sarra Mejri',
  'Hedi Zitouni',
  'Rim Nasri',
];

final List<String> categoriesList = [
  'Langues et Communication',
  'Arts et Créativité',
  'Sport et Mouvement', 
  'Sciences et Technologie',
  'Musique et Rythme',
  'Spirituel et Valeurs',
  'Activités Estivales',
  'Cuisine et Nutrition',
];

// Polices disponibles
final List<String> availableFonts = [
  'Default',
  'Roboto',
  'Arial',
  'Times New Roman',
  'Georgia',
  'Verdana',
  'Comic Sans MS',
  'Impact',
  'Trebuchet MS',
  'Courier New',
];