import 'package:flutter/material.dart';
import 'package:iqj/features/welcome/data/welcome_data.dart';
import 'package:iqj/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _controller = PageController();
  bool onFirstPage = true;
  bool onLastPage = false;

  // Запись в память успешного прохождения начальных экранов.
  void userWelcomed() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        prefs.setBool('notAFirstLaunch', true);
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Страницы
            Align(
              child: PageView.builder(
                controller: _controller,
                itemCount: welcomePanelList.length,
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = index == welcomePanelList.length - 1;
                    onFirstPage = index == 0;
                  });
                },
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (welcomePanelList[index].imagePosition == 'top')
                        Image.asset(welcomePanelList[index].image!),
                      if (welcomePanelList[index].title != null)
                        Align(
                          alignment: welcomePanelList[index].text == null
                              ? Alignment.center
                              : Alignment.centerLeft,
                          child: Text(
                            welcomePanelList[index].title!,
                            textAlign: welcomePanelList[index].text == null
                                ? TextAlign.center
                                : TextAlign.left,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      if (welcomePanelList[index].text != null)
                        Text(
                          welcomePanelList[index].text!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                          ),
                        ),
                      if (welcomePanelList[index].imagePosition == 'bottom')
                        Image.asset(welcomePanelList[index].image!),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Кнопки и индикатор
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Индикатор
                  SmoothPageIndicator(
                    controller: _controller,
                    count: welcomePanelList.length,
                    effect: const JumpingDotEffect(
                      activeDotColor: Color(0xFFEFAC00),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: Stack(
                      children: [
                        // Назад
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          alignment: onFirstPage
                              ? Alignment.center
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              _controller.previousPage(
                                duration: const Duration(milliseconds: 240),
                                curve: Curves.ease,
                              );
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEFAC00),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Icon(
                                Icons.chevron_left_outlined,
                                color: Colors.white,
                                size: 42,
                              ),
                            ),
                          ),
                        ),
                        // Далее
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              onLastPage
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          userWelcomed();
                                          return App();
                                        },
                                      ),
                                    )
                                  : _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 240),
                                      curve: Curves.ease,
                                    );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              width: onFirstPage
                                  ? 300
                                  : 225, //На первой странице кнопка "дальше" просто перекрывает "назад"
                              decoration: const BoxDecoration(
                                color: Color(0xFFEFAC00),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Align(
                                child: Text(
                                  onLastPage ? 'Начнём!' : 'Дальше',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 55),
                ],
              ),
            ),
          ],
        ),
      );
}
