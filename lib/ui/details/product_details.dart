import 'package:betclic_app/res/app_icons.dart';
import 'package:betclic_app/ui/details/product_tab0.dart';
import 'package:betclic_app/ui/details/product_tab1.dart';
import 'package:betclic_app/ui/details/product_tab2.dart';
import 'package:betclic_app/ui/details/product_tab3.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductDetailsCurrentTab currentTab;

  @override
  void initState() {
    super.initState();
    currentTab = ProductDetailsCurrentTab.summary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: currentTab != ProductDetailsCurrentTab.summary,
            child: Positioned.fill(child: ProductTab0()),
          ),
          Offstage(
            offstage: currentTab != ProductDetailsCurrentTab.info,
            child: Positioned.fill(child: ProductTab1()),
          ),
          Offstage(
            offstage: currentTab != ProductDetailsCurrentTab.nutrition,
            child: Positioned.fill(child: ProductTab2()),
          ),
          Offstage(
            offstage: currentTab != ProductDetailsCurrentTab.nutritionalValues,
            child: Positioned.fill(child: ProductTab3()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab.index,
        onTap: (int position) {
          currentTab = ProductDetailsCurrentTab.values[position];

          setState(() {});
        },
        items: ProductDetailsCurrentTab.values
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

enum ProductDetailsCurrentTab {
  summary('Fiche', AppIcons.tab_barcode),
  info('Caractéristiques', AppIcons.tab_fridge),
  nutrition('Nutrition', AppIcons.tab_nutrition),
  nutritionalValues('Tableau', AppIcons.tab_array);

  final String label;
  final IconData icon;

  const ProductDetailsCurrentTab(this.label, this.icon);
}
