class CarousselItem {
  final String title;
  final String imageUrl;

  CarousselItem({
    required this.title,
    required this.imageUrl,
  });
}

List<CarousselItem> carousselItems = [
  CarousselItem(
    imageUrl: "assets/general/slide_home3.jpg",
    title: "¡El tiempo se agota!",
  ),
  CarousselItem(
    imageUrl: "assets/general/slide_home4.jpg",
    title: "El dios dorado te necesita",
  ),
  CarousselItem(
    imageUrl: "assets/general/slide_home1.jpg",
    title: "Haz que su rugido sea más fuerte",
  ),
  CarousselItem(
    imageUrl: "assets/general/slide_home2.jpg",
    title: "Ayúdanos a que suceda",
  ),
];