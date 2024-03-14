import 'package:iqj/features/welcome/domain/welcome_panel.dart';

//Для добавления нового экрана просто дополните список еще одним экземпляром WelcomePanel.

const List<WelcomePanel> welcomePanelList = [
  WelcomePanel(
    title: 'Добро пожаловать!',
    image: 'assets/images/welcome/welcome_1.png',
    imagePosition: 'top',
  ),
  WelcomePanel(
    text: 'IQJ - инновационное приложение, разработанное специально для преподавателей университета МИРЭА',
    image: 'assets/images/welcome/welcome_2.png',
    imagePosition: 'bottom',
  ),
  WelcomePanel(
    title: 'Добро пожаловать!',
    text: 'Lorem ipsum dolor sit amet lorem ipsum dolor sit amet orem ipsum dolor sit amet orem ipsum dolor sit amet orem ipsum dolor sit amet orem ipsum dolor sit amet.',
    image: 'assets/images/welcome/welcome_3.png',
    imagePosition: 'top',
  ),
];
