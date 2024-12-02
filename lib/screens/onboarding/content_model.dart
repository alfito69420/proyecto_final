class OnboardingContent {
  String? image;
  String? title;
  String? description;

  OnboardingContent({this.image, this.title, this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    image: "assets/onboarding/jaguar1.webp",
    title: "¡Adopta un jaguar!",
    description: "Adoptar a un jaguar a través de la Fundación Jaguares en la Selva "
    "ayuda a proteger una especie en peligro crítico, contribuyendo a su rehabilitación "
    "y reintroducción en su hábitat natural. "
  ),
  OnboardingContent(
    image: "assets/onboarding/jaguar2.png",
    title: "Nosotros",
    description: "Somos una organización sin fines de lucro con el objetivo de "
    "enseñar a diversas especies de félidos a regresar a su hábitat.\n\n"
    "Nuestra fundación realiza actividades en las instalaciones del Santuario "
    "del Jaguar Yaguar Xoo, un espacio abierto en el año 2000 originalmente para cuidar "
    "animales silvestres decomisados."
  ),
  OnboardingContent(
    image: "assets/onboarding/jaguar3.png",
    title: "Nuestros Logros",
    description: ""
  ),
];