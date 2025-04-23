import 'package:betclic_app/style.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  static const double IMAGE_HEIGHT = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0.0,
            start: 0.0,
            end: 0.0,
            child: Image.network(
              'https://images.unsplash.com/photo-1482049016688-2d3e1b311543',
              height: IMAGE_HEIGHT,
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            start: 0.0,
            end: 0.0,
            top: IMAGE_HEIGHT - 16.0,
            bottom: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              padding: EdgeInsetsDirectional.only(
                top: 30.0,
                start: 20.0,
                end: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Petits pois et carottes', style: context.theme.title1),
                  Text('Cassegrain', style: context.theme.title2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
