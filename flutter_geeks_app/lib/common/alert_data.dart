///Alert data container class
class GEAlertData {
  String title;
  String body;
  String positiveButtonLabel;
  String? negativeButtonLabel;
  bool show;
  Function()? onPositiveButtonPress;
  Function()? onNegativeButtonPress;
///Default values are used to remind the developer at the time of development that they have missed passing required values
  GEAlertData(
      {this.title = "title",
      this.body = "message",
      this.positiveButtonLabel = "primaryButtonLabel",
      this.show = false});
}
