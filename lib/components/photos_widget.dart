import 'package:dwarikesh/model/request_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotosWidget extends StatelessWidget {
  final Data? data;

  const PhotosWidget({
    Key? key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data!.reqimage!.length > 0) {
      return Container(
        height: 112,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 15,
          ),
          padding: EdgeInsets.symmetric(horizontal: 22),
          itemCount: data!.reqimage!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var model = data!.reqimage![index];
            return new GestureDetector(
              //You need to make my child interactive
              /* onTap: () => Navigator.of(context).pushNamed(
                Routes.photos,
                arguments: infoCenterList[0],
              ),*/
              child: PhotoTile(
                imageUrl: model.image,
                width: 170,
                height: 100,
                leftTopRadius: 8,
                rightTopRadius: 8,
                leftBottomRadius: 8,
                rightBottomRadius: 8,
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

class PhotoTile extends StatelessWidget {
  String? imageUrl;
  double? width;
  double? height;
  double? leftTopRadius, rightTopRadius, leftBottomRadius, rightBottomRadius;
  PhotoTile(
      {this.imageUrl,
      this.width,
      this.height,
      this.leftTopRadius,
      this.rightTopRadius,
      this.leftBottomRadius,
      this.rightBottomRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(leftTopRadius!),
            topRight: Radius.circular(rightTopRadius!),
            bottomLeft: Radius.circular(leftBottomRadius!),
            bottomRight: Radius.circular(rightBottomRadius!)),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading_image.png',
          image: imageUrl!,
          fit: BoxFit.fill,
          height: width,
          width: width,
        ),
      ),
    );
  }
}

class CirclePhotoTile extends StatelessWidget {
  String? imageUrl;
  bool? available;
  CirclePhotoTile({this.imageUrl, this.available});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      height: 55.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        /* image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imageUrl)
            )*/
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: (available!)
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/circle_image_loading.png',
                image: imageUrl!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                imageUrl!,
              ),
      ),
    );
  }
}
