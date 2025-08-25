import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Text on the button that begins the process
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get get_started;

  /// Description text encouraging the user to start riding with a fair price
  ///
  /// In en, this message translates to:
  /// **'Start Riding with Fare Price!'**
  String get start_riding_with_fare_price;

  /// Instruction to launch the rider app to begin the user's journey
  ///
  /// In en, this message translates to:
  /// **'Launch the rider app to begin\nyour journey!'**
  String get launch_the_rider_app;

  /// Title for the language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Text shown when the user selects a language
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// Heading text shown on the phone input screen
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started!'**
  String get lets_get_started;

  /// Subheading text shown under the title in the phone input screen
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to begin'**
  String get enter_phone_number;

  /// Placeholder for the phone number input field
  ///
  /// In en, this message translates to:
  /// **'(571) 289-3329'**
  String get phone_number_hint;

  /// Text on the button that proceeds to the next step
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Text for the country selector button
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get country_selector;

  /// Title text encouraging users to stay updated
  ///
  /// In en, this message translates to:
  /// **'Never miss an update'**
  String get never_miss_an_update;

  /// Description explaining the benefits of staying updated with real-time driver updates
  ///
  /// In en, this message translates to:
  /// **'Receive real-time driver updates, along with exclusive deals and tailored discounts, all designed to make your journey smoother and more rewarding. Stay informed and enjoy the benefits every time you ride!'**
  String get receive_real_time_driver_updates;

  /// Button text to allow notifications
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// Description for the image shown on the screen related to the app update
  ///
  /// In en, this message translates to:
  /// **'Image representing app updates'**
  String get app_update_image_description;

  /// Heading text instructing the user to enter the OTP code
  ///
  /// In en, this message translates to:
  /// **'Enter Your Code'**
  String get enter_your_code;

  /// Message indicating the phone number where the OTP was sent
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a code to'**
  String get we_sent_code_to;

  /// Message instructing the user to enter the OTP code
  ///
  /// In en, this message translates to:
  /// **'Please enter it below to verify your number'**
  String get please_enter_to_verify;

  /// Error message when the OTP field is left empty
  ///
  /// In en, this message translates to:
  /// **'Enter your pin code'**
  String get enter_your_pin_code;

  /// Text on the button to verify the OTP
  ///
  /// In en, this message translates to:
  /// **'Verify Now'**
  String get verify_now;

  /// Message shown to users who haven't received the OTP yet
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive code?'**
  String get did_not_receive_code;

  /// Text for the button to resend the OTP
  ///
  /// In en, this message translates to:
  /// **'Resend it'**
  String get resend_it;

  /// The time format when the OTP timer expires
  ///
  /// In en, this message translates to:
  /// **'00:00'**
  String get timer_expired;

  /// Title asking who's riding
  ///
  /// In en, this message translates to:
  /// **'Who\'s riding today?'**
  String get who_is_riding_today;

  /// Description text regarding driver verification
  ///
  /// In en, this message translates to:
  /// **'Your driver will verify your name upon arrival'**
  String get your_driver_will_verify_name;

  /// Label for first name input field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// Label for last name input field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// Label for email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Error message when first name is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get please_enter_first_name;

  /// Error message when last name is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get please_enter_last_name;

  /// Error message when email is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get please_enter_email;

  /// Text showing terms and conditions agreement
  ///
  /// In en, this message translates to:
  /// **'By continuing, I agree that Rydr may collect, use, and share the information I provide in accordance with the Privacy Policy. I also confirm that I have read, understood, and agree to the Terms & Conditions'**
  String get terms_and_conditions;

  /// Clickable text for privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// Clickable text for terms and conditions
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_conditions;

  /// Title for snackbar when terms are not agreed
  ///
  /// In en, this message translates to:
  /// **'Terms Required'**
  String get terms_required;

  /// Message for snackbar when user hasn't agreed to terms
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Conditions to continue'**
  String get please_agree_terms;

  /// Placeholder text for the destination search input field
  ///
  /// In en, this message translates to:
  /// **'Where are you headed?'**
  String get where_are_you_headed;

  /// Morning greeting message displayed to the user
  ///
  /// In en, this message translates to:
  /// **'Good Morning, {userName}'**
  String good_morning_user(String userName);

  /// Tab label for recent rides section
  ///
  /// In en, this message translates to:
  /// **'Recent Rides'**
  String get recent_rides;

  /// Tab label for saved locations section
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// Tab label for airport locations section
  ///
  /// In en, this message translates to:
  /// **'Airport'**
  String get airport;

  /// Tab label for attraction locations section
  ///
  /// In en, this message translates to:
  /// **'Attraction'**
  String get attraction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
