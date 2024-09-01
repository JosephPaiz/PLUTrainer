// import 'package:flutter/material.dart';
// import 'package:plu_trainer/style/custom_colors.dart';
// import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
// import 'package:plu_trainer/viewmodels/products_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';

// class PLUHelperView extends StatefulWidget {
//   const PLUHelperView({super.key});

//   @override
//   State<PLUHelperView> createState() => _PLUHelperViewState();
// }

// class _PLUHelperViewState extends State<PLUHelperView>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);
//     viewModel.initAnimationController(this);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final timerViewModel = Provider.of<TimerViewModel>(context);
//     final productViewModel = Provider.of<ProductViewModel>(context);
//     final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);

//     viewModel.checkAndAnimate(
//       isTimerRunning: timerViewModel.isTimerRunning,
//       products: productViewModel.products,
//       results: productViewModel.results,
//     );
//   }

//   @override
//   void dispose() {
//     final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);
//     viewModel.disposeAnimationController();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final timerViewModel = Provider.of<TimerViewModel>(context);
//     final productViewModel = Provider.of<ProductViewModel>(context);
//     final viewModel = Provider.of<PLUHelperViewModel>(context);

//     return Container(
//       width: 70,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: CustomColors.grey),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: AnimatedBuilder(
//           animation: viewModel.animationController,
//           builder: (context, child) {
//             if (viewModel.isAnimationComplete) {
//               return Center(
//                 child: Text(
//                   productViewModel.products.isNotEmpty
//                       ? productViewModel.products[viewModel.productIndex].plu
//                           .toString()
//                       : 'No hay productos',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             } else {
//               return LinearProgressIndicator(
//                 value: viewModel.animationController.value,
//                 backgroundColor: CustomColors.grey,
//                 valueColor:
//                     const AlwaysStoppedAnimation<Color>(CustomColors.deepGrey),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plu_trainer/style/custom_colors.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';

class PLUHelperView extends StatefulWidget {
  const PLUHelperView({super.key});

  @override
  State<PLUHelperView> createState() => _PLUHelperViewState();
}

class _PLUHelperViewState extends State<PLUHelperView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);
    viewModel.initAnimationController(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final productViewModel = Provider.of<ProductViewModel>(context);
    final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);

    viewModel.startAnimationIfNeeded(timerViewModel.isTimerRunning,
        productViewModel.results, productViewModel.products);
  }

  // @override
  // void dispose() {
  //   final viewModel = Provider.of<PLUHelperViewModel>(context, listen: false);
  //   viewModel.disposeAnimationController();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);
    final productViewModel = Provider.of<ProductViewModel>(context);
    final viewModel = Provider.of<PLUHelperViewModel>(context);

    return Container(
      width: 70,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: timerViewModel.isTimerRunning
            ? viewModel.isAnimationComplete
                ? Center(
                    child: Text(
                      productViewModel.products[viewModel.productIndex].plu
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : AnimatedBuilder(
                    animation: viewModel.animationController,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: viewModel.animationController.value,
                        backgroundColor: CustomColors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            CustomColors.deepGrey),
                      );
                    },
                  )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }
}
