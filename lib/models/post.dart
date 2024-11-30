import 'package:proyecto_final/models/additional_data.dart';

class Post {
  final String imgUrl; //mauricio.png
  final String title; //Conoce a nuestro bebé jaguar
  final String date;
  final String? jaguarName; //Mauricio
  final String subtitle; //Nacido en la vida silvestre
  final String body; //Mauricio nació en bla bla tal dia
  final String? body2; //Con esto nos esperanzamos a bla bla
  final List<AdditionalData>? additionalData;

  Post({
    required this.imgUrl,
    required this.title,
    required this.date,
    this.jaguarName,
    required this.subtitle,
    required this.body,
    this.body2,
    this.additionalData,
  });
}

Post jaguarPost = Post(
  imgUrl: 'assets/jaguars/mauricio1.jpg', 
  title: 'Conoce a nuestro primer bebé silvestre',
  date: '30-11-2024',
  jaguarName: 'Mauricio',
  subtitle: 'Un símbolo de esperanza y conservación', 
  body: 'Mauricio nació en la vida silvestre el 20 de noviembre de 2024, un verdadero símbolo de esperanza y conservación.',
  body2: 'Con este nacimiento nos llenamos de esperanza para continuar preservando la biodiversidad y asegurando un futuro para estas majestuosas criaturas.',
  additionalData: [
    AdditionalData(title: 'Fecha de nacimiento', value: '20 de noviembre de 2024'),
    AdditionalData(title: 'Peso al nacer', value: 'Aproximadamente 700 gramos'),
    AdditionalData(title: 'Madre', value: 'Sugar'),
    AdditionalData(title: 'Ubicación', value: 'Selva Zoque de Oaxaca'),
  ],
);