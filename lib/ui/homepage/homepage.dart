import 'package:betclic_app/ui/components/button.dart';
import 'package:betclic_app/ui/homepage/homepage_bloc.dart';
import 'package:betclic_app/ui/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomepageBloc>(
      create: (_) => HomepageBloc(),
      child: Scaffold(
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
                  _openDetails(context, barcode!);
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
        body: BlocBuilder<HomepageBloc, List<String>>(
          builder: (BuildContext context, List<String> history) {
            if (history.isEmpty) {
              return _EmptyHomePage();
            } else {
              return _HomePageHistory();
            }
          },
        ),
      ),
    );
  }
}

class _EmptyHomePage extends StatelessWidget {
  const _EmptyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () => _openDetails(context, '12345'),
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

class _HomePageHistory extends StatelessWidget {
  const _HomePageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> history =
        BlocProvider.of<HomepageBloc>(context, listen: true).state;

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
                onTap: () => _openDetails(context, barcode),
              );
            },
          ),
        ),
        MyButton(
          label: 'Commencer',
          onPressed: () => _openDetails(context, '123456'),
        ),
      ],
    );
  }
}

void _openDetails(BuildContext context, String barcode) {
  BlocProvider.of<HomepageBloc>(
    context,
    listen: false,
  ).add(AddProductToHistoryEvent(barcode));

  GoRouter.of(context).push('/product?barcode=$barcode');
}
