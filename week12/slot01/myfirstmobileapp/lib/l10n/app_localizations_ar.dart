// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get loginPage => 'صفحة تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get showPasswordSwitch => 'إظهار كلمة المرور';

  @override
  String get myFirstPage => 'صفحتي الأولى';

  @override
  String get myFirstPageBody => 'هذا هو محتوى الصفحة';

  @override
  String get goToSecondPageButton => 'اذهب إلى الصفحة الثانية';
}
