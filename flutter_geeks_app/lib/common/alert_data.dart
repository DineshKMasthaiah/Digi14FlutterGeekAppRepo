class GEAlertData {
  String title;
  String body;
  String positiveButtonLabel;
  String? negativeButtonLabel;
  bool show;
  Function()? onPositiveButtonPress;
  Function()? onNegativeButtonPress;

  GEAlertData(
      {this.title = "title",
      this.body = "message",
      this.positiveButtonLabel = "primaryButtonLabel",
      this.show = false});
}
