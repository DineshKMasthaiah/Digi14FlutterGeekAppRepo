import 'dart:async';

import 'package:digi14_geeks_app/common/alert_data.dart';
import 'package:digi14_geeks_app/common/widgets/favorite_widget.dart';
import 'package:digi14_geeks_app/common/widgets/secondary_button.dart';
import 'package:digi14_geeks_app/utils/ge_colors.dart';
import 'package:digi14_geeks_app/utils/ge_padding.dart';
import 'package:digi14_geeks_app/utils/ge_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// A utility class that acts as a base for all the screens by enabling common code re-usability
/// unlike Stateful and Stateless widget, it doesn't maintain any state & do not carry any inheritance tree
class GEBaseScreen {
  bool showProgress = false;

  ///@showAlert is super attribute that is used by subclasses of @GEBaseScreen to show or hide alert
  bool showAlert = false;
  GEAlertData? alertData;
///Returns screen size for the callers to calculate related height and width for the Widgets
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// This methods wraps a progress spinner for a given screen widget (passed as child).
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
        _getProgressBar(
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            isBlueScreen: isBlueScreen),
    ]);
  }

  /// Navigates the user to another screen
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

  Widget _getProgressBar({
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

/// Shows an Alert dialog. caller has to pass what information needs to be shown in the Alert
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

  ///iOS specific Alert
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

  /// Reusable AppBar that the caller can call with the required information
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
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                enabled: true,
                controller: controller,
                obscureText: false,
                decoration: const InputDecoration(
                  filled: true,
                    fillColor: Colors.grey,
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: GEColors.white,
                    suffixIcon: Icon(Icons.close),
                    suffixIconColor: Colors.white,

                   ),
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
