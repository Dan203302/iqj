import 'package:iqj/features/welcome/domain/welcome_panel.dart';

const List<WelcomePanel> welcomePanelList = [
  WelcomePanel(
    title: 'Добро пожаловать!',
    image: 'assets/images/welcome_1.png',
    imagePosition: 'top',
  ),
  WelcomePanel(
    text: 'IQJ - инновационное приложение, разработанное специально для преподавателей университета МИРЭА',
    image: 'assets/images/welcome_2.png',
    imagePosition: 'bottom',
  ),
  WelcomePanel(
    title: 'Добро пожаловать!',
    text: 'Тут вроде должен будет быть еще какой-то текст, но тексты придумывать не моя задча, моя задача - размещать их на вступительном экране!',
  ),
];
