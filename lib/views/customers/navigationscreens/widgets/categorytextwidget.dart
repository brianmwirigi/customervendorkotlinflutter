import 'package:flutter/material.dart';

class CategoryTextWidget extends StatelessWidget {


  final List<String> _categorylabel = [
    'Bulbs',
    'Flowers',
    'Fruits',
    'Fungi',
    'Leaves',
    'Roots',
    'Seeds',
    'Stems',
    'Tubers',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categorylabel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ActionChip(
                          backgroundColor: Colors.green,
                          onPressed: () {},
                          label: Center(
                            child: Text(
                              _categorylabel[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
