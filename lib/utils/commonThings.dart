import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'common.dart';

///AppBar
AppBar commonAppBar({
  required bool isBackVisible,
  required bool isActionVisible,
  required bool isSecondActionVisible,
  required bool isTitleVisible,
  required String appBarName,
  required Size size,
  required Function backFunction,
  required Function actionFunction,
  required Function secondActionFunction,
  required String actionImage,
  required String secondActionImage,
}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    backgroundColor: colorTheme,
    leading: isBackVisible
        ? InkWell(
            onTap: () {
              backFunction();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: size.width * 0.065,
              color: Colors.white,
            ))
        : Container(),
    title: isTitleVisible
        ? Text(
            appBarName,
            style: TextStyle(
                fontSize: size.width * 0.045,
                color: Colors.white,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        : Container(),
    actions: [
      isActionVisible
          ? InkWell(
              onTap: () {
                actionFunction();
              },
              child: Padding(
                padding: EdgeInsets.all(isSecondActionVisible
                    ? size.width * 0.02
                    : size.width * 0.04),
                child: Image.asset(
                  actionImage,
                ),
              ),
            )
          : Container(),
      isSecondActionVisible
          ? InkWell(
              onTap: () {
                secondActionFunction();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.width * 0.15),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: secondActionImage,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                                "data"), /* Text(
                            sharedPreferences
                                .getString("")!
                                .substring(0, 1),
                            style: const TextStyle(color: Colors.white),
                          ),*/
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container()
    ],
  );
}

Widget showLoader() {
  return const SpinKitChasingDots(
    color: Colors.grey,
    size: 50.0,
  );
}
