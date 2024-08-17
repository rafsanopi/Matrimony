import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<dynamic> images = Get.arguments;

    return SafeArea(
        top: false,
        child: Scaffold(
            appBar: const CustomAppBar(title: AppStaticStrings.viewImages),
            body: Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PhotoViewGallery.builder(
                    allowImplicitScrolling: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                            images[index].publicFileUrl.toString()),
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: images[index].path),
                      );
                    },
                    itemCount: images.length,
                    loadingBuilder: (context, event) => Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes!.bitLength,
                        ),
                      ),
                    ),
                    // backgroundDecoration: widget.backgroundDecoration,
                    // pageController: widget.pageController,

                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 100,
                    right: 50,
                    child: Row(
                      children: [
                        CustomText(
                          color: AppColors.white100,
                          text: "${currentIndex + 1}",
                        ),
                        CustomText(
                          color: AppColors.white100,
                          text: "/${images.length}",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
