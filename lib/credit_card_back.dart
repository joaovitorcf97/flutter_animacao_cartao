import 'package:flutter/material.dart';

class CreditCardBack extends StatelessWidget {
  const CreditCardBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 40,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: constraints.maxWidth * .8,
                    height: 60,
                    color: Colors.grey,
                  ),
                  Container(
                    width: constraints.maxWidth * .2,
                    height: 60,
                    color: Colors.white,
                    child: const Center(
                      child: Text('***'),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
