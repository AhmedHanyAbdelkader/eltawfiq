import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullNetworkImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullNetworkImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('عرض الصوره'),
        ),
        body: InteractiveViewer(
          child: Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}