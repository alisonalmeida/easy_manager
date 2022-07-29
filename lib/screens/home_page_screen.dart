import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/central_grid_button.dart';
import 'package:easy_manager/helper/objectbox_helper.dart';
import 'package:easy_manager/screens/crud_customer_screen.dart';
import 'package:easy_manager/screens/customer_screen.dart';
import 'package:easy_manager/screens/product_screen.dart';
import 'package:easy_manager/screens/provider_screen.dart';
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
        title: 'Easy Manager',
        lottie: 'lib/assets/animations/home_page_check.json',
      ),
      body: Container(
        color: selago,
        padding: const EdgeInsets.all(5),
        child: GridView(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: [
            CentralGridButton(
              hero: 'Produtos',
              title: 'Produtos',
              backgroundColor: productBackgroundColor,
              borderColor: pinkSalomn,
              shadowColor: pinkSalomn,
              color: white,
              iconPath: kpathSvgProduct,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  )),
            ),
            CentralGridButton(
              hero: 'Clientes',
              title: 'Clientes',
              backgroundColor: customerBackgroundColor,
              borderColor: customerBackgroundColorShadow,
              shadowColor: customerBackgroundColorShadow,
              color: white,
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
              hero: 'Fornecedores',
              title: 'Fornecedores',
              backgroundColor: providerBackgroundColor,
              borderColor: providerBackgroundColorShadow,
              shadowColor: providerBackgroundColorShadow,
              color: white,
              iconPath: kpathSvgFactory,
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProvidersScreen(),
                  )),
            ),
            CentralGridButton(
                hero: 'PDV',
                title: 'PDV',
                backgroundColor: purple,
                borderColor: purpleShadow,
                shadowColor: purpleShadow,
                color: white,
                iconPath: kpathSvgPdv,
                callback: () {}),
            CentralGridButton(
                hero: 'Gráficos',
                //title: 'Gráficos',
                title: 'TESTE',
                backgroundColor: blueBlue,
                borderColor: blueBlueShadow,
                shadowColor: blueBlueShadow,
                color: white,
                iconPath: kpathSvgChart,
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CrudCustomerScreen()))),
            CentralGridButton(
                hero: 'Entrada e Saída',
                title: 'Entrada e Saída',
                backgroundColor: grey,
                borderColor: greyShadow,
                shadowColor: greyShadow,
                color: white,
                iconPath: kpathSvgMoney,
                callback: () {}),
          ],
        ),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('data'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
