

class Country {
  final String name;
  final String capital;
  final double population;
  final String region;
  final String motto;
  final String language;
  // final Array ethnicity;
  final String religion;
  final String government;
  final String independence;
  final double area;
  final String currency;
  final double gdp;
  final String timezone;
  final String dteformat;
  final String diallingCode;
  final String drivingSide;
  final String flagUrl;
  final String logoUrl;
  final String mapUrl;


  const Country({
    required this.name,
    required this.capital,
    required this.area,
    required this.currency,
    required this.diallingCode,
    required this.drivingSide,
    required this.dteformat,
    // required this.ethnicity,
    required this.flagUrl,
    required this.gdp,
    required this.government,
    required this.independence,
    required this.language,
    required this.logoUrl,
    required this.mapUrl,
    required this.motto,
    required this.population,
    required this.region,
    required this.religion,
    required this.timezone,

  });

  factory Country.empty() {
    return const Country (
      name: '',
      capital: '',
      area: 0,
      currency: '' ,
      diallingCode: '',
      drivingSide: '',
      dteformat: 'dd/mm/yyyy',
      flagUrl: '',
      gdp: 2.5,
      government: '',
      independence: '',
      language: '',
      logoUrl: '',
      mapUrl: '',
      motto: '',
      population: 0,
      region: '',
      religion: '',
      timezone: ''
    );


  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '',
      capital: json['capital'] == null ? '' : json['capital'].elementAt(0) ?? '',
      area: json['area'],
      currency: json['currencies'] == null ? '' : json['currencies'].keys.elementAt(0) ?? '' ,
      diallingCode: json['idd'] == null || json['idd']['root'] == null || json['idd']['suffixes'] == null ? '' : '${json['idd']['root'] ?? ''}${json['idd']['suffixes'].elementAt(0) ?? ''}',
      drivingSide: json['car']['side'] ?? '',
      dteformat: 'dd/mm/yyyy',
      flagUrl: json['flags']['png'] ?? '',
      gdp: 2.5,
      government: '',
      independence: '',
      language: json['languages'] == null ? '' : json['languages'][json['languages'].keys.elementAt(0)] ?? '',
      logoUrl: json['coatOfArms'] == null ? '' : json['coatOfArms']['png'] ?? '',
      mapUrl: json['maps'] == null ? '' : json['maps']['googleMaps'] ?? '',
      motto: '',
      population: json['population'],
      region: json['region'] ?? '',
      religion: '',
      timezone: json['timezones'] == null ? '' : json['timezones'].elementAt(0) ?? '',
    );
  }
}