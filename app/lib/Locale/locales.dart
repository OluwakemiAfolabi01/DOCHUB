import 'package:flutter/material.dart';
import 'package:dochub/Config/app_config.dart';
import 'package:dochub/Locale/Language/english.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;


class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
  };

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get nameValidation {
    return _localizedValues[locale.languageCode]!['nameValidation'];
  }
  String? get password {
    return _localizedValues[locale.languageCode]!['password'];
  }

  String? get terms {
    return _localizedValues[locale.languageCode]!['terms'];
  }

  String? get privacyPolicy {
    return _localizedValues[locale.languageCode]!['privacyPolicy'];
  }

  String? get reschedule {
    return _localizedValues[locale.languageCode]!['reschedule'];
  }

  String? get aboutUs {
    return _localizedValues[locale.languageCode]!['aboutUs'];
  }

  String? get shareAppWith {
    return _localizedValues[locale.languageCode]!['shareAppWith'];
  }

  String? get usually {
    return _localizedValues[locale.languageCode]!['usually'];
  }

  String? get bookVisit {
    return _localizedValues[locale.languageCode]!['bookVisit'];
  }

  String? get forgot {
    return _localizedValues[locale.languageCode]!['forgot'];
  }

  String? get recent {
    return _localizedValues[locale.languageCode]!['recent'];
  }

  String? get nearerPlace {
    return _localizedValues[locale.languageCode]!['nearerPlace'];
  }

  String? get quickLinks {
    return _localizedValues[locale.languageCode]!['quickLinks'];
  }

  String? get forgotPassword {
    return _localizedValues[locale.languageCode]!['forgotPassword'];
  }

  String? get newUser {
    return _localizedValues[locale.languageCode]!['newUser'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get signIn {
    return _localizedValues[locale.languageCode]!['signIn'];
  }

  String? get signInToYourAccount {
    return _localizedValues[locale.languageCode]!['signInToYourAccount'];
  }

  String? get signUp {
    return _localizedValues[locale.languageCode]!['signUp'];
  }

  String? get createYourAccount {
    return _localizedValues[locale.languageCode]!['createYourAccount'];
  }

  String? get createPassword {
    return _localizedValues[locale.languageCode]!['createPassword'];
  }

  String? get relaxItWillTakeMin {
    return _localizedValues[locale.languageCode]!['relaxItWillTakeMin'];
  }

  String? get enter10Digit {
    return _localizedValues[locale.languageCode]!['enter10Digit'];
  }

  String? get addPhoneNumber {
    return _localizedValues[locale.languageCode]!['addPhoneNumber'];
  }

  String? get next {
    return _localizedValues[locale.languageCode]!['next'];
  }

  String? get searchLocation {
    return _localizedValues[locale.languageCode]!['searchLocation'];
  }

  String? get selectCurrentLocation {
    return _localizedValues[locale.languageCode]!['selectCurrentLocation'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]!['location'];
  }

  String? get bookAnAppointment {
    return _localizedValues[locale.languageCode]!['bookAnAppointment'];
  }

  String? get home {
    return _localizedValues[locale.languageCode]!['home'];
  }

  String? get apps {
    return _localizedValues[locale.languageCode]!['apps'];
  }

  String? get chats {
    return _localizedValues[locale.languageCode]!['chats'];
  }

  String? get account {
    return _localizedValues[locale.languageCode]!['account'];
  }

  String? get chatWithDoctor {
    return _localizedValues[locale.languageCode]!['chatWithDoctor'];
  }

  String? get bookScanTest {
    return _localizedValues[locale.languageCode]!['bookScanTest'];
  }

  String? get findMedicals {
    return _localizedValues[locale.languageCode]!['findMedicals'];
  }

  String? get getFreeConsult {
    return _localizedValues[locale.languageCode]!['getFreeConsult'];
  }

  String? get newpassword {
    return _localizedValues[locale.languageCode]!['newpassword'];
  }

  String? get codeValidation {
    return _localizedValues[locale.languageCode]!['codeValidation'];
  }

  String? get emailresetcode {
    return _localizedValues[locale.languageCode]!['emailresetcode'];
  }

  String? get passwordmismatch {
    return _localizedValues[locale.languageCode]!['passwordmismatch'];
  }

  String? get connectwithpatients {
    return _localizedValues[locale.languageCode]!['connectwithpatients'];
  }

  String? get findTrusted {
    return _localizedValues[locale.languageCode]!['findTrusted'];
  }

  String? get getAQuickList {
    return _localizedValues[locale.languageCode]!['getAQuickList'];
  }

  String? get findDoctor {
    return _localizedValues[locale.languageCode]!['findDoctor'];
  }

  String? get doctorsSpecialists {
    return _localizedValues[locale.languageCode]!['doctorsSpecialists'];
  }

  String? get recentSearches {
    return _localizedValues[locale.languageCode]!['recentSearches'];
  }

  String? get clearHistory {
    return _localizedValues[locale.languageCode]!['clearHistory'];
  }

  String? get cardiologist {
    return _localizedValues[locale.languageCode]!['cardiologist'];
  }

  String? get cardiovascular {
    return _localizedValues[locale.languageCode]!['cardiovascular'];
  }

  String? get doctors {
    return _localizedValues[locale.languageCode]!['doctors'];
  }

  String? get dentists {
    return _localizedValues[locale.languageCode]!['dentists'];
  }

  String? get therapistsAnd {
    return _localizedValues[locale.languageCode]!['therapistsAnd'];
  }

  String? get allergistsCardiologists {
    return _localizedValues[locale.languageCode]!['allergistsCardiologists'];
  }

  String? get dentistsProstho {
    return _localizedValues[locale.languageCode]!['dentistsProstho'];
  }

  String? get ayurvedaHomeopathy {
    return _localizedValues[locale.languageCode]!['ayurvedaHomeopathy'];
  }

  String? get acupunchuristPhysio {
    return _localizedValues[locale.languageCode]!['acupunchuristPhysio'];
  }

  String? get topSpecialities {
    return _localizedValues[locale.languageCode]!['topSpecialities'];
  }

  String? get listSpecialities {
    return _localizedValues[locale.languageCode]!['listSpecialities'];
  }

  String? get opthalmologist {
    return _localizedValues[locale.languageCode]!['opthalmologist'];
  }

  String? get dermatologist {
    return _localizedValues[locale.languageCode]!['dermatologist'];
  }

  String? get gynecologist {
    return _localizedValues[locale.languageCode]!['gynecologist'];
  }

  String? get neonatologist {
    return _localizedValues[locale.languageCode]!['neonatologist'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get filter {
    return _localizedValues[locale.languageCode]!['filter'];
  }

  String? get resultsFound {
    return _localizedValues[locale.languageCode]!['resultsFound'];
  }

  String? get viewInMap {
    return _localizedValues[locale.languageCode]!['viewInMap'];
  }

  String? get book {
    return _localizedValues[locale.languageCode]!['book'];
  }

  String? get experience {
    return _localizedValues[locale.languageCode]!['experience'];
  }

  String? get fees {
    return _localizedValues[locale.languageCode]!['fees'];
  }

  String? get feedback {
    return _localizedValues[locale.languageCode]!['feedback'];
  }

  String? get mapView {
    return _localizedValues[locale.languageCode]!['mapView'];
  }

  String? get reset {
    return _localizedValues[locale.languageCode]!['reset'];
  }

  String? get consultancyFees {
    return _localizedValues[locale.languageCode]!['consultancyFees'];
  }

  String? get ratings {
    return _localizedValues[locale.languageCode]!['ratings'];
  }

  String? get sortBy {
    return _localizedValues[locale.languageCode]!['sortBy'];
  }

  String? get gender {
    return _localizedValues[locale.languageCode]!['gender'];
  }

  String? get male {
    return _localizedValues[locale.languageCode]!['male'];
  }

  String? get female {
    return _localizedValues[locale.languageCode]!['female'];
  }

  String? get applyNow {
    return _localizedValues[locale.languageCode]!['applyNow'];
  }

  String? get about {
    return _localizedValues[locale.languageCode]!['about'];
  }

  String? get overview {
    return _localizedValues[locale.languageCode]!['overview'];
  }

  String? get availablity {
    return _localizedValues[locale.languageCode]!['availablity'];
  }

  String? get availableAt {
    return _localizedValues[locale.languageCode]!['availableAt'];
  }

  String? get address {
    return _localizedValues[locale.languageCode]!['address'];
  }

  String? get services {
    return _localizedValues[locale.languageCode]!['services'];
  }

  String? get specialization {
    return _localizedValues[locale.languageCode]!['specialization'];
  }

  String? get alsoPracticesAt {
    return _localizedValues[locale.languageCode]!['alsoPracticesAt'];
  }

  String? get availableTimings {
    return _localizedValues[locale.languageCode]!['availableTimings'];
  }

  String? get bookAppointmentNow {
    return _localizedValues[locale.languageCode]!['bookAppointmentNow'];
  }

  String? get updateAppointment {
    return _localizedValues[locale.languageCode]!['updateAppointment'];
  }

  String? get overall {
    return _localizedValues[locale.languageCode]!['overall'];
  }

  String? get typeMessage {
    return _localizedValues[locale.languageCode]!['typemessage'];
  }

  String? get visitedFor {
    return _localizedValues[locale.languageCode]!['visitedFor'];
  }

  String? get giveFeedback {
    return _localizedValues[locale.languageCode]!['giveFeedback'];
  }

  String? get selectDateTime {
    return _localizedValues[locale.languageCode]!['selectDateTime'];
  }

  String? get at {
    return _localizedValues[locale.languageCode]!['at'];
  }

  String? get availableTimes {
    return _localizedValues[locale.languageCode]!['availableTimes'];
  }

  String? get appointmentFor {
    return _localizedValues[locale.languageCode]!['appointmentFor'];
  }

  String? get confirmAppointment {
    return _localizedValues[locale.languageCode]!['confirmAppointment'];
  }

  String? get overallExperience {
    return _localizedValues[locale.languageCode]!['overallExperience'];
  }

  String? get visitedDoctorfor {
    return _localizedValues[locale.languageCode]!['visitedDoctorfor'];
  }

  String? get egHeart {
    return _localizedValues[locale.languageCode]!['egHeart'];
  }

  String? get howWasExperience {
    return _localizedValues[locale.languageCode]!['howWasExperience'];
  }

  String? get writeYourexperience {
    return _localizedValues[locale.languageCode]!['writeYourexperience'];
  }

  String? get submitFeedback {
    return _localizedValues[locale.languageCode]!['submitFeedback'];
  }

  String? get askDoctor {
    return _localizedValues[locale.languageCode]!['askDoctor'];
  }

  String? get describleYourIssue {
    return _localizedValues[locale.languageCode]!['describleYourIssue'];
  }

  String? get treatmentType {
    return _localizedValues[locale.languageCode]!['treatmentType'];
  }

  String? get title {
    return _localizedValues[locale.languageCode]!['title'];
  }

  String? get tapToaddTitle {
    return _localizedValues[locale.languageCode]!['tapToaddTitle'];
  }

  String? get describeIssue {
    return _localizedValues[locale.languageCode]!['describeIssue'];
  }

  String? get fileAttchment {
    return _localizedValues[locale.languageCode]!['fileAttchment'];
  }

  String? get uploadFile {
    return _localizedValues[locale.languageCode]!['uploadFile'];
  }

  String? get submitQuestion {
    return _localizedValues[locale.languageCode]!['submitQuestion'];
  }

  String? get labsAndTests {
    return _localizedValues[locale.languageCode]!['labsAndTests'];
  }

  String? get searchForTests {
    return _localizedValues[locale.languageCode]!['searchForTests'];
  }

  String? get labsInfo {
    return _localizedValues[locale.languageCode]!['labsInfo'];
  }

  String? get timings {
    return _localizedValues[locale.languageCode]!['timings'];
  }

  String? get getDirection {
    return _localizedValues[locale.languageCode]!['getDirection'];
  }

  String? get facilities {
    return _localizedValues[locale.languageCode]!['facilities'];
  }

  String? get parkingNotAvailable {
    return _localizedValues[locale.languageCode]!['parkingNotAvailable'];
  }

  String? get eReports {
    return _localizedValues[locale.languageCode]!['eReports'];
  }

  String? get cardAccepted {
    return _localizedValues[locale.languageCode]!['cardAccepted'];
  }

  String? get prescriptionPickup {
    return _localizedValues[locale.languageCode]!['prescriptionPickup'];
  }

  String? get reportDoorstep {
    return _localizedValues[locale.languageCode]!['reportDoorstep'];
  }

  String? get parkingNotAv {
    return _localizedValues[locale.languageCode]!['parkingNotAv'];
  }

  String? get message {
    return _localizedValues[locale.languageCode]!['message'];
  }

  String? get search {
    return _localizedValues[locale.languageCode]!['search'];
  }

  String? get searchTest {
    return _localizedValues[locale.languageCode]!['searchTest'];
  }

  String? get medicalShops {
    return _localizedValues[locale.languageCode]!['medicalShops'];
  }

  String? get open {
    return _localizedValues[locale.languageCode]!['open'];
  }

  String? get openNow {
    return _localizedValues[locale.languageCode]!['openNow'];
  }

  String? get myAppointments {
    return _localizedValues[locale.languageCode]!['myAppointments'];
  }

  String? get upcomingAppointments {
    return _localizedValues[locale.languageCode]!['upcomingAppointments'];
  }

  String? get pastAppointments {
    return _localizedValues[locale.languageCode]!['pastAppointments'];
  }

  String? get appointmentDetail {
    return _localizedValues[locale.languageCode]!['appointmentDetail'];
  }

  String? get cancel {
    return _localizedValues[locale.languageCode]!['cancel'];
  }

  String? get appointmentDateTime {
    return _localizedValues[locale.languageCode]!['appointmentDateTime'];
  }

  String? get in3Days {
    return _localizedValues[locale.languageCode]!['in3Days'];
  }

  String? get appointmentBookedFor {
    return _localizedValues[locale.languageCode]!['appointmentBookedFor'];
  }

  String? get appointmentNumber {
    return _localizedValues[locale.languageCode]!['appointmentNumber'];
  }

  String? get justForRef {
    return _localizedValues[locale.languageCode]!['justForRef'];
  }

  String? get yesSure {
    return _localizedValues[locale.languageCode]!['yesSure'];
  }

  String? get keepaway {
    return _localizedValues[locale.languageCode]!['keepaway'];
  }

  String? get okayMam {
    return _localizedValues[locale.languageCode]!['okayMam'];
  }

  String? get yourTestReport {
    return _localizedValues[locale.languageCode]!['yourTestReport'];
  }

  String? get helloDoctor {
    return _localizedValues[locale.languageCode]!['helloDoctor'];
  }

  String? get helloHowMay {
    return _localizedValues[locale.languageCode]!['helloHowMay'];
  }

  String? get thankYouActually {
    return _localizedValues[locale.languageCode]!['thankYouActually'];
  }

  String? get writeYourMessage {
    return _localizedValues[locale.languageCode]!['writeYourMessage'];
  }

  String? get myAccount {
    return _localizedValues[locale.languageCode]!['myAccount'];
  }

  String? get completeProfile {
    return _localizedValues[locale.languageCode]!['completeProfile'];
  }

  String? get myFeedbacks {
    return _localizedValues[locale.languageCode]!['myFeedbacks'];
  }

  String? get healthBlogs {
    return _localizedValues[locale.languageCode]!['healthBlogs'];
  }

  String? get aboutDoctohub {
    return _localizedValues[locale.languageCode]!['aboutDoctohub'];
  }

  String? get tnc {
    return _localizedValues[locale.languageCode]!['tnc'];
  }

  String? get helpSupport {
    return _localizedValues[locale.languageCode]!['helpSupport'];
  }

  String? get shareApp {
    return _localizedValues[locale.languageCode]!['shareApp'];
  }

  String? get listOfFeedbacks {
    return _localizedValues[locale.languageCode]!['listOfFeedbacks'];
  }

  String? get readArticles {
    return _localizedValues[locale.languageCode]!['readArticles'];
  }

  String? get companyDetails {
    return _localizedValues[locale.languageCode]!['companyDetails'];
  }

  String? get termsPrivacy {
    return _localizedValues[locale.languageCode]!['termsPrivacy'];
  }

  String? get letUsknowQuery {
    return _localizedValues[locale.languageCode]!['letUsknowQuery'];
  }

  String? get myProfile {
    return _localizedValues[locale.languageCode]!['myProfile'];
  }

  String? get emailId {
    return _localizedValues[locale.languageCode]!['emailId'];
  }

  String? get emailValidation {
    return _localizedValues[locale.languageCode]!['emailValidation'];
  }

  String? get passwordValidation {
    return _localizedValues[locale.languageCode]!['passwordValidation'];
  }

  String? get dob {
    return _localizedValues[locale.languageCode]!['DOB'];
  }

  String? get height {
    return _localizedValues[locale.languageCode]!['height'];
  }

  String? get weight {
    return _localizedValues[locale.languageCode]!['weight'];
  }

  String? get bloodgroup {
    return _localizedValues[locale.languageCode]!['bloodgroup'];
  }

  String? get updateProfile {
    return _localizedValues[locale.languageCode]!['updateProfile'];
  }

  String? get getRidOf {
    return _localizedValues[locale.languageCode]!['getRidOf'];
  }

  String? get sixbest {
    return _localizedValues[locale.languageCode]!['sixbest'];
  }

  String? get tenPowerful {
    return _localizedValues[locale.languageCode]!['tenPowerful'];
  }

  String? get didYouKnow {
    return _localizedValues[locale.languageCode]!['didYouKnow'];
  }

  String? get dental {
    return _localizedValues[locale.languageCode]!['dental'];
  }

  String? get hairCare {
    return _localizedValues[locale.languageCode]!['hairCare'];
  }

  String? get foodnhealth {
    return _localizedValues[locale.languageCode]!['foodnhealth'];
  }

  String? get skinCare {
    return _localizedValues[locale.languageCode]!['skinCare'];
  }

  String? get letUsknowYourIssue {
    return _localizedValues[locale.languageCode]!['letUsknowYourIssue'];
  }

  String? get issueRegarding {
    return _localizedValues[locale.languageCode]!['issueRegarding'];
  }

  String? get describeYourIssue {
    return _localizedValues[locale.languageCode]!['describeYourIssue'];
  }

  String? get sendMessage {
    return _localizedValues[locale.languageCode]!['sendMessage'];
  }

  String? get preferences {
    return _localizedValues[locale.languageCode]!['preferences'];
  }

  String? get notificationSetting {
    return _localizedValues[locale.languageCode]!['notificationSetting'];
  }

  String? get appointments {
    return _localizedValues[locale.languageCode]!['appointments'];
  }

  String? get offersUpdates {
    return _localizedValues[locale.languageCode]!['offersUpdates'];
  }

  String? get general {
    return _localizedValues[locale.languageCode]!['general'];
  }

  String? get profileEdit {
    return _localizedValues[locale.languageCode]!['profileEdit'];
  }

  String? get doctoHubWebsite {
    return _localizedValues[locale.languageCode]!['doctoHubWebsite'];
  }

  String? get rateDoctohub {
    return _localizedValues[locale.languageCode]!['rateDoctohub'];
  }

  String? get areYouDoctor {
    return _localizedValues[locale.languageCode]!['areYouDoctor'];
  }

  String? get soundsAppointments {
    return _localizedValues[locale.languageCode]!['soundsAppointments'];
  }

  String? get soundChat {
    return _localizedValues[locale.languageCode]!['soundChat'];
  }

  String? get soundOffers {
    return _localizedValues[locale.languageCode]!['soundOffers'];
  }

  String? get callNow {
    return _localizedValues[locale.languageCode]!['callNow'];
  }

  String? get testsAvailable {
    return _localizedValues[locale.languageCode]!['testsAvailable'];
  }

  String? get startTime {
    return _localizedValues[locale.languageCode]!['startTime'];
  }

  String? get endTime {
    return _localizedValues[locale.languageCode]!['endTime'];
  }

  String? get thisWeek {
    return _localizedValues[locale.languageCode]!['thisWeek'];
  }

  String? get thisMonth {
    return _localizedValues[locale.languageCode]!['thisMonth'];
  }

  String? get help {
    return _localizedValues[locale.languageCode]!['help'];
  }

  String? get morning {
    return _localizedValues[locale.languageCode]!['morning'];
  }

  String? get afternoon {
    return _localizedValues[locale.languageCode]!['afternoon'];
  }

  String? get evening {
    return _localizedValues[locale.languageCode]!['evening'];
  }

  String? get night {
    return _localizedValues[locale.languageCode]!['night'];
  }

  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }

  String? get resend {
    return _localizedValues[locale.languageCode]!['resend'];
  }

  String? get distance {
    return _localizedValues[locale.languageCode]!['distance'];
  }

  String? get viewAll {
    return _localizedValues[locale.languageCode]!['viewAll'];
  }

  String? get offers {
    return _localizedValues[locale.languageCode]!['offers'];
  }

  String? get datetime {
    return _localizedValues[locale.languageCode]!['datetime'];
  }

  String? get more {
    return _localizedValues[locale.languageCode]!['more'];
  }

  String? get register {
    return _localizedValues[locale.languageCode]!['register'];
  }

  String? get reviews {
    return _localizedValues[locale.languageCode]!['reviews'];
  }

  String? get viewMore {
    return _localizedValues[locale.languageCode]!['viewMore'];
  }

  String? get rateNow {
    return _localizedValues[locale.languageCode]!['rateNow'];
  }

  String? get readAll {
    return _localizedValues[locale.languageCode]!['readAll'];
  }

  String? get viewProfile {
    return _localizedValues[locale.languageCode]!['viewProfile'];
  }

  String? get rating {
    return _localizedValues[locale.languageCode]!['rating'];
  }

  String? get selectDateAndTime {
    return _localizedValues[locale.languageCode]!['selectDateAndTime'];
  }

  String? get profile {
    return _localizedValues[locale.languageCode]!['profile'];
  }

  String? get sun {
    return _localizedValues[locale.languageCode]!['sun'];
  }

  String? get mon {
    return _localizedValues[locale.languageCode]!['mon'];
  }

  String? get tue {
    return _localizedValues[locale.languageCode]!['tue'];
  }

  String? get wed {
    return _localizedValues[locale.languageCode]!['wed'];
  }

  String? get thr {
    return _localizedValues[locale.languageCode]!['thr'];
  }

  String? get fri {
    return _localizedValues[locale.languageCode]!['fri'];
  }

  String? get sat {
    return _localizedValues[locale.languageCode]!['sat'];
  }

  String? get lorem {
    return _localizedValues[locale.languageCode]!['lorem'];
  }

  String? get phoneNumber {
    return _localizedValues[locale.languageCode]!['phoneNumber'];
  }

  String? get phoneValidation {
    return _localizedValues[locale.languageCode]!['phoneValidation'];
  }

  String? get addressValidation {
    return _localizedValues[locale.languageCode]!['addressValidation'];
  }

  String? get countryValidation {
    return _localizedValues[locale.languageCode]!['counutryValidation'];
  }

  String? get stateValidation {
    return _localizedValues[locale.languageCode]!['stateValidation'];
  }

  String? get heightValidation {
    return _localizedValues[locale.languageCode]!['heightValidation'];
  }

  String? get weightValidation {
    return _localizedValues[locale.languageCode]!['weightValidation'];
  }

  String? get state {
    return _localizedValues[locale.languageCode]!['state'];
  }

  String? get country {
    return _localizedValues[locale.languageCode]!['country'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get myDoctor {
    return _localizedValues[locale.languageCode]!['myDoctor'];
  }

  String? get myPatient {
    return _localizedValues[locale.languageCode]!['myPatient'];
  }
  String? get myMedication {
    return _localizedValues[locale.languageCode]!['myMedication'];
  }

  String? get selectLanguage {
    return _localizedValues[locale.languageCode]!['selectLanguage'];
  }

  String? get indonesia {
    return _localizedValues[locale.languageCode]!['indonesian'];
  }

  String? get italy {
    return _localizedValues[locale.languageCode]!['italian'];
  }

  String? get spansh {
    return _localizedValues[locale.languageCode]!['spanish'];
  }

  String? get arab {
    return _localizedValues[locale.languageCode]!['arabic'];
  }

  String? get frnch {
    return _localizedValues[locale.languageCode]!['french'];
  }

  String? get prtguese {
    return _localizedValues[locale.languageCode]!['portuguese'];
  }

  String? get swahilii {
    return _localizedValues[locale.languageCode]!['swahili'];
  }

  String? get eng {
    return _localizedValues[locale.languageCode]!['english'];
  }

  String? get turk {
    return _localizedValues[locale.languageCode]!['turkish'];
  }

  static List<Locale> getSupportedLocales() {
    List<Locale> toReturn = [];
    for (String langCode in AppConfig.languagesSupported.keys) {
      toReturn.add(Locale(langCode));
    }
    return toReturn;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppConfig.languagesSupported.keys.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
