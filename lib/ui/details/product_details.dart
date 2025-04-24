import 'package:betclic_app/ui/res/app_icons.dart';
import 'package:betclic_app/ui/details/bloc/product_bloc.dart';
import 'package:betclic_app/ui/details/product_tab0.dart';
import 'package:betclic_app/ui/details/product_tab1.dart';
import 'package:betclic_app/ui/details/product_tab2.dart';
import 'package:betclic_app/ui/details/product_tab3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({required this.barcode, super.key});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(barcode),
      lazy: false,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          return switch (state) {
            LoadingProductState() => const _ProductDetailsLoading(),
            SuccessProductState() => const _ProductDetailsBody(),
            ErrorProductState() => const _ProductDetailsError(),
          };
        },
      ),
    );
  }
}

class _ProductDetailsLoading extends StatelessWidget {
  const _ProductDetailsLoading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ProductDetailsError extends StatelessWidget {
  const _ProductDetailsError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Erreur ${(BlocProvider.of<ProductBloc>(context).state as ErrorProductState).error}',
        ),
      ),
    );
  }
}

class _ProductDetailsBody extends StatefulWidget {
  const _ProductDetailsBody();

  @override
  State<_ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<_ProductDetailsBody> {
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
          Positioned.fill(
            child: Offstage(
              offstage: currentTab != ProductDetailsCurrentTab.summary,
              child: ProductTab0(),
            ),
          ),
          Positioned.fill(
            child: Offstage(
              offstage: currentTab != ProductDetailsCurrentTab.info,
              child: ProductTab1(),
            ),
          ),
          Positioned.fill(
            child: Offstage(
              offstage: currentTab != ProductDetailsCurrentTab.nutrition,
              child: ProductTab2(),
            ),
          ),
          Positioned.fill(
            child: Offstage(
              offstage:
                  currentTab != ProductDetailsCurrentTab.nutritionalValues,
              child: ProductTab3(),
            ),
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
