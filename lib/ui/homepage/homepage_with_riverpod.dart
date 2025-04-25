import 'package:betclic_app/ui/components/button.dart';
import 'package:betclic_app/ui/homepage/homepage_riverpod.dart';
import 'package:betclic_app/ui/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomePageWithRiverpod extends ConsumerWidget {
  const HomePageWithRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes scans'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Scanner un code-barres',
            onPressed: () async {
              String? barcode = await SimpleBarcodeScanner.scanBarcode(
                context,
                barcodeAppBar: const BarcodeAppBar(
                  appBarTitle: 'Test',
                  centerTitle: false,
                  enableBackButton: true,
                  backButtonIcon: Icon(Icons.arrow_back_ios),
                ),
                isShowFlashIcon: true,
                delayMillis: 2000,
                cameraFace: CameraFace.front,
              );

              if (!context.mounted) {
                return;
              }

              if (barcode?.isNotEmpty == true) {
                _openDetails(context, ref, barcode!);
              }
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(AppIcons.barcode),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: ref
          .watch(homePageProviderProvider)
          .when(
            data: (List<String> history) {
              if (history.isEmpty) {
                return _EmptyHomePage();
              } else {
                return _HomePageHistory();
              }
            },
            error: (_, __) => Text('Erreur'),
            loading: () => CircularProgressIndicator(),
          ),
    );
  }
}

class _EmptyHomePage extends ConsumerWidget {
  const _EmptyHomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height = MediaQuery.sizeOf(context).height;

    return Center(
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
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 25.0),

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
                    onPressed: () => _openDetails(context, ref, '12345'),
                  ),
                ],
              ),
            ),
            Spacer(flex: 15),
          ],
        ),
      ),
    );
  }
}

class _HomePageHistory extends ConsumerWidget {
  const _HomePageHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(homePageProviderProvider)
        .maybeWhen(
          data: (List<String> history) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (BuildContext context, int position) {
                      final String barcode = history[position];

                      return ListTile(
                        title: Text(barcode),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () => _openDetails(context, ref, barcode),
                      );
                    },
                  ),
                ),
                MyButton(
                  label: 'Commencer',
                  onPressed: () => _openDetails(context, ref, '123456'),
                ),
              ],
            );
          },
          orElse: () => SizedBox.shrink(),
        );
  }
}

void _openDetails(BuildContext context, WidgetRef ref, String barcode) {
  ref.read(homePageProviderProvider.notifier).addBarcodeToHistory(barcode);

  GoRouter.of(context).push('/product?barcode=$barcode');
}
