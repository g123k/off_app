import 'package:betclic_app/ui/components/button.dart';
import 'package:betclic_app/ui/homepage/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _EmptyHomePage();
  }
}

class _EmptyHomePage extends StatelessWidget {
  const _EmptyHomePage();

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
  const _HomePageHistory();

  @override
  Widget build(BuildContext context) {
    final List<String> history =
        BlocProvider.of<HomepageBloc>(context, listen: true).state;

    // TODO
    return SizedBox.shrink();
  }
}

void _openDetails(BuildContext context, String barcode) {
  BlocProvider.of<HomepageBloc>(
    context,
    listen: false,
  ).add(AddProductToHistoryEvent(barcode));

  GoRouter.of(context).push('/product?barcode=$barcode');
}
