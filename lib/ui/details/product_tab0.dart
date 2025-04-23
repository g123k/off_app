import 'package:betclic_app/model/product.dart';
import 'package:betclic_app/res/app_colors.dart';
import 'package:betclic_app/res/app_icons.dart';
import 'package:betclic_app/style.dart';
import 'package:flutter/material.dart';

class ProductTab0 extends StatelessWidget {
  const ProductTab0({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 30.0,
                      start: 20.0,
                      end: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Petits pois et carottes',
                          style: context.theme.title1,
                        ),
                        Text('Cassegrain', style: context.theme.title2),
                      ],
                    ),
                  ),

                  Scores(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Scores extends StatelessWidget {
  const Scores({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.theme.altText,
      child: ColoredBox(
        color: AppColors.gray1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 44,
                    child: NutriScore(nutriscore: ProductNutriscore.A),
                  ),
                  VerticalDivider(),
                  Expanded(
                    flex: 54,
                    child: NovaScore(novaScore: ProductNovaScore.group3),
                  ),
                ],
              ),
            ),
            Divider(),
            GreenScore(greenScore: ProductGreenScore.A),
          ],
        ),
      ),
    );
  }
}

class NutriScore extends StatelessWidget {
  const NutriScore({super.key, required this.nutriscore});

  final ProductNutriscore nutriscore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutri-Score', style: context.theme.title3),
        SizedBox(
          height: 60.0,
          child: Image.asset('res/drawables/nutriscore_a.png'),
        ),
      ],
    );
  }
}

class NovaScore extends StatelessWidget {
  const NovaScore({super.key, required this.novaScore});

  final ProductNovaScore novaScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Groupe NOVA', style: context.theme.title3),
        Text('Produits alimentaires et boissons ultra-transformés'),
      ],
    );
  }
}

class GreenScore extends StatelessWidget {
  const GreenScore({super.key, required this.greenScore});

  final ProductGreenScore greenScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Green-Score', style: context.theme.title3),
        Row(
          children: [
            Icon(AppIcons.ecoscore_d, color: AppColors.greenScoreD),
            const SizedBox(width: 10.0),
            Expanded(child: Text('Impact environnemental élevé')),
          ],
        ),
      ],
    );
  }
}
