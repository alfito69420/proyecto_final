class Jaguar {
  final String name;
  final int age;
  final String sex;
  final String imageUrl;
  final String description;
  final String status;

  Jaguar({
    required this.name,
    required this.age,
    required this.sex,
    required this.imageUrl,
    required this.description,
    required this.status,
  });
}

List<Jaguar> jaguars = [
  Jaguar(
    name: 'Autano',
    age: 5,
    sex: 'Macho',
    imageUrl: 'assets/jaguars/autano1.jpg',
    description: 'Autano es un jaguar wey. Le encanta explorar su hábitat y es muy ágil al trepar árboles.',
    status: 'Disponible',
  ),
  Jaguar(
    name: 'Balam',
    age: 3,
    sex: 'Macho',
    imageUrl: 'assets/jaguars/balam1.jpg',
    description: 'Balam es un jaguar fuerte y territorial. Tiene un pelaje oscuro y manchas bien definidas.',
    status: 'Adoptado'
  ),
  Jaguar(
    name: 'Sugar',
    age: 1,
    sex: 'Hembra',
    imageUrl: 'assets/jaguars/sugar1.jpg',
    description: 'Sugar es la más joven del grupo. Es muy energética y le gusta jugar con enriquecimiento ambiental.',
    status: 'Liberado'
  ),
];
