// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemtnaa/core/widgets/custom_lottie_widget.dart';
import 'package:hemtnaa/screens/doctor_screens/home_layout/doc_home_layout.dart';
import 'package:hemtnaa/screens/start/types/types_view.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/widgets/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../child_screens/home_layout/home_layout.dart';
import '../on_boarding/on_boarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<Offset> _slidingAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _customAnimation();
    _customNavigation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 150.h,
            child: CustomLottieWidget(
              lottieName: Assets.img.start,
              repeat: false,
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _slidingAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: _slidingAnimation,
                  child: AnimatedBuilder(
                    animation: _shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: Image.asset(
                          Assets.img.logo.path,
                          height: 300.w,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _customNavigation() {
    return Future.delayed(const Duration(seconds: 3), () {
      _shakeController.forward();
      CacheHelper.getLang() != ""
          ? CacheHelper.getUserToken() != ""
              ? CacheHelper.getUserType() == "parent"
                  ? AppRouter.navigateAndPop(context, const HomeLayout())
                  : AppRouter.navigateAndPop(context, const DocHomeLayout())
              : AppRouter.navigateAndFinish(context, const TypesView())
          : AppRouter.navigateAndPop(context, const OnBoarding());
    });
  }


  void _customAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(5, 5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutExpo),
    );

    _animationController.forward();

    // Shake animation controller
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _shakeAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: -10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -10,
          end: 10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 10,
          end: -10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -10,
          end: 10,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 10,
          end: 0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 1,
      ),
    ]).animate(_shakeController);
    Future.delayed(const Duration(milliseconds: 1800), () {
      _shakeController.forward();
    });
  }
}
