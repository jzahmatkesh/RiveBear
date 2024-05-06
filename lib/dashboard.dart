import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late StateMachineController _controller;
  final pasfocus = FocusNode(), emailfocus = FocusNode();

  void onInit(Artboard artboard) async{
    _controller = StateMachineController.fromArtboard(artboard, 'State Machine 1')!;
    artboard.addController(_controller);
  }

  void handsUp(bool val){
    final success = _controller.findInput<bool>('hands_up');
    success!.change(val);
  }
  void look(){
    final success = _controller.findInput<bool>('Check');
    success!.change(!success.value);
  }

  @override
  void initState() {
    super.initState();
    pasfocus.addListener(() {
      handsUp(true);
    });
    emailfocus.addListener(() {
      handsUp(false);
      Future.delayed(const Duration(milliseconds: 300), (){
        look();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: RiveAnimation.asset(
              'images/bear.riv', 
              fit: BoxFit.cover,
              onInit: onInit,
            )
          ),
          const SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(15)
                ),
                hintText: 'Email',
              ),
              focusNode: emailfocus,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(15)
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(15)
                ),
                hintText: 'Password',
              ),
              obscureText: true,
              focusNode: pasfocus,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Success'),
                onPressed: (){
                  handsUp(false);
                  Future.delayed(const Duration(seconds: 2), (){
                    final success = _controller.findInput<bool>('success');
                    success!.change(true);
                  });
                }, 
              ),
              ElevatedButton(
                child: const Text('fail'),
                onPressed: (){
                  handsUp(false);
                  Future.delayed(const Duration(seconds: 2), (){
                    final success = _controller.findInput<bool>('fail');
                    success!.change(true);
                  });
                }, 
              ),
            ],
          )
        ],
      ),
    );
  }
}