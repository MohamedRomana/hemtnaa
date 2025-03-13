part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ChangeIndex extends AppState {}

final class GetCurrentLocationLoading extends AppState {}

final class GetCurrentLocationSuccess extends AppState {}

final class ServerError extends AppState {}

final class Timeoutt extends AppState {}

final class GetIntroLoading extends AppState {}

final class ChangeCount extends AppState {}

final class GetIntroSuccess extends AppState {}

final class ChangeBottomNav extends AppState {}

final class IsSecureIcon extends AppState {}

final class GetIntroFailure extends AppState {
  final String error;

  GetIntroFailure({required this.error});
}

final class AddAddressLoading extends AppState {}

final class AddAddressSuccess extends AppState {
  final String message;
  AddAddressSuccess({required this.message});
}

final class AddAddressFailure extends AppState {
  final String error;

  AddAddressFailure({required this.error});
}

final class DeleteAddressLoading extends AppState {}

final class DeleteAddressSuccess extends AppState {
  final String message;
  DeleteAddressSuccess({required this.message});
}

final class DeleteAddressFailure extends AppState {
  final String error;

  DeleteAddressFailure({required this.error});
}

final class ChooseImageSuccess extends AppState {}

final class RemoveImageSuccess extends AppState {}

final class UpdateProfileLoading extends AppState {}

final class UpdateProfileSuccess extends AppState {
  final String message;
  UpdateProfileSuccess({required this.message});
}

final class UpdateProfileFailure extends AppState {
  final String error;
  UpdateProfileFailure({required this.error});
}

final class UploadImagesLoading extends AppState {}

final class UploadImagesSuccess extends AppState {}

final class UploadImagesFailure extends AppState {}

final class AboutUsLoading extends AppState {}

final class AboutUsSuccess extends AppState {}

final class AboutUsFailure extends AppState {
  final String error;
  AboutUsFailure({required this.error});
}

final class ContactUsLoading extends AppState {}

final class ContactUsSuccess extends AppState {
  final String message;
  ContactUsSuccess({required this.message});
}

final class ContactUsFailure extends AppState {
  final String error;
  ContactUsFailure({required this.error});
}

final class PrivacyPolicyLoading extends AppState {}

final class PrivacyPolicySuccess extends AppState {}

final class PrivacyPolicyFailure extends AppState {
  final String error;
  PrivacyPolicyFailure({required this.error});
}

final class GetChatMessagesLoading extends AppState {}

final class GetChatMessagesSuccess extends AppState {}

final class GetChatMessagesFailure extends AppState {
  final String error;
  GetChatMessagesFailure({required this.error});
}

final class SendMessageLoading extends AppState {}

final class SendMessageSuccess extends AppState {}

final class SendMessageFailure extends AppState {
  final String error;
  SendMessageFailure({required this.error});
}

final class GetSectionsLoading extends AppState {}

final class GetSectionsSuccess extends AppState {}

final class GetSectionsFailure extends AppState {
  final String error;
  GetSectionsFailure({required this.error});
}

final class GetQuestionsLoading extends AppState {}

final class GetQuestionsSuccess extends AppState {}

final class GetQuestionsFailure extends AppState {
  final String error;
  GetQuestionsFailure({required this.error});
}

final class ShowUserLoading extends AppState {}

final class ShowUserSuccess extends AppState {}

final class ShowUserFailure extends AppState {
  final String error;
  ShowUserFailure({required this.error});
}

final class UpdateUserLoading extends AppState {}

final class UpdateUserSuccess extends AppState {
  final String message;
  UpdateUserSuccess({required this.message});
}

final class UpdateUserFailure extends AppState {
  final String error;
  UpdateUserFailure({required this.error});
}

final class ShowNotificationsLoading extends AppState {}

final class ShowNotificationsSuccess extends AppState {
  final String message;
  ShowNotificationsSuccess({required this.message});
}

final class ShowNotificationsFailure extends AppState {
  final String error;
  ShowNotificationsFailure({required this.error});
}

final class DeleteNotificationLoading extends AppState {}

final class DeleteNotificationSuccess extends AppState {
  final String message;
  DeleteNotificationSuccess({required this.message});
}

final class DeleteNotificationFailure extends AppState {
  final String error;
  DeleteNotificationFailure({required this.error});
}

final class ClientHomeLoading extends AppState {}

final class ClientHomeSuccess extends AppState {}

final class ClientHomeFailure extends AppState {
  final String error;
  ClientHomeFailure({required this.error});
}

final class ShowProviderLoading extends AppState {}

final class ShowProviderSuccess extends AppState {}

final class ShowProviderFailure extends AppState {
  final String error;
  ShowProviderFailure({required this.error});
}

final class ShowServicesLoading extends AppState {}

final class ShowServicesSuccess extends AppState {}

final class ShowServicesFailure extends AppState {
  final String error;
  ShowServicesFailure({required this.error});
}

final class AllServicesLoading extends AppState {}

final class AllServicesSuccess extends AppState {}

final class AllServicesFailure extends AppState {
  final String error;
  AllServicesFailure({required this.error});
}

final class ShowServiceLoading extends AppState {}

final class ShowServiceSuccess extends AppState {}

final class ShowServiceFailure extends AppState {
  final String error;
  ShowServiceFailure({required this.error});
}

final class AllProvidersLoading extends AppState {}

final class AllProvidersSuccess extends AppState {}

final class AllProvidersFailure extends AppState {
  final String error;
  AllProvidersFailure({required this.error});
}

final class SubSectionsLoading extends AppState {}

final class SubSectionsSuccess extends AppState {}

final class SubSectionsFailure extends AppState {
  final String error;
  SubSectionsFailure({required this.error});
}

final class GetDataLoading extends AppState {}

final class GetDataSuccess extends AppState {}

final class GetDataFailure extends AppState {
  final String error;
  GetDataFailure({required this.error});
}

final class AddFavoriteLoading extends AppState {}

final class AddFavoriteSuccess extends AppState {
  final String message;
  AddFavoriteSuccess({required this.message});
}

final class AddFavoriteFailure extends AppState {
  final String error;
  AddFavoriteFailure({required this.error});
}

final class ShowFavoriteLoading extends AppState {}

final class ShowFavoriteSuccess extends AppState {}

final class ShowFavoriteFailure extends AppState {
  final String error;
  ShowFavoriteFailure({required this.error});
}

final class RemoveFavLoading extends AppState {}

final class RemoveFavSuccess extends AppState {}

final class RemoveFavFailure extends AppState {
  final String error;
  RemoveFavFailure({required this.error});
}

final class AddToCartLoading extends AppState {}

final class AddToCartSuccess extends AppState {
  final String message;
  AddToCartSuccess({required this.message});
}

final class AddToCartFailure extends AppState {
  final String error;
  AddToCartFailure({required this.error});
}

final class ShowCartLoading extends AppState {}

final class ShowCartSuccess extends AppState {}

final class ShowCartFailure extends AppState {
  final String error;
  ShowCartFailure({required this.error});
}

final class DeleteCartLoading extends AppState {}

final class DeleteCartSuccess extends AppState {
  final String message;
  DeleteCartSuccess({required this.message});
}

final class DeleteCartFailure extends AppState {
  final String error;
  DeleteCartFailure({required this.error});
}

final class CartItemsLoading extends AppState {}

final class CartItemsSuccess extends AppState {
  final String message;
  CartItemsSuccess({required this.message});
}

final class CartItemsFailure extends AppState {
  final String error;
  CartItemsFailure({required this.error});
}

final class UpdateCartLoading extends AppState {}

final class UpdateCartSuccess extends AppState {
  final String message;
  UpdateCartSuccess({required this.message});
}

final class UpdateCartFailure extends AppState {
  final String error;
  UpdateCartFailure({required this.error});
}

final class ChangeIndexSuccess extends AppState {}

final class StoreOrderLoading extends AppState {}

final class StoreOrderSuccess extends AppState {
  final String message;
  StoreOrderSuccess({required this.message});
}

final class StoreOrderFailure extends AppState {
  final String error;
  StoreOrderFailure({required this.error});
}

final class AllOrdersLoading extends AppState {}

final class AllOrdersSuccess extends AppState {
  final String message;
  AllOrdersSuccess({required this.message});
}

final class AllOrdersFailure extends AppState {
  final String error;
  AllOrdersFailure({required this.error});
}

final class ShowOrdersLoading extends AppState {}

final class ShowOrdersSuccess extends AppState {
  final String message;
  ShowOrdersSuccess({required this.message});
}

final class ShowOrdersFailure extends AppState {
  final String error;
  ShowOrdersFailure({required this.error});
}

final class DeleteOrdersLoading extends AppState {}

final class DeleteOrdersSuccess extends AppState {
  final String message;
  DeleteOrdersSuccess({required this.message});
}

final class DeleteOrdersFailure extends AppState {
  final String error;
  DeleteOrdersFailure({required this.error});
}

final class RestoreOrderLoading extends AppState {}

final class RestoreOrderSuccess extends AppState {
  final String message;
  RestoreOrderSuccess({required this.message});
}

final class RestoreOrderFailure extends AppState {
  final String error;
  RestoreOrderFailure({required this.error});
}

final class CertificatesLoading extends AppState {}

final class CertificatesSuccess extends AppState {
  final String message;
  CertificatesSuccess({required this.message});
}

final class CertificatesFailure extends AppState {
  final String error;
  CertificatesFailure({required this.error});
}

final class StoreCertificatesLoading extends AppState {}

final class StoreCertificatesSuccess extends AppState {
  final String message;
  StoreCertificatesSuccess({required this.message});
}

final class StoreCertificatesFailure extends AppState {
  final String error;
  StoreCertificatesFailure({required this.error});
}

final class StoreCertificatesPaymentLoading extends AppState {}

final class StoreCertificatesPaymentSuccess extends AppState {
  final String message;
  StoreCertificatesPaymentSuccess({required this.message});
}

final class StoreCertificatesPaymentFailure extends AppState {
  final String error;
  StoreCertificatesPaymentFailure({required this.error});
}

final class GetSerachLoading extends AppState {}

final class GetSearchSuccess extends AppState {
  final String message;
  GetSearchSuccess({required this.message});
}

final class GetSearchFailure extends AppState {
  final String error;
  GetSearchFailure({required this.error});
}

final class AllCertificatesLoading extends AppState {}

final class AllCertificatesSuccess extends AppState {
  final String message;
  AllCertificatesSuccess({required this.message});
}

final class AllCertificatesFailure extends AppState {
  final String error;
  AllCertificatesFailure({required this.error});
}

final class UpdateCertificatesLoading extends AppState {}

final class UpdateCertificatesSuccess extends AppState {
  final String message;
  UpdateCertificatesSuccess({required this.message});
}

final class UpdateCertificatesFailure extends AppState {
  final String error;
  UpdateCertificatesFailure({required this.error});
}

final class ShowCertificatesLoading extends AppState {}

final class ShowCertificatesSuccess extends AppState {
  final String message;
  ShowCertificatesSuccess({required this.message});
}

final class ShowCertificatesFailure extends AppState {
  final String error;
  ShowCertificatesFailure({required this.error});
}

final class TransferCertificateLoading extends AppState {}

final class TransferCertificateSuccess extends AppState {
  final String message;
  TransferCertificateSuccess({required this.message});
}

final class TransferCertificateFailure extends AppState {
  final String error;
  TransferCertificateFailure({required this.error});
}

final class DeleteCertificatesLoading extends AppState {}

final class DeleteCertificatesSuccess extends AppState {
  final String message;
  DeleteCertificatesSuccess({required this.message});
}

final class DeleteCertificatesFailure extends AppState {
  final String error;
  DeleteCertificatesFailure({required this.error});
}

final class UserNotificationLoading extends AppState {}

final class UserNotificationSuccess extends AppState {}

final class UserNotificationFailure extends AppState {
  final String error;

  UserNotificationFailure({required this.error});
}
