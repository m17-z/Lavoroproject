// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:lavoro/app/modules/Setting/setting.dart';

import 'package:lavoro/app/modules/auth/bindings/register_banding_company.dart';

import 'package:lavoro/app/modules/home/views/Job_view.dart';
import 'package:lavoro/app/modules/jobs/view/all_jobs_view.dart';
import 'package:lavoro/app/modules/user_profile/widgets/edit_information.dart';

import '../modules/auth/bindings/register_binding_employe.dart';
import '../modules/auth/bindings/signin_binding.dart';
import '../modules/auth/bindings/signup_binding.dart';
import '../modules/auth/views/register_view_Company.dart';
import '../modules/auth/views/register_view_Employee.dart';
import '../modules/auth/views/signin_view.dart';
import '../modules/auth/views/signup_view.dart';

import '../modules/emp_home/bindings/emp_home_binding.dart';
import '../modules/emp_home/views/emp_home_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/job_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/info.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';

import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

import '../modules/splash/views/splash_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/view/edit_info.dart';
import '../modules/user_profile/view/user_profile_view.dart';


// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EMPHOME,
      page: () => const EmpHomeView(),
      binding: EmpHomeBinding(),
    ),
    GetPage(
      name: _Paths.INFO_PAGE,
      page: () => InfoPage(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_INFO,
      page: () =>  EditProfileInformation(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    // GetPage(
    //   name: _Paths.,
    //   page: () => const OnBoardingView(),
    //   binding: OnBoardingBinding(),
    // ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RegisterEmplyee,
      page: () => const RegisterViewEmployee(),
      binding: RegisterBindingEmployee(),
    ),
    GetPage(
      name: _Paths.RegisterCompany,
      page: () => const RegisterViewCompany(),
      binding: RegisterBindingCompany(),
    ),
    // GetPage(
    //   name: _Paths.OTP,
    //   page: () => const OtpView(),
    //   binding: OtpBinding(),
    // ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => UserProfileView(
        isnotuser: false,
      ),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.JOB,
      page: () => const JobView(),
      binding: JobBinding(),
    ),
    GetPage(
      name: _Paths.ALLJOBS,
      page: () =>  AllJobsView(),
      binding: JobBinding(),
    ),
     GetPage(
      name: _Paths.SETTINGS,
      page: () =>  SettingsPage(),
     
    ),
  ];
}
