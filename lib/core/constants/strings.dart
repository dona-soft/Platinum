// General purpose constants

import 'package:platinum/core/errors/failures.dart';

const List<String> week = ['Sa', 'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr'];
const List<String> body_parts = [
  'icons/Shoulders.png',
  'icons/Chest.png',
  'icons/Arms.png',
  'icons/Waist.png',
  'icons/Abs.png',
  'icons/Tights.png',
  'icons/Leg.png',
];
const ABOUT_MAIN = ''
    'بالاتفاق بين نادي بلاتينوم وفريق دوناسوفت تم انشاء وتطوير هذا التطبيق'
    'التطبيق مصمم بواجهات عرض مسؤولة عن إظهار كل ما يحتاجه اللاعب المشترك في نادي بلاتينوم مثل:\n'
    '-إظهار اعلانات النادي من عروض وتخفيضات ومنتجات وغيرها.\n'
    '-عرض الرياضات والمدربين الموجودين ضمن النادي بالاضافة الى البرنامج التدريبي الخاص باللاعب.'
    '-يمكنك هذا التطبيق من متابعة اشتراكات الرياضات ومتابعة جميع مدفوعات اللاعب في النادي.\n'
    '-رصيد اللاعب الموجود في القائمة الرئيسية هو دليل الأقساط المتراكمة لكل اشتراك شهري.\n';
const ABOUT_COMPANY = ''
    'تم تطوير التطبيق من قبل فريق دوناسوفت في عام 2022\n'
    'جميع الحقوق محفوظة '
    'DONASOFT TEAM 2022'
    '';

//  Navigation
const R_SPLASH = '/splash';
const R_LOGIN = '/login';
const R_HOME = '/home';
const R_TRAINING = '/home/training';
const R_SPORT = '/home/sport';
const R_CALENDER = '/home/calender';
const R_PROFILE = '/home/profile';
const R_SUBS = '/home/profile/subs';
const R_ABOUT = '/home/profile/about';
const R_PAYMENT = '/home/profile/payment';

//  Banners
const trainingBanner = 'Training Days';
const offersBanner = 'Offers';

// DataBase name
const PLAYER_DATABASE = 'Playerdb.db';

// DataBase Tables
const PLAYER_STATS_TABLE = 'PlayerStats';
const OFFERS_TABLE = 'Offers';
const SPORTS_TABLE = 'Sports';
const TRAINERS_TABLE = 'Trainers';
const TRAININGS_TABLE = 'Trainings';
const PROGRAMS_TABLE = 'Programs';
const TRAINING_RESOURCE_TABLE = 'trainingResource';
const PAYMENTS_TABLE = 'Payments';
const METRICS_TABLE = 'Status';

// http Api Urls
const HTTP_PLAYER_URL = 'https://platinum.dona-soft.com/api/player/view';
const HTTP_PLAYER_REGISTER = 'https://platinum.dona-soft.com/api/register';
const HTTP_PLAYER_LOGIN = 'https://platinum.dona-soft.com/api/login';
const HTTP_PLAYER_LOGOUT = 'https://platinum.dona-soft.com/api/logout';
const HTTP_PLAYER_METRICS = 'https://platinum.dona-soft.com/api/player/metrics';
const HTTP_PLAYER_PROGRAM = 'https://platinum.dona-soft.com/api/player/program';
const HTTP_PLAYER_OFFERS = 'https://platinum.dona-soft.com/api/Offers';
const HTTP_PLAYER_SPORTS = 'https://platinum.dona-soft.com/api/Sports';
const HTTP_TRAINERS = 'https://platinum.dona-soft.com/api/Trainers';
const HTTP_PLAYER_TRAININGS =
    'https://platinum.dona-soft.com/api/player/training';
const HTTP_PLAYER_PAYMENTS =
    'https://platinum.dona-soft.com/api/player/payment';

// Emotions
const ANGRY = r'ಠ╭╮ಠ';
const WTF = r'ಠ_ಠ';
const DONT_KNOW = r'¯\_(ツ)_/¯';

String mapFailureToMessege(Failure fail) {
  switch (fail.runtimeType) {
    case ServerFailure:
      return '!تأكد من اتصال الانترنت';
    case OfflineFailure:
      return '!لا يوجد اتصال بالانترنت';
    case EmptyCacheFailure:
      return '!لا يوجد بيانات لعرضها';
    default:
      return 'حدث خطأ';
  }
}
