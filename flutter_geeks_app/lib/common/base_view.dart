///Base view class for all the views.
abstract class GEBaseViewContract {
  void showLoading();

  void hideLoading();

  void showErrorPopup(String? error,
      String? code);
}
