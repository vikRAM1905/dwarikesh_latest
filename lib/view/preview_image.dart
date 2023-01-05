import 'package:dwarikesh/model/info_center_model.dart';
import 'package:dwarikesh/utils/imageUtils.dart';
import 'package:dwarikesh/widgets/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:get/get.dart';

class PreviewImage extends StatefulWidget {
  PreviewImage({
    this.loadingBuilder,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    @required this.galleryItems,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController? pageController;
  final List<Picture>? galleryItems;

  @override
  State<StatefulWidget> createState() {
    return _PreviewImage();
  }
}

class _PreviewImage extends State<PreviewImage> {
  int? currentIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: "image_preview".tr,
        leftsideIcon: backIcon,
        leftsideBtnPress: () {
          Get.back();
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: Axis.horizontal,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex! + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final Picture item = widget.galleryItems![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.image!),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes:
          PhotoViewHeroAttributes(tag: item.title! + '${index.toString()}'),
    );
  }
}
