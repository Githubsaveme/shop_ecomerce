import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/ui/productDetailScreen/produtDetailScreen.dart';
import 'package:shop_ecomerce/utils/common.dart';
import '../../controller/controllerLogic.dart';
import '../searchScreen/searchScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(MyController());
  final detailsApiCall = Get.lazyPut(() => DetailController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Container(
              color: Colors.red.withOpacity(0.2),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/shop_image.png',
                  ),
                  Text(
                    " Shop Eco",
                    style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                  )
                ],
              )),
          leadingWidth: size.width / 2.9,
          actions: [
            Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width * 0.09,
                        height: size.width * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ]),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: colorTheme,
                              size: size.width * 0.055,
                            ),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: size.width * 0.021,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width * 0.09,
                        height: size.width * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: const Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ]),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: colorTheme,
                              size: size.width * 0.055,
                            ),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: size.width * 0.021,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width * 0.09,
                        height: size.width * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: const Offset(
                                  1.0, // Move to right 10 horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: colorTheme,
                              size: size.width * 0.055,
                            ),
                            Positioned(
                              right: 0,
                              top: 3,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: size.width * 0.021,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => SearchScreen());
                    },
                    child: Container(
                        width: size.width * 0.09,
                        height: size.width * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: const Offset(
                                  1.0, // Move to right 10 horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ]),
                        child: Icon(
                          Icons.search,
                          color: colorTheme,
                          size: size.width * 0.055,
                        )),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value == false) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width * 0.02),
                showCategoryListWidget(size),
                Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.5),
                  height: 10,
                ),
                sliderWidget(size),
                Divider(
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.5),
                  height: 10,
                ),
                Center(
                    child: Text("New Arrival",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.05))),
                dottedWidget(size),
                topWidget(),
                bottomWidget(),
              ],
            ),
          );
        }));
  }

  Widget showCategoryListWidget(size) {
    return SizedBox(
      height: size.height / 9,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categoryList.length,
        itemBuilder: (context, index) {
          var item = controller.categoryList[index];
          return Column(
            children: [
              Card(
                color: colorTheme,
                elevation: 2,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                      "assets/images/image_placeholder.png",
                      width: size.width * 0.15,
                      fit: BoxFit.cover),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/image_placeholder.png",
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: item.image!,
                  width: size.width * 0.15,
                  height: size.width * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.width * 0.02),
              SizedBox(
                width: size.width * 0.15,
                child: Text(
                  item.title!.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: size.width * 0.025,
                      color: colorTheme,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: size.width * 0.02,
          );
        },
      ),
    );
  }

  Widget sliderWidget(size) {
    return controller.categoryList.isNotEmpty
        ? Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: (index, value) {
                      debugPrint("CarouselOptions:-${value.toString()}");
                    },
                    viewportFraction: 1,
                    autoPlayCurve: Curves.easeInCubic,
                    autoPlay: true,
                    aspectRatio: 2),
                items: controller.categoryList.map((index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                              "assets/images/image_placeholder.png",
                              height: size.height / 3,
                              fit: BoxFit.cover,
                              width: double.infinity),
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/images/image_placeholder.png",
                              height: size.height / 1,
                              fit: BoxFit.cover,
                              width: double.infinity),
                          imageUrl: index.image!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          )
        : Container();
  }

  Widget dottedWidget(size) {
    return controller.categoryList.isNotEmpty
        ? GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.8),
            itemCount: controller.categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.to(() => ProductDetailScreen(),
                      arguments: controller.categoryList[index].id);
                },
                child: DottedBorder(
                    padding: EdgeInsets.zero,
                    borderType: BorderType.RRect,
                    strokeWidth: size.width * 0.003,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            "assets/images/image_placeholder.png",
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/image_placeholder.png",
                            fit: BoxFit.cover,
                          ),
                          imageUrl: controller.categoryList[index].image!,
                          fit: BoxFit.cover,
                          width: size.width,
                          height: size.width,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: size.width * 0.12,
                            width: size.width,
                            padding: EdgeInsets.all(size.width * 0.01),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.categoryList[index].title!,
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: size.width * 0.035,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  controller.categoryList[index].description!,
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: size.width * 0.035,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          )
        : Container();
  }

  Widget topWidget() {
    return Container(
      child: const Text("top"),
    );
  }

  Widget bottomWidget() {
    return Container();
  }
}
