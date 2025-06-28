part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ChangeIndex extends AppState {}

final class GetCurrentLocationLoading extends AppState {}

final class GetCurrentLocationSuccess extends AppState {}

final class ChooseVideoSuccess extends AppState {}

final class RemoveVideoSuccess extends AppState {}

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

final class ScoreUpdated extends AppState {}

class QuizInitialState extends AppState {}

class QuizAnsweredState extends AppState {
  final int currentPage;
  final int score;
  final bool answered;
  final int? selectedIndex;

  QuizAnsweredState(this.currentPage, this.score, this.answered, this.selectedIndex);
}

class QuizNextQuestionState extends AppState {
  final int currentPage;
  final int score;
  final bool answered;
  final int? selectedIndex;

  QuizNextQuestionState(this.currentPage, this.score, this.answered, this.selectedIndex);
}

class PostsViewLoading extends AppState {}

class PostsViewSuccess extends AppState {}

class PostsViewFailure extends AppState {}

class CreatePostLoading extends AppState {}

class CreatePostSuccess extends AppState {
  final String message;
  CreatePostSuccess({required this.message});
}

class CreatePostFailure extends AppState {
  final String error;
  CreatePostFailure({required this.error});
}

class CreateActivityLoading extends AppState {}

class CreateActivitySuccess extends AppState {}

class CreateActivityFailure extends AppState {
  final String error;
  CreateActivityFailure({required this.error});
}

class ActivityScoreChanged extends AppState {}

final class GetProfileLoading extends AppState {}

final class GetProfileSuccess extends AppState {}

final class GetProfileFailure extends AppState {
  final String error;
  GetProfileFailure({required this.error});
}

final class GetPostsLoading extends AppState {}

final class GetPostsSuccess extends AppState {}

final class GetPostsFailure extends AppState {
  final String error;
  GetPostsFailure({required this.error});
}

final class DoLikePostLoading extends AppState {}

final class DoLikePostSuccess extends AppState {}

final class DoLikePostFailure extends AppState {
  final String error;
  DoLikePostFailure({required this.error});
}

final class AddCommentLoading extends AppState {}

final class AddCommentSuccess extends AppState {
  final String message;
  AddCommentSuccess({required this.message});
}

final class AddCommentFailure extends AppState {
  final String error;
  AddCommentFailure({required this.error});
}

final class GetCommentsLoading extends AppState {}

final class GetCommentsSuccess extends AppState {}

final class GetCommentsFailure extends AppState {
  final String error;
  GetCommentsFailure({required this.error});
}

final class AddActivityLoading extends AppState {}

final class AddActivitySuccess extends AppState {
  final String message;
  AddActivitySuccess({required this.message});
}

final class AddActivityFailure extends AppState {
  final String error;
  AddActivityFailure({required this.error});
}
