import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecomerce/utils/common.dart';

import '../../controller/controllerLogic.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchCn = Get.put(SearchCon());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: size.width * 0.05), searchWidget(size)],
        ),
      ),
    );
  }

  Widget searchWidget(size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search",
                style: TextStyle(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.w700),
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel'))
            ],
          ),
          Column(children: [
            TextFormField(
              controller: searchCn.searchController.value,
              onChanged: (value) {
                if (searchCn.searchController.value.text.isNotEmpty) {
                  searchCn.callGetProductSearch(
                      searchCn.searchController.value.text);
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                hintText: 'Search...',
                border: const OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    searchCn.searchController.value.clear();
                    searchCn.searchCategoryList.clear();
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ),
            Obx(() {
              if (searchCn.isLoading.value == false) {
                return const CircularProgressIndicator();
              }
              return searchCn.searchCategoryList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchCn.searchCategoryList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  searchCn.searchCategoryList[index].title!),
                              trailing: Card(
                                color: colorTheme,
                                elevation: 2,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/image_placeholder.png",
                                      width: size.width * 0.15,
                                      fit: BoxFit.cover),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/image_placeholder.png",
                                    width: size.width * 0.15,
                                    height: size.width * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl:
                                      searchCn.searchCategoryList[index].image!,
                                  width: size.width * 0.15,
                                  height: size.width * 0.12,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      })
                  : Container();
            })
          ]),
        ],
      ),
    );
  }
}
