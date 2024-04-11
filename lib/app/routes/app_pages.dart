import 'package:get/get.dart';

import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_profile/bindings/admin_profile_binding.dart';
import '../modules/admin_profile/views/admin_profile_view.dart';
import '../modules/agency/bindings/agency_binding.dart';
import '../modules/agency/views/agency_view.dart';
import '../modules/all_buses/bindings/all_buses_binding.dart';
import '../modules/all_buses/views/all_buses_view.dart';
import '../modules/bookings/bindings/bookings_binding.dart';
import '../modules/bookings/views/bookings_view.dart';
import '../modules/bus/bindings/bus_binding.dart';
import '../modules/bus/views/bus_view.dart';
import '../modules/bus_detail/bindings/bus_detail_binding.dart';
import '../modules/bus_detail/views/bus_detail_view.dart';
import '../modules/detail_category/bindings/detail_category_binding.dart';
import '../modules/detail_category/views/detail_category_view.dart';
import '../modules/edit_user/bindings/edit_user_binding.dart';
import '../modules/edit_user/views/edit_user_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/travel_agency_home/bindings/travel_agency_home_binding.dart';
import '../modules/travel_agency_home/views/travel_agency_home_view.dart';
import '../modules/travel_agency_main/bindings/travel_agency_main_binding.dart';
import '../modules/travel_agency_main/views/travel_agency_main_view.dart';
import '../modules/trips/bindings/trips_binding.dart';
import '../modules/trips/views/trips_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.AGENCY,
      page: () => const AgencyView(),
      binding: AgencyBinding(),
    ),
    GetPage(
      name: _Paths.TRAVEL_AGENCY_HOME,
      page: () => const TravelAgencyHomeView(),
      binding: TravelAgencyHomeBinding(),
    ),
    GetPage(
      name: _Paths.TRAVEL_AGENCY_MAIN,
      page: () => const TravelAgencyMainView(),
      binding: TravelAgencyMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CATEGORY,
      page: () => DetailCategoryView(),
      binding: DetailCategoryBinding(),
    ),
    GetPage(
      name: _Paths.BUS_DETAIL,
      page: () => BusDetailView(),
      binding: BusDetailBinding(),
    ),
    GetPage(
      name: _Paths.BUS,
      page: () => const BusView(),
      binding: BusBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => const AdminProfileView(),
      binding: AdminProfileBinding(),
    ),
    GetPage(
      name: _Paths.ALL_BUSES,
      page: () => const AllBusesView(),
      binding: AllBusesBinding(),
    ),
    GetPage(
      name: _Paths.TRIPS,
      page: () => const TripsView(),
      binding: TripsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_USER,
      page: () => const EditUserView(),
      binding: EditUserBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
