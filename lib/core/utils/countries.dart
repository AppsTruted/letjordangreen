class City {
  final String name;
  final String code;

  City({required this.name, required this.code});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      code: json['code'],
    );
  }
}
class Country {
  final String name;
  final String code;
  final List<City>? cities;

  Country({required this.name, required this.code, this.cities});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      cities: json['cities'] != null
          ? (json['cities'] as List)
          .map((city) => City.fromJson(city))
          .toList()
          : null,
    );
  }
}

List<Country> countriesWithCodesAndCities = [
  Country(
    name: 'Afghanistan',
    code: 'AF',
    cities: [
      City(name: 'Kabul', code: 'KB'),
      City(name: 'Herat', code: 'HT'),
      City(name: 'Kandahar', code: 'KD'),
      City(name: 'Balkh', code: 'BL'),
      City(name: 'Nangarhar', code: 'NG'),
      City(name: 'Helmand', code: 'HL'),
      City(name: 'Badakhshan', code: 'BD'),
      City(name: 'Ghazni', code: 'GZ'),
      City(name: 'Paktia', code: 'PK'),
      City(name: 'Kunduz', code: 'KDZ'),


    ],
  ),
  Country(
    name: 'Albania',
    code: 'AL',
    cities: [
      City(name: 'Tirana', code: 'TR'),
      City(name: 'Durrës', code: 'DR'),
      City(name: 'Vlorë', code: 'VL'),
      City(name: 'Shkodër', code: 'SH'),
      City(name: 'Fier', code: 'FR'),
      City(name: 'Elbasan', code: 'EL'),
      City(name: 'Korçë', code: 'KO'),
      City(name: 'Berat', code: 'BR'),
      City(name: 'Gjirokastër', code: 'GJ'),
      City(name: 'Lezhë', code: 'LE'),
    ],
  ),
  Country(
    name: 'Algeria',
    code: 'DZ',
    cities: [
      City(name: 'Algiers', code: 'ALG'),
      City(name: 'Oran', code: 'ORN'),
      City(name: 'Constantine', code: 'CZL'),
    ],
  ),
  Country(
    name: 'Andorra',
    code: 'AD',
    cities: [
      City(name: 'Andorra la Vella', code: 'ALV'),
      City(name: 'Escaldes-Engordany', code: 'ESC'),
    ],
  ),
  Country(
    name: 'Angola',
    code: 'AO',
    cities: [
      City(name: 'Luanda', code: 'LAD'),
      City(name: 'Huambo', code: 'HUA'),
    ],
  ),
  Country(
    name: 'Antigua and Barbuda',
    code: 'AG',
    cities: [
      City(name: "St. John's", code: 'ANU'),
    ],
  ),
  Country(
    name: 'Argentina',
    code: 'AR',
    cities: [
      City(name: 'Buenos Aires', code: 'BUE'),
      City(name: 'Córdoba', code: 'COR'),
      City(name: 'Rosario', code: 'ROS'),
    ],
  ),
  Country(
    name: 'Armenia',
    code: 'AM',
    cities: [
      City(name: 'Yerevan', code: 'EVN'),
      City(name: 'Gyumri', code: 'LWN'),
    ],
  ),

  Country(
    name: 'Australia',
    code: 'AU',
    cities: [
      City(name: 'Sydney', code: 'SYD'),
      City(name: 'Melbourne', code: 'MEL'),
      City(name: 'Brisbane', code: 'BNE'),
    ],
  ),
  Country(
    name: 'Austria',
    code: 'AT',
    cities: [
      City(name: 'Vienna', code: 'VIE'),
      City(name: 'Salzburg', code: 'SZG'),
    ],
  ),
  Country(
    name: 'Azerbaijan',
    code: 'AZ',
    cities: [
      City(name: 'Baku', code: 'GYD'),
      City(name: 'Ganja', code: 'KVD'),
    ],
  ),
  Country(
    name: 'Bahamas',
    code: 'BS',
    cities: [
      City(name: 'Nassau', code: 'NAS'),
      City(name: 'Freeport', code: 'FPO'),
    ],
  ),
  Country(
    name: 'Bahrain',
    code: 'BH',
    cities: [
      City(name: 'Capital', code: 'CP'),
      City(name: 'Muharraq', code: 'MU'),
      City(name: 'Northern', code: 'NO'),
      City(name: 'Southern', code: 'SO'),
      City(name: 'Manama', code: 'MN'),
      City(name: 'Muharraq', code: 'MU'),
      City(name: 'Isa Town', code: 'IT'),
    ],
  ),
  Country(
    name: 'Bangladesh',
    code: 'BD',
    cities: [
      City(name: 'Dhaka', code: 'DAC'),
      City(name: 'Chittagong', code: 'CGP'),
    ],
  ),
  Country(
    name: 'Barbados',
    code: 'BB',
    cities: [
      City(name: 'Bridgetown', code: 'BGI'),
    ],
  ),
  Country(
    name: 'Belarus',
    code: 'BY',
    cities: [
      City(name: 'Minsk', code: 'MSQ'),
      City(name: 'Gomel', code: 'GME'),
    ],
  ),
  Country(
    name: 'Belgium',
    code: 'BE',
    cities: [
      City(name: 'Flanders', code: 'FL'),
      City(name: 'Wallonia', code: 'WL'),
      City(name: 'Brussels-Capital Region', code: 'BRU'),
    ],
  ),
  Country(
    name: 'Belize',
    code: 'BZ',
    cities: [
      City(name: 'Belmopan', code: 'BCV'),
      City(name: 'Belize City', code: 'BZE'),
    ],
  ),
  Country(
    name: 'Benin',
    code: 'BJ',
    cities: [
      City(name: 'Porto-Novo', code: 'PNV'),
      City(name: 'Cotonou', code: 'COO'),
    ],
  ),
  Country(
    name: 'Bhutan',
    code: 'BT',
    cities: [
      City(name: 'Thimphu', code: 'PBH'),
      City(name: 'Phuentsholing', code: 'PHE'),
    ],
  ),
  Country(
    name: 'Bolivia',
    code: 'BO',
    cities: [
      City(name: 'Sucre', code: 'SRE'),
      City(name: 'La Paz', code: 'LPB'),
    ],
  ),
  Country(
    name: 'Bosnia and Herzegovina',
    code: 'BA',
    cities: [
      City(name: 'Sarajevo', code: 'SJJ'),
      City(name: 'Banja Luka', code: 'BNX'),
    ],
  ),
  Country(
    name: 'Botswana',
    code: 'BW',
    cities: [
      City(name: 'Gaborone', code: 'GBE'),
      City(name: 'Francistown', code: 'FRW'),
    ],
  ),
  Country(
    name: 'Brazil',
    code: 'BR',
    cities: [
      City(name: 'São Paulo', code: 'GRU'),
      City(name: 'Rio de Janeiro', code: 'GIG'),
      City(name: 'Brasília', code: 'BSB'),
    ],
  ),
  Country(
    name: 'Brunei',
    code: 'BN',
    cities: [
      City(name: 'Bandar Seri Begawan', code: 'BWN'),
    ],
  ),

  Country(
    name: 'Bulgaria',
    code: 'BG',
    cities: [
      City(name: 'Sofia', code: 'SOF'),
      City(name: 'Plovdiv', code: 'PDV'),
    ],
  ),
  Country(
    name: 'Burkina Faso',
    code: 'BF',
    cities: [
      City(name: 'Ouagadougou', code: 'OUA'),
      City(name: 'Bobo-Dioulasso', code: 'BOY'),
    ],
  ),
  Country(
    name: 'Burundi',
    code: 'BI',
    cities: [
      City(name: 'Bujumbura', code: 'BJM'),
    ],
  ),
  Country(
    name: 'Cabo Verde',
    code: 'CV',
    cities: [
      City(name: 'Praia', code: 'RAI'),
    ],
  ),
  Country(
    name: 'Cambodia',
    code: 'KH',
    cities: [
      City(name: 'Phnom Penh', code: 'PNH'),
      City(name: 'Siem Reap', code: 'REP'),
    ],
  ),
  Country(
    name: 'Cameroon',
    code: 'CM',
    cities: [
      City(name: 'Yaoundé', code: 'NSI'),
      City(name: 'Douala', code: 'DLA'),
    ],
  ),
  Country(
    name: 'Canada',
    code: 'CA',
    cities: [
      City(name: 'Toronto', code: 'YYZ'),
      City(name: 'Vancouver', code: 'YVR'),
      City(name: 'Montreal', code: 'YUL'),
    ],
  ),
  Country(
    name: 'Central African Republic',
    code: 'CF',
    cities: [
      City(name: 'Bangui', code: 'BGF'),
    ],
  ),
  Country(
    name: 'Chad',
    code: 'TD',
    cities: [
      City(name: "N'Djamena", code: 'NDJ'),
    ],
  ),
  Country(
    name: 'Chile',
    code: 'CL',
    cities: [
      City(name: 'Santiago', code: 'SCL'),
      City(name: 'Valparaíso', code: 'VAP'),
    ],
  ),
  Country(
    name: 'China',
    code: 'CN',
    cities: [
      City(name: 'Beijing', code: 'PEK'),
      City(name: 'Shanghai', code: 'PVG'),
      City(name: 'Guangzhou', code: 'CAN'),
    ],
  ),
  Country(
    name: 'Colombia',
    code: 'CO',
    cities: [
      City(name: 'Bogotá', code: 'BOG'),
      City(name: 'Medellín', code: 'MDE'),
    ],
  ),
  Country(
    name: 'Comoros',
    code: 'KM',
    cities: [
      City(name: 'Grande Comore', code: 'GC'),
      City(name: 'Anjouan', code: 'AN'),
      City(name: 'Moheli', code: 'MO'),
      City(name: 'Mayotte (claimed)', code: 'MA'),
    ],
  ),
  Country(
    name: 'Congo (Congo-Brazzaville)',
    code: 'CG',
    cities: [
      City(name: 'Brazzaville', code: 'BZV'),
    ],
  ),
  Country(
    name: 'Costa Rica',
    code: 'CR',
    cities: [
      City(name: 'San José', code: 'SJO'),
    ],
  ),
  Country(
    name: 'Croatia',
    code: 'HR',
    cities: [
      City(name: 'Zagreb', code: 'ZAG'),
      City(name: 'Split', code: 'SPU'),
    ],
  ),
  Country(
    name: 'Cuba',
    code: 'CU',
    cities: [
      City(name: 'Havana', code: 'HAV'),
    ],
  ),
  Country(
    name: 'Cyprus',
    code: 'CY',
    cities: [
      City(name: 'Nicosia', code: 'NIC'),
      City(name: 'Limassol', code: 'LMS'),
    ],
  ),
  Country(
    name: 'Czech Republic',
    code: 'CZ',
    cities: [
      City(name: 'Prague', code: 'PRG'),
      City(name: 'Brno', code: 'BRQ'),
    ],
  ),
  Country(
    name: 'Democratic Republic of the Congo',
    code: 'CD',
    cities: [
      City(name: 'Kinshasa', code: 'FIH'),
      City(name: 'Lubumbashi', code: 'FBM'),
    ],
  ),

  Country(
    name: 'Denmark',
    code: 'DK',
    cities: [
      City(name: 'Copenhagen', code: 'CPH'),
      City(name: 'Aarhus', code: 'AAR'),
    ],
  ),
  Country(
    name: 'Djibouti',
    code: 'DJ',
    cities: [
      City(name: 'Arta', code: 'AR'),
      City(name: 'Ali Sabieh', code: 'AS'),
      City(name: 'Dikhil', code: 'DI'),
      City(name: 'Obock', code: 'OB'),
      City(name: 'Tadjourah', code: 'TA'),
      City(name: 'Djibouti City', code: 'DC'),
    ],
  ),
  Country(
    name: 'Dominica',
    code: 'DM',
    cities: [
      City(name: 'Roseau', code: 'DOM'),
    ],
  ),
  Country(
    name: 'Dominican Republic',
    code: 'DO',
    cities: [
      City(name: 'Santo Domingo', code: 'SDQ'),
    ],
  ),
  Country(
    name: 'East Timor (Timor-Leste)',
    code: 'TL',
    cities: [
      City(name: 'Dili', code: 'DIL'),
    ],
  ),
  Country(
    name: 'Ecuador',
    code: 'EC',
    cities: [
      City(name: 'Quito', code: 'UIO'),
      City(name: 'Guayaquil', code: 'GYE'),
    ],
  ),
  Country(
    name: 'Egypt',
    code: 'EG',
    cities: [
      City(name: 'Cairo', code: 'CAI'),
      City(name: 'Alexandria', code: 'ALY'),
      City(name: 'Giza', code: 'GZ'),
      City(name: 'Dakahlia', code: 'DK'),
      City(name: 'Red Sea', code: 'RS'),
      City(name: 'Sharqia', code: 'SH'),
      City(name: 'Beheira', code: 'BH'),
      City(name: 'Minya', code: 'MN'),
      City(name: 'Qalyubia', code: 'QL'),
      City(name: 'Sohag', code: 'SG'),
      City(name: 'Fayoum', code: 'FY'),
      City(name: 'Aswan', code: 'AS'),
      City(name: 'Luxor', code: 'LX'),
      City(name: 'Sharm El Sheikh', code: 'SSH'),
    ],
  ),
  Country(
    name: 'El Salvador',
    code: 'SV',
    cities: [
      City(name: 'San Salvador', code: 'SAL'),
    ],
  ),
  Country(
    name: 'Equatorial Guinea',
    code: 'GQ',
    cities: [
      City(name: 'Malabo', code: 'SSG'),
    ],
  ),
  Country(
    name: 'Eritrea',
    code: 'ER',
    cities: [
      City(name: 'Asmara', code: 'ASM'),
    ],
  ),
  Country(
    name: 'Estonia',
    code: 'EE',
    cities: [
      City(name: 'Tallinn', code: 'TLL'),
    ],
  ),
  Country(
    name: 'Eswatini',
    code: 'SZ',
    cities: [
      City(name: 'Mbabane', code: 'MTS'),
    ],
  ),
  Country(
    name: 'Ethiopia',
    code: 'ET',
    cities: [
      City(name: 'Addis Ababa', code: 'ADD'),
    ],
  ),

  Country(
    name: 'Fiji',
    code: 'FJ',
    cities: [
      City(name: 'Suva', code: 'SUV'),
    ],
  ),
  Country(
    name: 'Finland',
    code: 'FI',
    cities: [
      City(name: 'Helsinki', code: 'HEL'),
    ],
  ),
  Country(
    name: 'France',
    code: 'FR',
    cities: [
      City(name: 'Paris', code: 'CDG'),
      City(name: 'Marseille', code: 'MRS'),
      City(name: 'Lyon', code: 'LYS'),
      City(name: 'Île-de-France', code: 'IDF'),
      City(name: "Provence-Alpes-Côte d'Azur", code: 'PACA'),
      City(name: 'Auvergne-Rhône-Alpes', code: 'ARA'),
      City(name: 'Nouvelle-Aquitaine', code: 'NA'),
      City(name: 'Occitanie', code: 'OCC'),
      City(name: 'Hauts-de-France', code: 'HDF'),
      City(name: 'Brittany', code: 'BR'),
      City(name: 'Normandy', code: 'NOR'),
      City(name: 'Grand Est', code: 'GE'),
    ],
  ),
  Country(
    name: 'Gabon',
    code: 'GA',
    cities: [
      City(name: 'Libreville', code: 'LBV'),
    ],
  ),
  Country(
    name: 'Gambia',
    code: 'GM',
    cities: [
      City(name: 'Banjul', code: 'BJL'),
    ],
  ),
  Country(
    name: 'Georgia',
    code: 'GE',
    cities: [
      City(name: 'Tbilisi', code: 'TBS'),
    ],
  ),
  Country(
    name: 'Germany',
    code: 'DE',
    cities: [
      City(name: 'Berlin', code: 'BER'),
      City(name: 'Munich', code: 'MUC'),
      City(name: 'Frankfurt', code: 'FRA'),
      City(name: 'Baden-Württemberg', code: 'BW'),
      City(name: 'Bavaria', code: 'BY'),
      City(name: 'Brandenburg', code: 'BB'),
      City(name: 'Bremen', code: 'HB'),
      City(name: 'Hamburg', code: 'HH'),
      City(name: 'Hesse', code: 'HE'),
      City(name: 'Lower Saxony', code: 'NI'),
      City(name: 'Mecklenburg-Vorpommern', code: 'MV'),
      City(name: 'North Rhine-Westphalia', code: 'NW'),
      City(name: 'Rhineland-Palatinate', code: 'RP'),
      City(name: 'Saarland', code: 'SL'),
      City(name: 'Saxony', code: 'SN'),
      City(name: 'Saxony-Anhalt', code: 'ST'),
      City(name: 'Schleswig-Holstein', code: 'SH'),
      City(name: 'Thuringia', code: 'TH'),
    ],
  ),
  Country(
    name: 'Ghana',
    code: 'GH',
    cities: [
      City(name: 'Accra', code: 'ACC'),
      City(name: 'Kumasi', code: 'KMS'),
    ],
  ),
  Country(
    name: 'Greece',
    code: 'GR',
    cities: [
      City(name: 'Athens', code: 'ATH'),
      City(name: 'Thessaloniki', code: 'SKG'),
    ],
  ),
  Country(
    name: 'Grenada',
    code: 'GD',
    cities: [
      City(name: "St. George's", code: 'GND'),
    ],
  ),
  Country(
    name: 'Guatemala',
    code: 'GT',
    cities: [
      City(name: 'Guatemala City', code: 'GUA'),
    ],
  ),
  Country(
    name: 'Guinea',
    code: 'GN',
    cities: [
      City(name: 'Conakry', code: 'CKY'),
    ],
  ),
  Country(
    name: 'Guinea-Bissau',
    code: 'GW',
    cities: [
      City(name: 'Bissau', code: 'OXB'),
    ],
  ),
  Country(
    name: 'Guyana',
    code: 'GY',
    cities: [
      City(name: 'Georgetown', code: 'GEO'),
    ],
  ),
  Country(
    name: 'Haiti',
    code: 'HT',
    cities: [
      City(name: 'Port-au-Prince', code: 'PAP'),
    ],
  ),
  Country(
    name: 'Honduras',
    code: 'HN',
    cities: [
      City(name: 'Tegucigalpa', code: 'TGU'),
    ],
  ),
  Country(
    name: 'Hungary',
    code: 'HU',
    cities: [
      City(name: 'Budapest', code: 'BUD'),
    ],
  ),
  Country(
    name: 'Iceland',
    code: 'IS',
    cities: [
      City(name: 'Reykjavik', code: 'RKV'),
    ],
  ),
  Country(
    name: 'India',
    code: 'IN',
    cities: [
      City(name: 'New Delhi', code: 'DEL'),
      City(name: 'Mumbai', code: 'BOM'),
      City(name: 'Bangalore', code: 'BLR'),
    ],
  ),
  Country(
    name: 'Indonesia',
    code: 'ID',
    cities: [
      City(name: 'Jakarta', code: 'CGK'),
      City(name: 'Bali', code: 'DPS'),
    ],
  ),
  Country(
    name: 'Iran',
    code: 'IR',
    cities: [
      City(name: 'Tehran', code: 'IKA'),
    ],
  ),
  Country(
    name: 'Iraq',
    code: 'IQ',
    cities: [
      City(name: 'Basra', code: 'BS'),
      City(name: 'Najaf', code: 'NJ'),
      City(name: 'Karbala', code: 'KR'),
      City(name: 'Sulaymaniyah', code: 'SU'),
      City(name: 'Dhi Qar', code: 'DQ'),
      City(name: 'Nineveh', code: 'NV'),
      City(name: 'Mosul', code: 'OSM'),
    ],
  ),
  Country(
    name: 'Ireland',
    code: 'IE',
    cities: [
      City(name: 'Dublin', code: 'DUB'),
      City(name: 'Cork', code: 'ORK'),
    ],
  ),
  Country(
    name: 'Israel',
    code: 'IL',
    cities: [
      City(name: 'Tel Aviv', code: 'TLV'),
      City(name: 'Jerusalem', code: 'JRS'),
    ],
  ),
  Country(
    name: 'Italy',
    code: 'IT',
    cities: [
      City(name: 'Rome', code: 'FCO'),
      City(name: 'Milan', code: 'MXP'),
      City(name: 'Venice', code: 'VCE'),
      City(name: 'Lazio', code: 'LA'),
      City(name: 'Lombardy', code: 'LO'),
      City(name: 'Tuscany', code: 'TO'),
      City(name: 'Sicily', code: 'SI'),
      City(name: 'Veneto', code: 'VE'),
      City(name: 'Piedmont', code: 'PI'),
      City(name: 'Emilia-Romagna', code: 'ER'),
      City(name: 'Campania', code: 'CA'),
      City(name: 'Liguria', code: 'LI'),
      City(name: 'Sardinia', code: 'SA'),
    ],
  ),
  Country(
    name: 'Jamaica',
    code: 'JM',
    cities: [
      City(name: 'Kingston', code: 'KIN'),
    ],
  ),

  Country(
    name: 'Japan',
    code: 'JP',
    cities: [
      City(name: 'Tokyo', code: 'HND'),
      City(name: 'Osaka', code: 'KIX'),
      City(name: 'Nagoya', code: 'NGO'),
    ],
  ),
  Country(
    name: 'Jordan',
    code: 'JO',
    cities: [
      City(name: 'Amman', code: 'AMM'),
      City(name: 'Zarqa', code: 'ZA'),
      City(name: 'Irbid', code: 'IR'),
      City(name: 'Mafraq', code: 'MA'),
      City(name: 'Balqa', code: 'BA'),
      City(name: 'Karak', code: 'KR'),
      City(name: 'Madaba', code: 'MD'),
      City(name: 'Tafilah', code: 'TF'),
      City(name: "Ma'an", code: 'MN'),
      City(name: 'Aqaba', code: 'AQ'),
      City(name: 'Jerash', code: 'JR'),
      City(name: 'Ajloun', code: 'AJ'),
    ],
  ),
  Country(
    name: 'Kazakhstan',
    code: 'KZ',
    cities: [
      City(name: 'Nur-Sultan', code: 'NQZ'),
      City(name: 'Almaty', code: 'ALA'),
    ],
  ),
  Country(
    name: 'Kenya',
    code: 'KE',
    cities: [
      City(name: 'Nairobi', code: 'NBO'),
      City(name: 'Mombasa', code: 'MBA'),
    ],
  ),
  Country(
    name: 'Kiribati',
    code: 'KI',
    cities: [
      City(name: 'Tarawa', code: 'TRW'),
    ],
  ),
  Country(
    name: 'Kuwait',
    code: 'KW',
    cities: [
      City(name: 'Kuwait City', code: 'KWI'),
      City(name: 'Al Asimah', code: 'AS'),
      City(name: 'Hawalli', code: 'HA'),
      City(name: 'Al Ahmadi', code: 'AH'),
      City(name: 'Farwaniya', code: 'FA'),
      City(name: 'Jahra', code: 'JA'),
      City(name: 'Mubarak Al-Kabeer', code: 'MK'),
      City(name: 'Salmiya', code: 'SAL'),
      City(name: 'Hawalli', code: 'HAW'),
    ],
  ),
  Country(
    name: 'Kyrgyzstan',
    code: 'KG',
    cities: [
      City(name: 'Bishkek', code: 'FRU'),
    ],
  ),
  Country(
    name: 'Laos',
    code: 'LA',
    cities: [
      City(name: 'Vientiane', code: 'VTE'),
    ],
  ),
  Country(
    name: 'Latvia',
    code: 'LV',
    cities: [
      City(name: 'Riga', code: 'RIX'),
    ],
  ),
  Country(
    name: 'Lebanon',
    code: 'LB',
    cities: [
      City(name: 'Beirut', code: 'BEY'),
      City(name: 'Tripoli', code: 'TIR'),
      City(name: 'Mount Lebanon', code: 'ML'),
      City(name: 'North Lebanon', code: 'NL'),
      City(name: 'Bekaa', code: 'BK'),
      City(name: 'South Lebanon', code: 'SL'),
      City(name: 'Nabatieh', code: 'NB'),
      City(name: 'Akkar', code: 'AK'),
      City(name: 'Baalbek-Hermel', code: 'BH'),
      City(name: 'Sidon', code: 'SID'),
    ],
  ),
  Country(
    name: 'Lesotho',
    code: 'LS',
    cities: [
      City(name: 'Maseru', code: 'MSU'),
    ],
  ),

  Country(
    name: 'Liberia',
    code: 'LR',
    cities: [
      City(name: 'Monrovia', code: 'MLW'),
    ],
  ),
  Country(
    name: 'Libya',
    code: 'LY',
    cities: [
      City(name: 'Tripoli', code: 'TIP'),
      City(name: 'Benghazi', code: 'BEN'),
    ],
  ),
  Country(
    name: 'Liechtenstein',
    code: 'LI',
    cities: [
      City(name: 'Vaduz', code: 'VDZ'),
    ],
  ),
  Country(
    name: 'Lithuania',
    code: 'LT',
    cities: [
      City(name: 'Vilnius', code: 'VNO'),
    ],
  ),
  Country(
    name: 'Luxembourg',
    code: 'LU',
    cities: [
      City(name: 'Luxembourg City', code: 'LUX'),
    ],
  ),
  Country(
    name: 'Madagascar',
    code: 'MG',
    cities: [
      City(name: 'Antananarivo', code: 'TNR'),
    ],
  ),
  Country(
    name: 'Malawi',
    code: 'MW',
    cities: [
      City(name: 'Lilongwe', code: 'LLW'),
      City(name: 'Blantyre', code: 'BLZ'),
    ],
  ),
  Country(
    name: 'Malaysia',
    code: 'MY',
    cities: [
      City(name: 'Kuala Lumpur', code: 'KUL'),
      City(name: 'Penang', code: 'PEN'),
    ],
  ),
  Country(
    name: 'Maldives',
    code: 'MV',
    cities: [
      City(name: 'Malé', code: 'MLE'),
    ],
  ),
  Country(
    name: 'Mali',
    code: 'ML',
    cities: [
      City(name: 'Bamako', code: 'BKO'),
    ],
  ),
  Country(
    name: 'Malta',
    code: 'MT',
    cities: [
      City(name: 'Valletta', code: 'MLA'),
    ],
  ),
  Country(
    name: 'Marshall Islands',
    code: 'MH',
    cities: [
      City(name: 'Majuro', code: 'MAJ'),
    ],
  ),
  Country(
    name: 'Mauritania',
    code: 'MR',
    cities: [
      City(name: 'Nouakchott', code: 'NKC'),
      City(name: 'Dakhlet Nouadhibou', code: 'DN'),
      City(name: 'Hodh Ech Chargui', code: 'HS'),
      City(name: 'Assaba', code: 'AS'),
      City(name: 'Gorgol', code: 'GO'),
      City(name: 'Brakna', code: 'BR'),
      City(name: 'Nouadhibou', code: 'NDB'),
    ],
  ),
  Country(
    name: 'Mauritius',
    code: 'MU',
    cities: [
      City(name: 'Port Louis', code: 'MRU'),
    ],
  ),
  Country(
    name: 'Mexico',
    code: 'MX',
    cities: [
      City(name: 'Mexico City', code: 'MEX'),
      City(name: 'Cancún', code: 'CUN'),
    ],
  ),
  Country(
    name: 'Micronesia',
    code: 'FM',
    cities: [
      City(name: 'Palikir', code: 'PNI'),
    ],
  ),
  Country(
    name: 'Moldova',
    code: 'MD',
    cities: [
      City(name: 'Chișinău', code: 'KIV'),
    ],
  ),
  Country(
    name: 'Monaco',
    code: 'MC',
    cities: [
      City(name: 'Monaco', code: 'MCM'),
    ],
  ),
  Country(
    name: 'Mongolia',
    code: 'MN',
    cities: [
      City(name: 'Ulaanbaatar', code: 'ULN'),
    ],
  ),
  Country(
    name: 'Montenegro',
    code: 'ME',
    cities: [
      City(name: 'Podgorica', code: 'TGD'),
    ],
  ),
  Country(
    name: 'Morocco',
    code: 'MA',
    cities: [
      City(name: 'Rabat', code: 'RBA'),
      City(name: 'Casablanca', code: 'CMN'),
      City(name: 'Rabat-Salé-Kénitra', code: 'RSK'),
      City(name: 'Casablanca-Settat', code: 'CS'),
      City(name: 'Marrakesh-Safi', code: 'MS'),
      City(name: 'Fès-Meknès', code: 'FM'),
      City(name: 'Tanger-Tétouan-Al Hoceima', code: 'TTA'),
      City(name: 'Oriental', code: 'OR'),
      City(name: 'Souss-Massa', code: 'SM'),
      City(name: 'Béni Mellal-Khénifra', code: 'BMK'),
      City(name: 'Guelmim-Oued Noun', code: 'GON'),
      City(name: 'Laâyoune-Sakia El Hamra', code: 'LSH'),
      City(name: 'Marrakesh', code: 'RAK'),
    ],
  ),
  Country(
    name: 'Mozambique',
    code: 'MZ',
    cities: [
      City(name: 'Maputo', code: 'MPM'),
    ],
  ),
  Country(
    name: 'Myanmar (Burma)',
    code: 'MM',
    cities: [
      City(name: 'Naypyidaw', code: 'NYT'),
      City(name: 'Yangon', code: 'RGN'),
    ],
  ),
  Country(
    name: 'Namibia',
    code: 'NA',
    cities: [
      City(name: 'Windhoek', code: 'WDH'),
    ],
  ),
  Country(
    name: 'Nauru',
    code: 'NR',
    cities: [
      City(name: 'Yaren', code: 'INN'),
    ],
  ),
  Country(
    name: 'Nepal',
    code: 'NP',
    cities: [
      City(name: 'Kathmandu', code: 'KTM'),
    ],
  ),
  Country(
    name: 'Netherlands',
    code: 'NL',
    cities: [
      City(name: 'Amsterdam', code: 'AMS'),
      City(name: 'Rotterdam', code: 'RTM'),
      City(name: 'North Holland', code: 'NH'),
      City(name: 'South Holland', code: 'ZH'),
      City(name: 'Utrecht', code: 'UT'),
      City(name: 'Gelderland', code: 'GE'),
      City(name: 'North Brabant', code: 'NB'),
      City(name: 'Limburg', code: 'LI'),
      City(name: 'Friesland', code: 'FR'),
      City(name: 'The Hague', code: 'HAG'),
      City(name: 'Eindhoven', code: 'EIN'),
    ],
  ),
  Country(
    name: 'New Zealand',
    code: 'NZ',
    cities: [
      City(name: 'Auckland', code: 'AKL'),
      City(name: 'Wellington', code: 'WLG'),
    ],
  ),
  Country(
    name: 'Nicaragua',
    code: 'NI',
    cities: [
      City(name: 'Managua', code: 'MGA'),
    ],
  ),
  Country(
    name: 'Niger',
    code: 'NE',
    cities: [
      City(name: 'Niamey', code: 'NIM'),
    ],
  ),
  Country(
    name: 'Nigeria',
    code: 'NG',
    cities: [
      City(name: 'Lagos', code: 'LOS'),
      City(name: 'Abuja', code: 'ABV'),
    ],
  ),
  Country(
    name: 'North Korea',
    code: 'KP',
    cities: [
      City(name: 'Pyongyang', code: 'FNJ'),
    ],
  ),
  Country(
    name: 'North Macedonia',
    code: 'MK',
    cities: [
      City(name: 'Skopje', code: 'SKP'),
    ],
  ),
  Country(
    name: 'Norway',
    code: 'NO',
    cities: [
      City(name: 'Oslo', code: 'OSL'),
      City(name: 'Bergen', code: 'BGO'),
    ],
  ),
  Country(
    name: 'Oman',
    code: 'OM',
    cities: [
      City(name: 'Muscat', code: 'MCT'),
      City(name: 'Dhofar', code: 'DH'),
      City(name: 'Al Batinah South', code: 'BS'),
      City(name: 'Al Batinah North', code: 'BN'),
      City(name: 'Ad Dakhiliyah', code: 'DA'),
      City(name: 'Ash Sharqiyah South', code: 'SS'),
      City(name: 'Ash Sharqiyah North', code: 'SN'),
      City(name: 'Salalah', code: 'SLL'),
      City(name: 'Sohar', code: 'SOH'),
    ],
  ),
  Country(
    name: 'Palestine',
    code: 'PS',
    cities: [
      City(name: 'North Gaza', code: 'NG'),
      City(name: 'Gaza', code: 'GA'),
      City(name: 'Khan Younis', code: 'KY'),
      City(name: 'Bethlehem', code: 'BL'),
      City(name: 'Hebron', code: 'HE'),
      City(name: 'Nablus', code: 'NA'),
      City(name: 'Ramallah and Al-Bireh', code: 'RA'),
      City(name: 'Ramallah', code: 'RML'),
    ],
  ),
  Country(
    name: 'Pakistan',
    code: 'PK',
    cities: [
      City(name: 'Islamabad', code: 'ISB'),
      City(name: 'Karachi', code: 'KHI'),
      City(name: 'Lahore', code: 'LHE'),
    ],
  ),
  Country(
    name: 'Palau',
    code: 'PW',
    cities: [
      City(name: 'Ngerulmud', code: 'NRL'),
    ],
  ),
  Country(
    name: 'Panama',
    code: 'PA',
    cities: [
      City(name: 'Panama City', code: 'PTY'),
    ],
  ),
  Country(
    name: 'Papua New Guinea',
    code: 'PG',
    cities: [
      City(name: 'Port Moresby', code: 'POM'),
    ],
  ),
  Country(
    name: 'Paraguay',
    code: 'PY',
    cities: [
      City(name: 'Asunción', code: 'ASU'),
    ],
  ),
  Country(
    name: 'Peru',
    code: 'PE',
    cities: [
      City(name: 'Lima', code: 'LIM'),
      City(name: 'Cusco', code: 'CUZ'),
    ],
  ),

  Country(
    name: 'Philippines',
    code: 'PH',
    cities: [
      City(name: 'Manila', code: 'MNL'),
      City(name: 'Cebu', code: 'CEB'),
    ],
  ),
  Country(
    name: 'Poland',
    code: 'PL',
    cities: [
      City(name: 'Warsaw', code: 'WAW'),
      City(name: 'Kraków', code: 'KRK'),
    ],
  ),
  Country(
    name: 'Portugal',
    code: 'PT',
    cities: [
      City(name: 'Lisbon', code: 'LIS'),
      City(name: 'Porto', code: 'OPO'),
    ],
  ),
  Country(
    name: 'Qatar',
    code: 'QA',
    cities: [
      City(name: 'Doha', code: 'DOH'),
      City(name: 'Al Rayyan', code: 'RA'),
      City(name: 'Al Wakrah', code: 'WA'),
      City(name: 'Umm Salal', code: 'UM'),
      City(name: 'Al Khor', code: 'KH'),
      City(name: 'Al Daayen', code: 'DA'),
      City(name: 'Al Shamal', code: 'SH'),
    ],
  ),
  Country(
    name: 'Romania',
    code: 'RO',
    cities: [
      City(name: 'Bucharest', code: 'OTP'),
    ],
  ),
  Country(
    name: 'Russia',
    code: 'RU',
    cities: [
      City(name: 'Moscow', code: 'SVO'),
      City(name: 'Saint Petersburg', code: 'LED'),
    ],
  ),
  Country(
    name: 'Rwanda',
    code: 'RW',
    cities: [
      City(name: 'Kigali', code: 'KGL'),
    ],
  ),
  Country(
    name: 'Saint Kitts and Nevis',
    code: 'KN',
    cities: [
      City(name: 'Basseterre', code: 'BAS'),
    ],
  ),
  Country(
    name: 'Saint Lucia',
    code: 'LC',
    cities: [
      City(name: 'Castries', code: 'SLU'),
    ],
  ),
  Country(
    name: 'Saint Vincent and the Grenadines',
    code: 'VC',
    cities: [
      City(name: 'Kingstown', code: 'SVD'),
    ],
  ),
  Country(
    name: 'Samoa',
    code: 'WS',
    cities: [
      City(name: 'Apia', code: 'APW'),
    ],
  ),
  Country(
    name: 'San Marino',
    code: 'SM',
    cities: [
      City(name: 'San Marino', code: 'SMR'),
    ],
  ),
  Country(
    name: 'Sao Tome and Principe',
    code: 'ST',
    cities: [
      City(name: 'São Tomé', code: 'TMS'),
    ],
  ),
  Country(
    name: 'Saudi Arabia',
    code: 'SA',
    cities: [
      City(name: 'Riyadh', code: 'RUH'),
      City(name: 'Jeddah', code: 'JED'),
      City(name: 'Makkah', code: '02'),
      City(name: 'Medina', code: '03'),
      City(name: 'Eastern Province (Ash Sharqiyah)', code: '04'),
      City(name: 'Asir', code: '05'),
      City(name: 'Tabuk', code: '06'),
      City(name: 'Hail', code: '07'),
      City(name: 'Al-Jawf', code: '08'),
      City(name: 'Jazan', code: '09'),
      City(name: 'Najran', code: '10'),
      City(name: 'Al-Bahah', code: '11'),
      City(name: 'Northern Borders', code: '12'),
      City(name: 'Al-Qassim', code: '13'),
      City(name: 'Dammam', code: 'DMM'),
    ],
  ),

  Country(
    name: 'Senegal',
    code: 'SN',
    cities: [
      City(name: 'Dakar', code: 'DKR'),
    ],
  ),
  Country(
    name: 'Serbia',
    code: 'RS',
    cities: [
      City(name: 'Belgrade', code: 'BEG'),
    ],
  ),
  Country(
    name: 'Seychelles',
    code: 'SC',
    cities: [
      City(name: 'Victoria', code: 'SEZ'),
    ],
  ),
  Country(
    name: 'Sierra Leone',
    code: 'SL',
    cities: [
      City(name: 'Freetown', code: 'FNA'),
    ],
  ),
  Country(
    name: 'Singapore',
    code: 'SG',
    cities: [
      City(name: 'Singapore', code: 'SIN'),
    ],
  ),
  Country(
    name: 'Slovakia',
    code: 'SK',
    cities: [
      City(name: 'Bratislava', code: 'BTS'),
    ],
  ),
  Country(
    name: 'Slovenia',
    code: 'SI',
    cities: [
      City(name: 'Ljubljana', code: 'LJU'),
    ],
  ),
  Country(
    name: 'Solomon Islands',
    code: 'SB',
    cities: [
      City(name: 'Honiara', code: 'HIR'),
    ],
  ),
  Country(
    name: 'Somalia',
    code: 'SO',
    cities: [
      City(name: 'Mogadishu', code: 'MGQ'),
      City(name: 'Banaadir', code: 'BA'),
      City(name: 'Hargeisa', code: 'HR'),
      City(name: 'Puntland', code: 'PL'),
      City(name: 'Mudug', code: 'MD'),
      City(name: 'Bay', code: 'BY'),
      City(name: 'Bosaso', code: 'BSA'),
    ],
  ),
  Country(
    name: 'South Africa',
    code: 'ZA',
    cities: [
      City(name: 'Cape Town', code: 'CPT'),
      City(name: 'Johannesburg', code: 'JNB'),
    ],
  ),
  Country(
    name: 'South Korea',
    code: 'KR',
    cities: [
      City(name: 'Seoul', code: 'ICN'),
      City(name: 'Busan', code: 'PUS'),
    ],
  ),
  Country(
    name: 'South Sudan',
    code: 'SS',
    cities: [
      City(name: 'Juba', code: 'JUB'),
    ],
  ),
  Country(
    name: 'Spain',
    code: 'ES',
    cities: [
      City(name: 'Madrid', code: 'MAD'),
      City(name: 'Barcelona', code: 'BCN'),
      City(name: 'Andalusia', code: 'AN'),
      City(name: 'Catalonia', code: 'CT'),
      City(name: 'Valencia', code: 'VC'),
      City(name: 'Galicia', code: 'GA'),
      City(name: 'Basque Country', code: 'PV'),
      City(name: 'Castile and León', code: 'CL'),
      City(name: 'Castile-La Mancha', code: 'CM'),
      City(name: 'Canary Islands', code: 'CN'),
    ],
  ),

  Country(
    name: 'Sri Lanka',
    code: 'LK',
    cities: [
      City(name: 'Colombo', code: 'CMB'),
      City(name: 'Kandy', code: 'KDW'),
    ],
  ),
  Country(
    name: 'Sudan',
    code: 'SD',
    cities: [
      City(name: 'Khartoum', code: 'KRT'),
      City(name: 'North Darfur', code: 'ND'),
      City(name: 'South Darfur', code: 'SD'),
      City(name: 'Red Sea', code: 'RS'),
      City(name: 'Gezira', code: 'GZ'),
      City(name: 'Kassala', code: 'KS'),
      City(name: 'White Nile', code: 'WN'),
      City(name: 'West Darfur', code: 'WD'),
      City(name: 'Omdurman', code: 'OMD'),
      City(name: 'Port Sudan', code: 'PZU'),
    ],
  ),
  Country(
    name: 'Suriname',
    code: 'SR',
    cities: [
      City(name: 'Paramaribo', code: 'PBM'),
    ],
  ),
  Country(
    name: 'Sweden',
    code: 'SE',
    cities: [
      City(name: 'Stockholm', code: 'ARN'),
    ],
  ),
  Country(
    name: 'Switzerland',
    code: 'CH',
    cities: [
      City(name: 'Zurich', code: 'ZRH'),
      City(name: 'Geneva', code: 'GVA'),
      City(name: 'Bern', code: 'BE'),
      City(name: 'Vaud', code: 'VD'),
      City(name: 'Aargau', code: 'AG'),
      City(name: 'Ticino', code: 'TI'),
    ],
  ),
  Country(
    name: 'Syria',
    code: 'SY',
    cities: [
      City(name: 'Damascus', code: 'DAM'),
      City(name: 'Aleppo', code: 'ALP'),
      City(name: 'Homs', code: 'HM'),
      City(name: 'Hama', code: 'HA'),
      City(name: 'Latakia', code: 'LA'),
      City(name: 'Deir ez-Zor', code: 'DZ'),
      City(name: 'Raqqa', code: 'RQ'),
    ],
  ),
  Country(
    name: 'Taiwan',
    code: 'TW',
    cities: [
      City(name: 'Taipei', code: 'TPE'),
      City(name: 'Kaohsiung', code: 'KHH'),
    ],
  ),
  Country(
    name: 'Tajikistan',
    code: 'TJ',
    cities: [
      City(name: 'Dushanbe', code: 'DYU'),
    ],
  ),
  Country(
    name: 'Tanzania',
    code: 'TZ',
    cities: [
      City(name: 'Dar es Salaam', code: 'DAR'),
      City(name: 'Zanzibar', code: 'ZNZ'),
    ],
  ),
  Country(
    name: 'Thailand',
    code: 'TH',
    cities: [
      City(name: 'Bangkok', code: 'BKK'),
      City(name: 'Chiang Mai', code: 'CNX'),
    ],
  ),
  Country(
    name: 'Togo',
    code: 'TG',
    cities: [
      City(name: 'Lomé', code: 'LFW'),
    ],
  ),
  Country(
    name: 'Tonga',
    code: 'TO',
    cities: [
      City(name: "Nuku'alofa", code: 'TBU'),
    ],
  ),

  Country(
    name: 'Trinidad and Tobago',
    code: 'TT',
    cities: [
      City(name: 'Port of Spain', code: 'POS'),
    ],
  ),
  Country(
    name: 'Tunisia',
    code: 'TN',
    cities: [
      City(name: 'Tunis', code: 'TUN'),
      City(name: 'Sfax', code: 'SF'),
      City(name: 'Sousse', code: 'SO'),
      City(name: 'Ariana', code: 'AR'),
      City(name: 'Kairouan', code: 'KA'),
      City(name: 'Gabès', code: 'GB'),
      City(name: 'Bizerte', code: 'BZ'),
      City(name: 'Gafsa', code: 'GF'),
    ],
  ),
  Country(
    name: 'Türkiye',
    code: 'TR',
    cities: [
      City(name: 'Istanbul', code: 'IST'),
      City(name: 'Ankara', code: 'ESB'),
      City(name: 'Adana', code: '01'),
      City(name: 'Adıyaman', code: '02'),
      City(name: 'Afyonkarahisar', code: '03'),
      City(name: 'Ağrı', code: '04'),
      City(name: 'Aksaray', code: '68'),
      City(name: 'Aydın', code: '09'),
      City(name: 'Balıkesir', code: '10'),
      City(name: 'Bursa', code: '16'),
      City(name: 'Çanakkale', code: '17'),
      City(name: 'Denizli', code: '20'),
      City(name: 'Diyarbakır', code: '21'),
      City(name: 'Edirne', code: '22'),
      City(name: 'Elazığ', code: '23'),
      City(name: 'Erzurum', code: '25'),
      City(name: 'Eskişehir', code: '26'),
      City(name: 'Gaziantep', code: '27'),
      City(name: 'Kahramanmaraş', code: '46'),
      City(name: 'Kayseri', code: '38'),
      City(name: 'Konya', code: '42'),
      City(name: 'Malatya', code: '44'),
      City(name: 'Mersin', code: '33'),
      City(name: 'Samsun', code: '55'),
      City(name: 'Trabzon', code: '61'),
      City(name: 'Van', code: '65'),
    ],
  ),
  Country(
    name: 'Turkmenistan',
    code: 'TM',
    cities: [
      City(name: 'Ashgabat', code: 'ASB'),
    ],
  ),
  Country(
    name: 'Tuvalu',
    code: 'TV',
    cities: [
      City(name: 'Funafuti', code: 'FUN'),
    ],
  ),
  Country(
    name: 'Uganda',
    code: 'UG',
    cities: [
      City(name: 'Kampala', code: 'KLA'),
    ],
  ),
  Country(
    name: 'Ukraine',
    code: 'UA',
    cities: [
      City(name: 'Kyiv', code: 'KBP'),
      City(name: 'Lviv', code: 'LWO'),
    ],
  ),
  Country(
    name: 'United Arab Emirates',
    code: 'AE',
    cities: [
      City(name: 'Abu Dhabi', code: 'AUH'),
      City(name: 'Dubai', code: 'DXB'),
    ],
  ),
  Country(
    name: 'United Kingdom',
    code: 'GB',
    cities: [
      City(name: 'England', code: 'ENG'),
      City(name: 'Scotland', code: 'SCT'),
      City(name: 'Wales', code: 'WLS'),
      City(name: 'Northern Ireland', code: 'NIR'),
      City(name: 'Birmingham', code: 'BHX'),
      City(name: 'Edinburgh', code: 'EDI'),
      City(name: 'Cardiff', code: 'CWL'),
    ],
  ),
  Country(
    name: 'United States',
    code: 'US',
    cities: [
      City(name: 'New York', code: 'JFK'),
      City(name: 'Los Angeles', code: 'LAX'),
      City(name: 'Chicago', code: 'ORD'),
      City(name: 'Alabama', code: 'AL'),
      City(name: 'Alaska', code: 'AK'),
      City(name: 'Arizona', code: 'AZ'),
      City(name: 'Arkansas', code: 'AR'),
      City(name: 'California', code: 'CA'),
      City(name: 'Colorado', code: 'CO'),
      City(name: 'Connecticut', code: 'CT'),
      City(name: 'Delaware', code: 'DE'),
      City(name: 'Florida', code: 'FL'),
      City(name: 'Georgia', code: 'GA'),
      City(name: 'Hawaii', code: 'HI'),
      City(name: 'Idaho', code: 'ID'),
      City(name: 'Illinois', code: 'IL'),
      City(name: 'Indiana', code: 'IN'),
      City(name: 'Iowa', code: 'IA'),
      City(name: 'Kansas', code: 'KS'),
      City(name: 'Kentucky', code: 'KY'),
      City(name: 'Louisiana', code: 'LA'),
      City(name: 'Maine', code: 'ME'),
      City(name: 'Maryland', code: 'MD'),
      City(name: 'Massachusetts', code: 'MA'),
      City(name: 'Michigan', code: 'MI'),
      City(name: 'Minnesota', code: 'MN'),
      City(name: 'Mississippi', code: 'MS'),
      City(name: 'Missouri', code: 'MO'),
      City(name: 'Montana', code: 'MT'),
      City(name: 'Nebraska', code: 'NE'),
      City(name: 'Nevada', code: 'NV'),
      City(name: 'New Hampshire', code: 'NH'),
      City(name: 'New Jersey', code: 'NJ'),
      City(name: 'New Mexico', code: 'NM'),
      City(name: 'New York', code: 'NY'),
      City(name: 'North Carolina', code: 'NC'),
      City(name: 'North Dakota', code: 'ND'),
      City(name: 'Ohio', code: 'OH'),
      City(name: 'Oklahoma', code: 'OK'),
      City(name: 'Oregon', code: 'OR'),
      City(name: 'Pennsylvania', code: 'PA'),
      City(name: 'Rhode Island', code: 'RI'),
      City(name: 'South Carolina', code: 'SC'),
      City(name: 'South Dakota', code: 'SD'),
      City(name: 'Tennessee', code: 'TN'),
      City(name: 'Texas', code: 'TX'),
      City(name: 'Utah', code: 'UT'),
      City(name: 'Vermont', code: 'VT'),
      City(name: 'Virginia', code: 'VA'),
      City(name: 'Washington', code: 'WA'),
      City(name: 'West Virginia', code: 'WV'),
      City(name: 'Wisconsin', code: 'WI'),
      City(name: 'Wyoming', code: 'WY'),
    ],
  ),
  Country(
    name: 'Uruguay',
    code: 'UY',
    cities: [
      City(name: 'Montevideo', code: 'MVD'),
    ],
  ),
  Country(
    name: 'Uzbekistan',
    code: 'UZ',
    cities: [
      City(name: 'Tashkent', code: 'TAS'),
    ],
  ),
  Country(
    name: 'Vanuatu',
    code: 'VU',
    cities: [
      City(name: 'Port Vila', code: 'VLI'),
      City(name: 'Tripoli', code: 'TB'),
      City(name: 'Benghazi', code: 'BA'),
      City(name: 'Misrata', code: 'MI'),
      City(name: 'Zawiya', code: 'ZA'),
      City(name: 'Sabha', code: 'SB'),
      City(name: 'Derna', code: 'DR'),
      City(name: 'Gharyan', code: 'GH'),
    ],
  ),
  Country(
    name: 'Vatican City',
    code: 'VA',
    cities: [
      City(name: 'Vatican City', code: 'VAT'),
    ],
  ),
  Country(
    name: 'Venezuela',
    code: 'VE',
    cities: [
      City(name: 'Caracas', code: 'CCS'),
    ],
  ),
  Country(
    name: 'Vietnam',
    code: 'VN',
    cities: [
      City(name: 'Hanoi', code: 'HAN'),
      City(name: 'Ho Chi Minh City', code: 'SGN'),
    ],
  ),
  Country(
    name: 'Yemen',
    code: 'YE',
    cities: [
      City(name: "Sana'a", code: 'SAH'),
      City(name: 'Aden', code: 'ADE'),
      City(name: 'Taiz', code: 'TA'),
      City(name: 'Hadhramaut', code: 'HA'),
      City(name: 'Al Hudaydah', code: 'HU'),
      City(name: 'Ibb', code: 'IB'),
      City(name: 'Lahij', code: 'LA'),
    ],
  ),
  Country(
    name: 'Zambia',
    code: 'ZM',
    cities: [
      City(name: 'Lusaka', code: 'LUN'),
    ],
  ),
  Country(
    name: 'Zimbabwe',
    code: 'ZW',
    cities: [
      City(name: 'Harare', code: 'HRE'),
      City(name: 'Bulawayo', code: 'BUQ'),
    ],
  ),

];