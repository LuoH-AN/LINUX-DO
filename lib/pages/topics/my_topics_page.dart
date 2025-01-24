import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_topics_controller.dart';

class MyTopicsPage extends GetView<MyTopicsController> {
  const MyTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的帖子'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('我的帖子列表'),
      ),
    );
  }
}
