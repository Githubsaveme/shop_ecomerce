import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/controller/controllerLogic.dart';
import 'package:shop_ecomerce/utils/commonThings.dart';

class ProductCategoryScreen extends StatelessWidget {
  ProductCategoryScreen({super.key});

  final categoryCon = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: commonAppBar(
          isBackVisible: true,
          isActionVisible: false,
          isSecondActionVisible: false,
          isTitleVisible: true,
          appBarName: "category",
          size: size,
          backFunction: () {
            Get.back();
          },
          actionFunction: () {},
          secondActionFunction: () {},
          actionImage: '',
          secondActionImage: ''),
      body: categoryWidget(size),
    );
  }

  Widget categoryWidget(size) {
    return Obx(() {
      if (categoryCon.isLoading.value == true) {
        return showLoader();
      } else {
        return ListView.builder(
            itemCount: categoryCon.categoryList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                child: InkWell(
                  onTap: () {
                    categoryCon.callGetCategoryByName(
                        categoryCon.categoryList[index].toString());

                    categoryCon.showData.value ==true
                        ? Get.bottomSheet(
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    categoryCon.categoryByNameList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: size.width/1,
                                    margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.width*0.05),
                                    child: DottedBorder(
                                        padding: EdgeInsets.zero,
                                        borderType: BorderType.RRect,
                                        strokeWidth: size.width * 0.003,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                "assets/images/image_placeholder.png",
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/image_placeholder.png",
                                                fit: BoxFit.cover,
                                              ),
                                              imageUrl: categoryCon
                                                  .categoryByNameList[index]
                                                  .image!,
                                              fit: BoxFit.cover,
                                              width: size.width,
                                              height: size.width,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: size.width * 0.12,
                                                width: size.width,
                                                padding: EdgeInsets.all(
                                                    size.width * 0.01),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      categoryCon
                                                          .categoryByNameList[
                                                              index]
                                                          .title!,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        fontSize:
                                                            size.width * 0.035,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      categoryCon
                                                          .categoryByNameList[
                                                              index]
                                                          .description!,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        fontSize:
                                                            size.width * 0.035,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        : showLoader();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        categoryCon.categoryList[index]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.fullscreen))
                    ],
                  ),
                ),
              );
            });
      }
    });
  }
}
