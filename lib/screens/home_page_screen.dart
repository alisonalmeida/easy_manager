import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/central_grid_button.dart';
import 'package:easy_manager/models/product_model.dart';
import 'package:easy_manager/screens/budget/budget_screen.dart';
import 'package:easy_manager/screens/customer/customer_screen.dart';

import 'package:easy_manager/screens/configurations_screen.dart';
import 'package:easy_manager/screens/pdv_screen.dart';
import 'package:easy_manager/screens/product/product_screen.dart';
import 'package:easy_manager/screens/provider/provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/custom_home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late bool _checked;
  int numbergrid = 1;

  @override
  initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _checked = true;
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeAnimation() {
    _checked = !_checked;
    _checked ? _animationController.forward() : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selago,
      appBar: CustomHomeAppBar(
        callback: changeAnimation,
        controller: _animationController,
        title: appName,
        lottie: kpathLottieCheck,
      ),
      endDrawer: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('data')),
      body: Container(
        color: selago,
        padding: const EdgeInsets.all(5),
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (numbergrid * MediaQuery.of(context).size.width ~/ 200) < 1
                    ? 1
                    : (numbergrid * MediaQuery.of(context).size.width ~/ 200),
          ),
          children: [
            CentralGridButton(
              hero: ProductsScreen.name,
              title: ProductsScreen.name,
              backgroundColor: productBackgroundColor,
              borderColor: productBackgroundColorShadow,
              shadowColor: productBackgroundColorShadow,
              iconPath: kpathSvgProduct,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  )),
            ),
            CentralGridButton(
              hero: CustomerScreen.name,
              title: CustomerScreen.name,
              backgroundColor: customerBackgroundColor,
              borderColor: customerBackgroundColorShadow,
              shadowColor: customerBackgroundColorShadow,
              iconPath: kpathSvgPerson,
              callback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerScreen(),
                    ));
              },
            ),
            CentralGridButton(
              hero: ProvidersScreen.name,
              title: ProvidersScreen.name,
              backgroundColor: providerBackgroundColor,
              borderColor: providerBackgroundColorShadow,
              shadowColor: providerBackgroundColorShadow,
              iconPath: kpathSvgFactory,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProvidersScreen(),
                  )),
            ),
            CentralGridButton(
                backgroundColor: budgetBackgroundColor,
                borderColor: budgetBackgroundColorShadow,
                shadowColor: budgetBackgroundColorShadow,
                iconPath: kpathSvgBudgets,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  BudgetsScreen(),
                    )),
                title: BudgetsScreen.name,
                hero: BudgetsScreen.name),
            /**
             * CentralGridButton(
                hero: 'PDV',
                title: 'PDV',
                backgroundColor: pdvBackgroundColor,
                borderColor: pdvBackgroundColorShadow,
                shadowColor: pdvBackgroundColorShadow,
                color: white,
                iconPath: kpathSvgPdv,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PdvScreen()))),
             */
            /**
             * CentralGridButton(
                hero: 'Gráficos',
                title: 'Gráficos',
                backgroundColor: blueBlue,
                borderColor: blueBlueShadow,
                shadowColor: blueBlueShadow,
                color: white,
                iconPath: kpathSvgChart,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CrudCustomerScreen()))),
             */
            /**
             * CentralGridButton(
                hero: 'Entrada e Saída',
                title: 'Entrada e Saída',
                backgroundColor: Colors.indigo,
                borderColor: greyShadow,
                shadowColor: greyShadow,
                color: white,
                iconPath: kpathSvgMoney,
                callback: () {}),
             */
            CentralGridButton(
                borderColor: Colors.orangeAccent,
                shadowColor: Colors.orangeAccent,
                iconPath: kpathSvgSettings,
                backgroundColor: Colors.orange,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Configurations())),
                title: Configurations.name,
                hero: Configurations.name),
          ],
        ),
      ),
    );
  }
}
