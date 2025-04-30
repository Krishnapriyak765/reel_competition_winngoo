import 'package:go_router/go_router.dart';
import 'package:reels_application/auth/login/login_page.dart';
import 'package:reels_application/auth/register/register_create_acc.dart';
import 'package:reels_application/auth/register/register_payment.dart';
import 'package:reels_application/auth/register/register_personal_info.dart';
import 'package:reels_application/presentation/compatition/competition_page.dart';
import 'package:reels_application/presentation/dashboard/competition_rules.dart';
import 'package:reels_application/presentation/dashboard/home_nav.dart';
import 'package:reels_application/presentation/dashboard/profile.dart';
import 'package:reels_application/presentation/dashboard/refferral_page.dart';
import 'package:reels_application/presentation/dashboard/upload_video.dart';
import 'package:reels_application/presentation/onboarding/onboarding_page1.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'OnboardingPage',
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => CreateAccountPage(),
    ),
    GoRoute(
      path: '/homewithnav',
      name: 'homewithnav',
      builder: (context, state) => HomeScreenWithNav(),
    ),
    GoRoute(
      path: '/uploadvideo',
      name: 'UploadVideoPage',
      builder: (context, state) => UploadVideoScreen(),
    ),
    GoRoute(
      path: '/competition',
      name: 'CompetitionPage',
      builder: (context, state) => CompetitionPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'Profile',
      builder: (context, state) => MembershipInfoPage(),
    ),
    GoRoute(
      path: '/refferal',
      name: 'RefferalPage',
      builder: (context, state) => ReferralHistoryPage(),
    ),
    // GoRoute(
    //   path: '/createaccount',
    //   name: 'CreateAccount',
    //   builder: (context, state) => CreateAccountPage(),
    // ),
    GoRoute(
      path: '/payment',
      name: 'PaymentDetailsPage',
      builder: (context, state) => PaymentDetailsPage(newsignupData: {}),
    ),
    GoRoute(
      path: '/regpersnalinfo',
      name: 'RegPersonalInfo',
      builder: (context, state) => PersonalInfoForm(signupData: {}),
    ),
    GoRoute(
      path: '/competionRule',
      name: 'competionRule',
      builder: (context, state) => CompetitionRulesPage(),
    ),
  ],
);
