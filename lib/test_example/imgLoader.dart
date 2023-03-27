import 'package:flutter/material.dart';

class NetworkImg extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const NetworkImg(
      {Key? key, required this.url, this.width = 200.0, this.height = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool? wasSynchronouslyLoaded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return Center(child: child);
        }
        return Center(
          child: CircularProgressIndicator(
            value: (loadingProgress.expectedTotalBytes != null)
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(child: Text('이미지 준비중..'));
      },
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}

class AssetImg extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const AssetImg(
      {Key? key, required this.url, this.width = 200.0, this.height = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/no_image.png', fit: BoxFit.cover),
          ),
        );
      },
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
