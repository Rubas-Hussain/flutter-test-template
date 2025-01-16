import 'package:flutter/material.dart';
import 'package:test_template/utils/extensions.dart';

import '../utils/assets.dart';


class ImageWidget extends StatefulWidget {
  final double? height, width;
  final String? image;
  final bool? isAssetImage;
  final bool? isNetworkImage;
  final bool? isFileImage;
  final bool? isMemoryImage;
  final BoxFit? fit;

  ImageWidget(
      {super.key,
      this.height ,
      this.width ,
      required this.image,
      this.isAssetImage,
      this.isNetworkImage,
      this.isFileImage,
      this.isMemoryImage, this.fit});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> _getImageType(String child_image){
      if(widget.isNetworkImage==true){
        return NetworkImage(child_image);
      }else if(widget.isAssetImage==true){
        return AssetImage(child_image);
      } // else if(isFileImage==true){
      //   return FileImage(child_image);
      // }else if(isMemoryImage==true){
      //   return MemoryImage(child_image);
      // }
      else {
        return const AssetImage(
          Assets.noImage,
        );
      }
    }

    if (widget.image != null) {
      return Image(
            height: widget.height,
            width: widget.width,
            fit:widget.fit ?? BoxFit.fill,
            image: _getImageType(widget.image!),
            loadingBuilder: (BuildContext ctx, Widget child, ImageChunkEvent? loading) {

              if (loading == null) return child;
              return SizedBox(
                  height: widget.height ?? 200.h,
                  width: widget.width ?? 200.w,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                    value: loading.expectedTotalBytes != null
                        ? loading.cumulativeBytesLoaded /
                            loading.expectedTotalBytes!
                        : null,
                  )));
            },
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: child,
              );
            },
            errorBuilder: (BuildContext context, exception, StackTrace? error) {
              return SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: const Center(
                      child: Icon(
                    Icons.error,
                    color: Colors.red,
                        size: 32,
                  )));
            },
          );
    } else {
      return Container(
              height: widget.height,
              width: widget.width,
        color: const Color(0xfff8f8f8),

        child: Image.asset(
              Assets.noImage,
              fit: BoxFit.cover,
            ),
      );
    }
  }
}