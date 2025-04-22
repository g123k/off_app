import 'package:betclic_app/res/app_colors.dart';
import 'package:betclic_app/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('res/svg/ill_empty.svg'),
              SizedBox(height: height * 0.08),
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
                    TextButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blue,
                        backgroundColor: AppColors.yellow,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Commencer'.toUpperCase()),
                          const SizedBox(width: 8.0),
                          Icon(Icons.arrow_right_alt),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
