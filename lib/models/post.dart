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

List<Post> posts = [
  Post(
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
  ),
  Post(
    imgUrl: 'https://jlbsjmdohyuyxycwpuin.supabase.co/storage/v1/object/public/proyecto_final_bucket/jaguars/celestun_y_nicte1.jpg', 
    title: 'Un Hito de Conservación',
    date: '28-06-2022',
    jaguarName: 'Celestún Petén y Nicté Ha',
    subtitle: 'Un hito de Conservación', 
    body: 'En octubre de 2016, el santuario '
          'recibió a dos jaguares que representaron una oportunidad única. Celestún Petén y Nicté Ha fueron '
          'dos crías hembra halladas a pocos días de nacer cerca de un potrero del poblado de Centauros del '
          'Norte, en la Reserva de la Biósfera de Calakmul, en Campeche.',
    body2:'La Comisión Nacional de Áreas Naturales Protegidas (Conanp) colocó a las crías bajo custodia del '
          'Jaguares en la Selva, para lo cual fueron trasladadas a sus instalaciones en Oaxaca. '
          'La organización puso en marcha un plan de trabajo que culminó en 2021 con la reintroducción '
          'de ambos ejemplares en las selvas de Quintana Roo.',
    additionalData: [
      AdditionalData(title: 'Ingreso al Santuario', value: 'Octubre del 2016'),
      AdditionalData(title: 'Fecha de liberación', value: 'Marzo del 2021'),
    ],
  )
];