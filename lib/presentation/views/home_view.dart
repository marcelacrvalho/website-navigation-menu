import 'package:flutter/material.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({Key? key}) : super(key: key);

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  final scrollController = ScrollController();
  final key1 = GlobalKey();
  final key2 = GlobalKey();
  final key3 = GlobalKey();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          MyMenuWidget(
            onMenuClick: _onMenuClick,
          ),
          MySectionWidget(key: key1, color: Colors.amber),
          MySectionWidget(key: key2, color: Colors.blue),
          MySectionWidget(key: key3, color: Colors.red),
        ],
      ),
    );
  }

  void _onMenuClick(int value) {
    final RenderBox renderBox;
    switch (value) {
      case 1:
        renderBox = key1.currentContext!.findRenderObject() as RenderBox;
        break;
      case 2:
        renderBox = key2.currentContext!.findRenderObject() as RenderBox;
        break;
      case 3:
        renderBox = key3.currentContext!.findRenderObject() as RenderBox;
        break;
      default:
        renderBox = key1.currentContext!.findRenderObject() as RenderBox;
    }
    final offset = renderBox.localToGlobal(Offset.zero);
    scrollController.animateTo(
      offset.dy,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class MyMenuWidget extends StatelessWidget {
  final ValueChanged<int> onMenuClick;

  const MyMenuWidget({Key? key, required this.onMenuClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => onMenuClick(1),
          child: const Text('SEÇÃO 1'),
        ),
        TextButton(
          onPressed: () => onMenuClick(2),
          child: const Text('SEÇÃO 2'),
        ),
        TextButton(
          onPressed: () => onMenuClick(3),
          child: const Text('SEÇÃO 3'),
        ),
      ],
    );
  }
}

class MySectionWidget extends StatelessWidget {
  final Color color;

  const MySectionWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500.0,
      color: color,
    );
  }
}
