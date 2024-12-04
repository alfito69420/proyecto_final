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
    title: "El Poder que se Desvanece",
    description: 'A principios del siglo XX habitaban en México cerca de 40,000 jaguares '
    'en vida libre, hoy quedan menos de 4,000, su población ha disminuído drásticamente '
    'a lo largo de los años así como su distribución histórica que hoy en día es 40% menor.'
  ),
  OnboardingContent(
    image: "assets/onboarding/jaguar3.png",
    title: "Nuestros Logros",
    description: ""
  ),
];