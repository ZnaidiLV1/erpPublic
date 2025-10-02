import 'package:biboo_pro/presentation/events/components/ajouter_event.dart';

final List<String> availableImages = [
    'assets/images/Events/finAnn/Artboard 28@4x.png',
     'assets/images/Events/journporteouvert/0.png',
    'assets/images/Events/Fetemaman/0.png',
    'assets/images/Events/Fetemaman/Artboard 35@4x.png',
    'assets/images/Events/Fetemaman/Artboard 38@4x.png',
    'assets/images/Events/Fetemaman/Artboard 49@4x.png',
     'assets/images/Events/Fetemaman/Artboard 70@4x.png',
     'assets/images/Events/Fetemaman/Artboard 71@4x.png',
  ];
final Map<String, List<String>> imagesByEventType = {
  'La fête de fin d\'année': [
    'assets/images/Events/finAnn/Artboard 28@4x.png',
  
  ],
  'حفل نهاية السنة': [
   'assets/images/Events/finAnn/Artboard 28@4x.png',
  ],
  'Journée réunion éducateurs-parents': [
   
  ],
  'يوم اجتماع المربين والأولياء': [
 
  ],
  'Journée porte ouverte': [
    'assets/images/Events/journporteouvert/0.png',
   
  ],
  'اليوم المفتوح': [
    'assets/images/Events/journporteouvert/0.png',
  ],
  'Événements pour la rentrée scolaire': [
 
  ],
  'فعاليات العودة المدرسية': [
  ],
  'Fête du costume traditionnel': [
  ],
  'حفلة اللباس التقليدي': [
  ],
  'Fête du Mawlid An-Nabawi': [
  ],
  'حفلة يوم عيد المولد النبوي الشريف': [
  ],
  'Fête des mères': [
    'assets/images/Events/Fetemaman/0.png',
    'assets/images/Events/Fetemaman/Artboard 35@4x.png',
    'assets/images/Events/Fetemaman/Artboard 38@4x.png',
    'assets/images/Events/Fetemaman/Artboard 49@4x.png',
     'assets/images/Events/Fetemaman/Artboard 70@4x.png',
     'assets/images/Events/Fetemaman/Artboard 71@4x.png',
  ],
  'حفلة عيد الأمهات': [
    'assets/images/Events/Fetemaman/0.png',
    'assets/images/Events/Fetemaman/Artboard 35@4x.png',
    'assets/images/Events/Fetemaman/Artboard 38@4x.png',
    'assets/images/Events/Fetemaman/Artboard 49@4x.png',
     'assets/images/Events/Fetemaman/Artboard 70@4x.png',
     'assets/images/Events/Fetemaman/Artboard 71@4x.png',
  ],
  'Sortie éducative': [
   
  ],
  'رحلة تربوية': [
  
  ],
  'Fête des pères': [
  
  ],
  'حفلة عيد الآباء': [
  
  ],
};
  // Données des événements du JSON
  final List<EventData> eventDataList = [
    EventData(
      nomAr: 'حفل نهاية السنة',
      nomFr: 'La fête de fin d\'année',
      descriptionAr: 'احتفال مميز يجمع الأطفال وأولياءهم في أجواء مليئة بالعروض الفنية، والأناشيد، والرقصات، لعرض ما تعلمه الأطفال طوال العام ومشاركة لحظات الفخر والفرح.',
      descriptionFr: 'Une célébration spéciale réunissant les enfants et leurs parents dans une ambiance remplie de spectacles, chansons et danses, mettant en valeur les apprentissages de l\'année et partageant des moments de fierté et de joie.',
    ),
    EventData(
      nomAr: 'يوم اجتماع المربين والأولياء',
      nomFr: 'Journée réunion éducateurs-parents',
      descriptionAr: 'لقاء تفاعلي يجمع المربين بالأولياء بحضور مختصين، لمناقشة تطور الأطفال، وتبادل الآراء، وتقديم نصائح تربوية تعزز التعاون بين البيت والروضة.',
      descriptionFr: 'Une rencontre interactive réunissant éducateurs et parents en présence de spécialistes, pour discuter du développement des enfants, échanger des idées et partager des conseils éducatifs favorisant la coopération entre la maison et l\'école.',
    ),
    EventData(
      nomAr: 'اليوم المفتوح',
      nomFr: 'Journée porte ouverte',
      descriptionAr: 'فرصة لاستقبال العائلات والتعريف بفضاءات الروضة وبرامجها، من خلال جولات تعريفية وأنشطة مصغّرة تمنح الزائرين نظرة قريبة عن الحياة اليومية في الروضة.',
      descriptionFr: 'Une occasion d\'accueillir les familles et de présenter les espaces et programmes de l\'école, à travers des visites guidées et des activités miniatures offrant un aperçu de la vie quotidienne.',
    ),
    EventData(
      nomAr: 'فعاليات العودة المدرسية',
      nomFr: 'Événements pour la rentrée scolaire',
      descriptionAr: 'أنشطة ترحيبية مليئة بالمرح تهدف إلى كسر الجليد بين الأطفال، وتوطيد صداقاتهم، وتعريفهم بفضاءات الروضة، لضمان بداية دراسية مفعمة بالحماس.',
      descriptionFr: 'Des activités d\'accueil ludiques pour briser la glace entre les enfants, renforcer leurs amitiés et leur faire découvrir les espaces de l\'école, afin de démarrer l\'année avec enthousiasme.',
    ),
    EventData(
      nomAr: 'حفلة اللباس التقليدي',
      nomFr: 'Fête du costume traditionnel',
      descriptionAr: 'احتفال مبهج يرتدي فيه الأطفال الأزياء التقليدية، ويشاركون في أناشيد وألعاب وأنشطة تراثية تعرّفهم على ثقافة بلادهم بأسلوب ممتع ومرح.',
      descriptionFr: 'Une fête joyeuse où les enfants portent des tenues traditionnelles et participent à des chants, jeux et activités culturelles, leur faisant découvrir les traditions de leur pays de manière ludique et amusante.',
    ),
    EventData(
      nomAr: 'حفلة يوم عيد المولد النبوي الشريف',
      nomFr: 'Fête du Mawlid An-Nabawi',
      descriptionAr: 'احتفال ديني وثقافي بهيج يتعرّف فيه الأطفال على معاني المولد النبوي الشريف من خلال أناشيد وقصص وأنشطة رمزية، في أجواء مليئة بالبهجة والروحانية.',
      descriptionFr: 'Une célébration religieuse et culturelle joyeuse où les enfants découvrent la signification du Mawlid An-Nabawi à travers chants, récits et activités symboliques, dans une ambiance remplie de gaieté et de spiritualité.',
    ),
    EventData(
      nomAr: 'حفلة عيد الأمهات',
      nomFr: 'Fête des mères',
      descriptionAr: 'مناسبة خاصة يحتفل فيها الأطفال بأمهاتهم من خلال أناشيد، أشغال يدوية، وعروض صغيرة تعبّر عن المحبة والامتنان، لتكون لحظة دافئة ومؤثرة تجمع العائلة.',
      descriptionFr: 'Un événement spécial où les enfants célèbrent leurs mamans à travers chants, bricolages et petites représentations exprimant amour et gratitude, pour un moment chaleureux et émouvant en famille.',
    ),
    EventData(
      nomAr: 'رحلة تربوية',
      nomFr: 'Sortie éducative',
      descriptionAr: 'رحلة تعليمية واستكشافية تمنح الأطفال فرصة لاكتشاف الطبيعة، المتاحف، والمعالم الثقافية من خلال أنشطة ممتعة ومباشرة، تعزز فضولهم وتوسّع مداركهم خارج الفضاء المدرسي.',
      descriptionFr: 'Une sortie pédagogique et exploratoire offrant aux enfants l\'opportunité de découvrir la nature, les musées et les sites culturels à travers des activités ludiques et concrètes, stimulant leur curiosité et enrichissant leurs apprentissages en dehors de l\'école.',
    ),
    EventData(
      nomAr: 'حفلة عيد الآباء',
      nomFr: 'Fête des pères',
      descriptionAr: 'احتفال بهيج يقدّم فيه الأطفال أناشيد، أنشطة فنية، وأشغال يدوية بسيطة تعبيرًا عن الامتنان والحب لآبائهم، في أجواء دافئة تعكس الروابط العائلية.',
      descriptionFr: 'Un événement joyeux où les enfants offrent des chants, des activités artistiques et des bricolages simples en signe d\'amour et de gratitude pour leurs papas, dans une ambiance chaleureuse reflétant les liens familiaux.',
    ),
  ];
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