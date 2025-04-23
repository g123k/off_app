import 'package:betclic_app/res/app_colors.dart';
import 'package:betclic_app/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mes scans'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Scanner un code-barres',
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(AppIcons.barcode),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Spacer(flex: 15),
              Expanded(
                flex: 70,
                child: SvgPicture.asset('res/svg/ill_empty.svg'),
              ),
              Spacer(flex: 10),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25.0,
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Vous n\'avez pas encore scanné de produit',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.1),
                    MyButton(
                      label: 'Commencer',
                      onPressed: () {
                        GoRouter.of(context).push('/product?barcode=123');
                      },
                    ),
                  ],
                ),
              ),
              Spacer(flex: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue,
        backgroundColor: AppColors.yellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Text(label.toUpperCase())),
          const SizedBox(width: 8.0),
          Icon(Icons.arrow_right_alt),
        ],
      ),
    );
  }
}
