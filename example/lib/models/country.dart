class Country {
  final String name;
  final String imageUrl;
  final String description;
  final double rating;
  final Map<String, String> benefits;
  final Map<String, String> resources;

  const Country({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.benefits,
    required this.resources,
  });

  static List<Country> sampleCountries = [
    Country(
      name: 'Portugal',
      imageUrl: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b',
      description: 'Portugal offers a high quality of life, rich culture, and excellent weather. The country provides various visa options for digital nomads and entrepreneurs, including the popular D7 and Golden Visa programs.',
      rating: 4.8,
      benefits: {
        'Tax Benefits': 'NHR program offering tax advantages for 10 years',
        'Residency': 'Multiple pathways to permanent residency and citizenship',
        'Quality of Life': 'High standard of living with affordable costs',
      },
      resources: {
        'Official Documentation': 'SEF website and visa information',
        'Local Community': 'Expat groups and local support networks',
        'Support Services': 'Legal assistance and relocation services',
      },
    ),
    Country(
      name: 'Estonia',
      imageUrl: 'https://images.unsplash.com/photo-1541778956932-8d6a16c1b31c',
      description: 'Estonia is a digital pioneer offering e-Residency and digital nomad visas. The country combines medieval charm with cutting-edge technology infrastructure.',
      rating: 4.6,
      benefits: {
        'Digital Infrastructure': 'Advanced e-government services',
        'Business Environment': 'Easy company registration and management',
        'Innovation': 'Strong startup ecosystem and tech community',
      },
      resources: {
        'E-Residency': 'Digital identity and business management',
        'Startup Estonia': 'Support for tech entrepreneurs',
        'Work in Estonia': 'Job opportunities and relocation assistance',
      },
    ),
    Country(
      name: 'Georgia',
      imageUrl: 'https://images.unsplash.com/photo-1565008576549-57569a49371d',
      description: 'Georgia offers a unique blend of ancient culture and modern opportunities. The country welcomes digital nomads and entrepreneurs with its Remotely from Georgia program.',
      rating: 4.5,
      benefits: {
        'Tax Benefits': 'Low tax rates and simple tax system',
        'Visa Policy': 'Visa-free stay for many nationalities',
        'Cost of Living': 'Affordable lifestyle with modern amenities',
      },
      resources: {
        'Business House': 'One-stop-shop for business registration',
        'Digital Nomad Hub': 'Coworking spaces and community',
        'Investment Guide': 'Information for foreign investors',
      },
    ),
  ];
} 