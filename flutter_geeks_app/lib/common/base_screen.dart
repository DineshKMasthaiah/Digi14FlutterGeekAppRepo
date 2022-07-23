import 'dart:async';

import 'package:digi14_geeks_app/common/alert_data.dart';
import 'package:digi14_geeks_app/common/widgets/favorite_widget.dart';
import 'package:digi14_geeks_app/common/widgets/secondary_button.dart';
import 'package:digi14_geeks_app/utils/ge_padding.dart';
import 'package:digi14_geeks_app/utils/ge_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// A utility class that acts as base for all the screens by enabling common code re usability
class GEBaseScreen {
  bool showProgress = false;

  ///@showAlert is super attribute that is used by subclasses of @GEBaseScreen to show or hide alert
  bool showAlert = false;
  GEAlertData? alertData;

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Pushes the progress bar down by [topPadding] or up by [bottomPadding] from it's default center of the screen position
  Widget wrapProgressBar(
    BuildContext context,
    Widget child, {
    double topPadding = 0,
    double bottomPadding = 0,
    double loaderRadius = 18.0,
    bool isBlueScreen = false,
  }) {
    return Stack(children: <Widget>[
      SizedBox(
        width: screenSize(context).width,
        height: screenSize(context).height,
        child: child,
      ),
      if (showProgress)
        getProgressBar(
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            isBlueScreen: isBlueScreen),
    ]);
  }

  Future<dynamic> gotoNextScreen(BuildContext context, Widget screen,
      {bool addToBackStack = false, bool clearHistory = false}) {
    ///Get the reference of Navigator in widget tree
    if (addToBackStack) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen));
    } else if (clearHistory) {
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => screen),
          (routeToBeRemoved) => false);
    } else {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => screen));
    }
  }

  Widget getProgressBar({
    double topPadding = 0,
    double bottomPadding = 0,
    double loadedWidth = GEPadding.progressSpinnerWidth,
    double loaderHeight = GEPadding.progressSpinnerHeight,
    double loaderRadius = 18.0,
    bool isBlueScreen = false,
  }) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: SizedBox(
          width: loadedWidth,
          height: loaderHeight,
          child: const CircularProgressIndicator()),
    ));
  }

  showAlertDialog(BuildContext context, GEAlertData alertData) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Theme.of(context).platform == TargetPlatform.iOS
              ? _buildCupertinoAlert(context, alertData)
              : AlertDialog(
                  title: Text(alertData.title, style: GEStyles.listItemTitle),
                  content: Text(alertData.body, style: GEStyles.listItemTitle),
                  actions: <Widget>[
                      if (alertData.negativeButtonLabel != null &&
                          alertData.negativeButtonLabel!.isNotEmpty)
                        GESecondaryButton(
                          buttonText: alertData.negativeButtonLabel ?? '',
                          onButtonPress: () {
                            showAlert = false;
                            Navigator.pop(context, -1);

                            ///Dismiss AlertDialog
                          },
                        ),
                      GESecondaryButton(
                        buttonText: alertData.positiveButtonLabel,
                        onButtonPress: () {
                          if (alertData.onPositiveButtonPress != null) {
                            alertData.onPositiveButtonPress!();
                          } else {
                            showAlert = false;
                            Navigator.pop(context, -1);

                            ///Dismiss AlertDailog
                          }
                        },
                      ),
                    ]);
        });
  }

  void showErrorDialog(BuildContext context, String? error, String? code) {
    showAlertDialog(
        context,
        GEAlertData()
          ..title = "Error $code"
          ..body = error ?? 'unknown');
  }

  Widget _buildCupertinoAlert(BuildContext context, GEAlertData alertData) {
    return CupertinoAlertDialog(
      title: Text(alertData.title),
      content: Text(alertData.body),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text("OK"),
          onPressed: () {
            showAlert = false;
            Navigator.pop(context, -1);
          },
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context, String title,
      {TextEditingController? controller,
      bool showSearchIcon = false,
      bool showSearchBox = false,
      String initialSearchTerm = '',
      onSearchPressed,
      onTextChange,
        bool hideFavorite = true,
      bool isFavorite = false,
      Function(bool)? onFavoriteTap}) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: true,
      elevation: 0,
      title: showSearchBox
          ? Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                enabled: true,
                style: GEStyles.textFieldValue,
                controller: controller,
                obscureText: false,
                decoration: const InputDecoration(
                    labelText: "",
                    hintText: 'Type here to search...',
                    labelStyle: GEStyles.textFieldLabel),
                onChanged: onTextChange,
              ),
            )
          : Text(
              title,
              textAlign: TextAlign.left,
              style: GEStyles.pageTitleStyle,
            ),
      actions: <Widget>[
        if (showSearchIcon)
          InkWell(
            onTap: onSearchPressed,
            child: showSearchBox
                ? const Center(child: Text("Cancel"))
                : Image.asset('images/app_bar/search/ic_search_white.png'),
          ),
           if(!hideFavorite)GEFavoriteWidget(favorite: isFavorite, onTap: (favorite){
             onFavoriteTap!(favorite);
           })
      ],
    );
  }
}
