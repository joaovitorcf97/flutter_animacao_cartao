import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animacao_cartao/card_animation.dart';
import 'package:flutter_animacao_cartao/credit_card_back.dart';
import 'package:flutter_animacao_cartao/credit_card_front.dart';

class CardItem extends StatefulWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontAnimation;
  late Animation<double> _backAnimation;
  bool isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _setupAnimation();
  }

  void _setupAnimation() {
    bool rotateToLeft = isFrontVisible;

    _frontAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: rotateToLeft ? (pi / 2) : (-pi / 2),
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(rotateToLeft ? (-pi / 2) : (pi / 2)),
        weight: 50,
      ),
    ]).animate(_controller);

    _backAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(rotateToLeft ? (pi / 2) : (-pi / 2)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: rotateToLeft ? (-pi / 2) : (pi / 2),
          end: 0.0,
        ).chain(CurveTween(curve: Curves.linear)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CardAnimation(
                  animation: _backAnimation,
                  child: const CreditCardBack(),
                ),
                CardAnimation(
                  animation: _frontAnimation,
                  child: const CreditCardFront(),
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isFrontVisible) {
                    _controller.forward();
                    isFrontVisible = false;
                  } else {
                    _controller.reverse();
                    isFrontVisible = true;
                  }
                });
              },
              child: const Text('Virar'),
            )
          ],
        ),
      ),
    );
  }
}
