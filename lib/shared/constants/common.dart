import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pilkada_app/api/api.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

abstract class CommonConstants {
  static const double kDesignWidth = 360.0;
  static const double kDesignHeight = 800.0;
  static const double largeText = 40.0;
  static const double normalText = 22.0;
  static const double smallText = 16.0;
  static const double kDefaultHorizontalPadding = 15.0;
  static const double kDefaultPaddingFromAppBar = 20.0;
  static const int kPromoDetailsTitleEstimatedHeightPerLine = 20;
  static const int kVoucherDetailsTitleEstimatedHeightPerLine = 20;
  static const TextStyle kLargeText = TextStyle(
    fontSize: largeText,
    fontWeight: FontWeight.bold,
    fontFamily: 'Figtree',
  );
  static const TextStyle kNormalText = TextStyle(
    fontSize: normalText,
    fontWeight: FontWeight.w600,
    fontFamily: 'Figtree',
    color: ColorConstants.black,
  );
  static const TextStyle kSmallText = TextStyle(
    fontSize: smallText,
    fontWeight: FontWeight.w600,
    fontFamily: 'Figtree',
  );
  static BoxShadow widgetShadowStyle = BoxShadow(
    color: ColorConstants.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 4,
    offset: const Offset(0, 4),
  );
  static const double kGridViewItemHeight = 230;
  static const double kListCardheight = 120;
  static const String tncUrl = '';
  static const String privacyPolicy =
      'https://api.smartsoft.co.id/gelael-privacy-policy';
  static const String imageNetworkPlaceholder =
      'https://untirta.ac.id/wp-content/uploads/2023/08/placeholder-4.png';
  static const String defaultTitle = 'No Title';
  static const String defaultDescription = 'No Description';
  static const String assetImagePlaceholder = 'assets/pngs/placeholder.png';
  static const String kGelaelInstagram = 'gelaelsupermarket';
  static const String kGelaelTiktok = 'gelaelsupermarket';

  static const double strukFontSize = 12;

  // pilkada app

  static const String kDatePickerBuilderId = 'DatePickerBuilder';
  static const String kProvincePickerBuilderId = 'ProvincePickerBuilderId';
  static const String kCitiesPickerBuilderId = 'CitiesPickerBuilderId';
  static const String kSubdistrictsPickerBuilderId =
      'SubdistrictsPickerBuilderId';
  static const String kWardsPickerBuilderId = 'WardsPickerBuilderId';

  static const String kDaftarDataBuilderId = 'DaftarDataBuilderId';
  static const String kDaftarAnggotaBuilderId = 'DaftarAnggotaBuilderId';

  // Main Tab Builder ids
  static const String kMainTabsBuilderId = 'MainTabsBuilderId';

  // Home Tab Builder ids
  static const String kNotificationBadgeBuilderId =
      'NotificationBadgeBuilderId';
  static const String kImageCarouselBuilderId = 'ImageCarouselBuilderId';
  static const String kPromoCardsBuilderId = 'PromoCardsBuilderId';
  static const String kPointsAndVouchersBuilderId =
      'PointsAndVouchersBuilderId';
  static const String kNotificationListBuilderId = 'NotificationListId';
  static const String kHomeTopWidgetBuilderId = 'HomeTopWidgetId';
  static const String kStorePromotionsHeaderBuilderId =
      'StorePromotionsHeaderBuilderId';
  static const String kSocialsBuilderId = 'SocialsBuilderId';

  // Vouchers Screen Builder ids
  static const String kVouchersBuilderId = 'VouchersBuilderId';

  // Promo Details Screen Builder ids
  static const String kPromoDetailsBuilderId = 'PromoDetailsBuilderId';

  // Blog Details Screen Builder ids
  static const String kBlogDetailsBuilderId = 'BlogDetailsBuilderId';

  // Store Details Screen Builder ids
  static const String kStoreDetailsBuilderId = 'StoreDetailsBuilderId';

  // Transaction Details Screen Builder ids
  static const String kTransactionDetailsBulderId =
      'TransactionDetailsBulderId';

  // Qr Tab Builder ids
  static const String kQRTabBuilderId = 'QrTabBuilderId';

  // Recipes Screen Builder ids
  static const String kRecipesBuilderId = 'RecipesBuilderId';

  // Blog Screen Builder ids
  static const String kBlogBuilderId = 'BlogBuilderId';

  // Change Password Screen Builder ids
  static const String kChangePasswordNewPasswordBuilderId =
      'ChangePasswordNewPasswordId';
  static const String kChangePasswordConfirmPasswordBuilderId =
      'ChangePasswordConfirmPasswordId';
  static const String kChangePasswordButtonBuilderId =
      'ChangePasswordButtonBuilderId';

  // Login Screen Builder ids
  static const String kLoginPasswordBuilderId = 'LoginPasswordBuilderId';
  static const String kLoginButtonBuilderId = 'LoginButtonBuilderId';

  // Register Screen Builder ids
  static const String kRegisterPasswordBuilderId = 'RegisterPasswordBuilderId';
  static const String kRegisterPasswordConfirmBuilderId =
      'RegisterPasswordConfirmBuilderId';
  static const String kRegisterButtonBuilderId = 'RegisterButtonBuilderId';
  static const String kRegisterPart2ButtonBuilderId =
      'RegisterPart2ButtonBuilderId';

  static const String kRegisterStoresDropdownBuilderId =
      'RegisterStoresDropdownBuilderId';
  static const String kRegisterDOBBuilderId = 'RegisterDOBBuilderId';

  // Forgot Password Screen Builder ids
  static const String kForgotPasswordButtonBuilderId = 'ForgotPasswordButtonId';

  // Reset Password Screen Builder ids
  static const String kResetPasswordNewPasswordBuilderId =
      'ChangePasswordNewPasswordId';
  static const String kResetPasswordConfirmPasswordBuilderId =
      'ChangePasswordConfirmPasswordId';
  static const String kResetPasswordButtonBuilderId =
      'ChangePasswordButtonBuilderId';

  // Edit Password Screen Builder ids
  static const String kEditPasswordOldPassBuilderId =
      'EditPasswordOldPassBuilderId';
  static const String kEditPasswordNewPassBuilderId =
      'EditPasswordNewPassBuilderId';
  static const String kEditPasswordConfirmPassBuilderId =
      'EditPasswordConfirmPassBuilderId';
  static const String kEditPasswordButtonBuilderId =
      'EditPasswordButtonBuilderId';

  // Locations Tab Builder ids
  static const String kStoreListBuilderId = 'StoreListBuilderId';

  // Profile Screen Builder ids
  static const String kBriefUserInfoBuilderId = 'BriefUserInfoBuilderId';
  static const String kUserMembershipBuilderId = 'UserMembershipBuilderId';

  // Edit Profile Screen Builder ids
  static const String kProfileAvatarBuilderId = 'ProfileAvatarBuilderId';
  static const String kEditProfileButtonBuilderId =
      'EditProfileButtonBuilderId';

  // Settings Screen Builder ids
  static const String kDeleteAccountDialogBuilderId =
      'DeleteAccountDialogBuilderId';

  static const String kVisiMisiBuilderId = 'VisiMisiBuilderId';
}

extension Target on Object {
  bool isAndroid() {
    return Platform.isAndroid;
  }

  bool isIOS() {
    return Platform.isIOS;
  }

  bool isLinux() {
    return Platform.isLinux;
  }

  bool isWindows() {
    return Platform.isWindows;
  }

  bool isMacOS() {
    return Platform.isMacOS;
  }

  bool isWeb() {
    return kIsWeb;
  }
  // ···
}
