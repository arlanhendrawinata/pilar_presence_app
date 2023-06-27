import 'package:get/get.dart';

import '../modules/account_validation/bindings/account_validation_binding.dart';
import '../modules/account_validation/views/account_validation_view.dart';
import '../modules/admin_menu/bindings/admin_menu_binding.dart';
import '../modules/admin_menu/views/admin_menu_view.dart';
import '../modules/announcement/bindings/announcement_binding.dart';
import '../modules/announcement/views/announcement_view.dart';
import '../modules/announcement_add/bindings/announcement_add_binding.dart';
import '../modules/announcement_add/views/announcement_add_view.dart';
import '../modules/cuti_tahunan/bindings/cuti_tahunan_binding.dart';
import '../modules/cuti_tahunan/views/cuti_tahunan_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/management_announcement/bindings/management_announcement_binding.dart';
import '../modules/management_announcement/views/management_announcement_view.dart';
import '../modules/management_user/bindings/management_user_binding.dart';
import '../modules/management_user/views/management_user_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/monitoring/bindings/monitoring_binding.dart';
import '../modules/monitoring/views/monitoring_view.dart';
import '../modules/myPageView/bindings/my_page_view_binding.dart';
import '../modules/myPageView/views/my_page_view_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/overtime/bindings/overtime_binding.dart';
import '../modules/overtime/views/overtime_view.dart';
import '../modules/overtimeHistory/bindings/overtime_history_binding.dart';
import '../modules/overtimeHistory/views/overtime_history_view.dart';
import '../modules/overtime_detail/bindings/overtime_detail_binding.dart';
import '../modules/overtime_detail/views/overtime_detail_view.dart';
import '../modules/overtime_request/bindings/overtime_request_binding.dart';
import '../modules/overtime_request/views/overtime_request_view.dart';
import '../modules/perizinan_cuti/bindings/perizinan_cuti_binding.dart';
import '../modules/perizinan_cuti/views/perizinan_cuti_view.dart';
import '../modules/perizinan_cuti_request/bindings/perizinan_cuti_request_binding.dart';
import '../modules/perizinan_cuti_request/views/perizinan_cuti_request_view.dart';
import '../modules/perizinan_request/bindings/perizinan_request_binding.dart';
import '../modules/perizinan_request/views/perizinan_request_view.dart';
import '../modules/perizinan_sakit/bindings/perizinan_sakit_binding.dart';
import '../modules/perizinan_sakit/views/perizinan_sakit_view.dart';
import '../modules/perizinan_sakit_request/bindings/perizinan_sakit_request_binding.dart';
import '../modules/perizinan_sakit_request/views/perizinan_sakit_request_view.dart';
import '../modules/photo_view/bindings/photo_view_binding.dart';
import '../modules/photo_view/views/photo_view_view.dart';
import '../modules/presenceRemote/bindings/presence_remote_binding.dart';
import '../modules/presenceRemote/views/presence_remote_view.dart';
import '../modules/presence_detail/bindings/presence_detail_binding.dart';
import '../modules/presence_detail/views/presence_detail_view.dart';
import '../modules/presence_history/bindings/presence_history_binding.dart';
import '../modules/presence_history/views/presence_history_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/user_add/bindings/user_add_binding.dart';
import '../modules/user_add/views/user_add_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';
import '../modules/user_update_email/bindings/user_update_email_binding.dart';
import '../modules/user_update_email/views/user_update_email_view.dart';
import '../modules/user_update_password/bindings/user_update_password_binding.dart';
import '../modules/user_update_password/views/user_update_password_view.dart';
import '../modules/user_update_profile/bindings/user_update_profile_binding.dart';
import '../modules/user_update_profile/views/user_update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_PAGE_VIEW,
      page: () => const MyPageViewView(),
      binding: MyPageViewBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRESENCE_REMOTE,
      page: () => const PresenceRemoteView(),
      binding: PresenceRemoteBinding(),
      children: [
        GetPage(
          name: _Paths.PRESENCE_REMOTE,
          page: () => const PresenceRemoteView(),
          binding: PresenceRemoteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.USER_ADD,
      page: () => const UserAddView(),
      binding: UserAddBinding(),
    ),
    GetPage(
      name: _Paths.USER_UPDATE_PROFILE,
      page: () => const UserUpdateProfileView(),
      binding: UserUpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.USER_UPDATE_EMAIL,
      page: () => const UserUpdateEmailView(),
      binding: UserUpdateEmailBinding(),
    ),
    GetPage(
      name: _Paths.USER_UPDATE_PASSWORD,
      page: () => const UserUpdatePasswordView(),
      binding: UserUpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PRESENCE_HISTORY,
      page: () => const PresenceHistoryView(),
      binding: PresenceHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ANNOUNCEMENT,
      page: () => const AnnouncementView(),
      binding: AnnouncementBinding(),
    ),
    GetPage(
      name: _Paths.PRESENCE_DETAIL,
      page: () => const PresenceDetailView(),
      binding: PresenceDetailBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MENU,
      page: () => const AdminMenuView(),
      binding: AdminMenuBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_REQUEST,
      page: () => const PerizinanRequestView(),
      binding: PerizinanRequestBinding(),
    ),
    GetPage(
      name: _Paths.CUTI_TAHUNAN,
      page: () => const CutiTahunanView(),
      binding: CutiTahunanBinding(),
    ),
    GetPage(
      name: _Paths.OVERTIME,
      page: () => const OvertimeView(),
      binding: OvertimeBinding(),
    ),
    GetPage(
      name: _Paths.OVERTIME_DETAIL,
      page: () => const OvertimeDetailView(),
      binding: OvertimeDetailBinding(),
    ),
    GetPage(
      name: _Paths.OVERTIME_REQUEST,
      page: () => const OvertimeRequestView(),
      binding: OvertimeRequestBinding(),
    ),
    GetPage(
      name: _Paths.OVERTIME_HISTORY,
      page: () => const OvertimeHistoryView(),
      binding: OvertimeHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_CUTI,
      page: () => const PerizinanCutiView(),
      binding: PerizinanCutiBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_CUTI_REQUEST,
      page: () => const PerizinanCutiRequestView(),
      binding: PerizinanCutiRequestBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_SAKIT,
      page: () => const PerizinanSakitView(),
      binding: PerizinanSakitBinding(),
    ),
    GetPage(
      name: _Paths.PERIZINAN_SAKIT_REQUEST,
      page: () => const PerizinanSakitRequestView(),
      binding: PerizinanSakitRequestBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEMENT_USER,
      page: () => const ManagementUserView(),
      binding: ManagementUserBinding(),
    ),
    GetPage(
      name: _Paths.MONITORING,
      page: () => const MonitoringView(),
      binding: MonitoringBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEMENT_ANNOUNCEMENT,
      page: () => const ManagementAnnouncementView(),
      binding: ManagementAnnouncementBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_VALIDATION,
      page: () => const AccountValidationView(),
      binding: AccountValidationBinding(),
    ),
    GetPage(
      name: _Paths.ANNOUNCEMENT_ADD,
      page: () => const AnnouncementAddView(),
      binding: AnnouncementAddBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO_VIEW,
      page: () => const PhotoViewView(),
      binding: PhotoViewBinding(),
    ),
  ];
}
