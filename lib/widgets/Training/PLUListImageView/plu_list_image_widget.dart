import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PluListImageWidget extends StatelessWidget {
  final String imageUrl;

  const PluListImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.red),
      height: 300,
      width: 300,
      fit: BoxFit.cover,
    );
  }
}
