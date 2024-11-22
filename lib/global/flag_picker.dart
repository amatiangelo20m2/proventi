import 'package:country_picker/country_picker.dart';

final Map<String, String> phonePrefixToFlag = {
  "1": "🇺🇸", // USA and Canada
  "7": "🇷🇺", // Russia
  "20": "🇪🇬", // Egypt
  "27": "🇿🇦", // South Africa
  "30": "🇬🇷", // Greece
  "31": "🇳🇱", // Netherlands
  "32": "🇧🇪", // Belgium
  "33": "🇫🇷", // France
  "34": "🇪🇸", // Spain
  "36": "🇭🇺", // Hungary
  "39": "🇮🇹", // Italy
  "40": "🇷🇴", // Romania
  "41": "🇨🇭", // Switzerland
  "43": "🇦🇹", // Austria
  "44": "🇬🇧", // United Kingdom
  "45": "🇩🇰", // Denmark
  "46": "🇸🇪", // Sweden
  "47": "🇳🇴", // Norway
  "48": "🇵🇱", // Poland
  "49": "🇩🇪", // Germany
  "51": "🇵🇪", // Peru
  "52": "🇲🇽", // Mexico
  "53": "🇨🇺", // Cuba
  "54": "🇦🇷", // Argentina
  "55": "🇧🇷", // Brazil
  "56": "🇨🇱", // Chile
  "57": "🇨🇴", // Colombia
  "58": "🇻🇪", // Venezuela
  "60": "🇲🇾", // Malaysia
  "61": "🇦🇺", // Australia
  "62": "🇮🇩", // Indonesia
  "63": "🇵🇭", // Philippines
  "64": "🇳🇿", // New Zealand
  "65": "🇸🇬", // Singapore
  "66": "🇹🇭", // Thailand
  "81": "🇯🇵", // Japan
  "82": "🇰🇷", // South Korea
  "84": "🇻🇳", // Vietnam
  "86": "🇨🇳", // China
  "90": "🇹🇷", // Turkey
  "91": "🇮🇳", // India
  "92": "🇵🇰", // Pakistan
  "93": "🇦🇫", // Afghanistan
  "94": "🇱🇰", // Sri Lanka
  "95": "🇲🇲", // Myanmar
  "98": "🇮🇷", // Iran
  "211": "🇸🇸", // South Sudan
  "212": "🇲🇦", // Morocco
  "213": "🇩🇿", // Algeria
  "216": "🇹🇳", // Tunisia
  "218": "🇱🇾", // Libya
  "220": "🇬🇲", // Gambia
  "221": "🇸🇳", // Senegal
  "222": "🇲🇷", // Mauritania
  "223": "🇲🇱", // Mali
  "224": "🇬🇳", // Guinea
  "225": "🇨🇮", // Ivory Coast
  "226": "🇧🇫", // Burkina Faso
  "227": "🇳🇪", // Niger
  "228": "🇹🇬", // Togo
  "229": "🇧🇯", // Benin
  "230": "🇲🇺", // Mauritius
  "231": "🇱🇷", // Liberia
  "232": "🇸🇱", // Sierra Leone
  "233": "🇬🇭", // Ghana
  "234": "🇳🇬", // Nigeria
  "235": "🇹🇩", // Chad
  "236": "🇨🇫", // Central African Republic
  "237": "🇨🇲", // Cameroon
  "238": "🇨🇻", // Cape Verde
  "239": "🇸🇹", // Sao Tome and Principe
  "240": "🇬🇶", // Equatorial Guinea
  "241": "🇬🇦", // Gabon
  "242": "🇨🇬", // Republic of the Congo
  "243": "🇨🇩", // Democratic Republic of the Congo
  "244": "🇦🇴", // Angola
  "245": "🇬🇼", // Guinea-Bissau
  "246": "🇮🇴", // British Indian Ocean Territory
  "248": "🇸🇨", // Seychelles
  "249": "🇸🇩", // Sudan
  "250": "🇷🇼", // Rwanda
  "251": "🇪🇹", // Ethiopia
  "252": "🇸🇴", // Somalia
  "253": "🇩🇯", // Djibouti
  "254": "🇰🇪", // Kenya
  "255": "🇹🇿", // Tanzania
  "256": "🇺🇬", // Uganda
  "257": "🇧🇮", // Burundi
  "258": "🇲🇿", // Mozambique
  "260": "🇿🇲", // Zambia
  "261": "🇲🇬", // Madagascar
  "262": "🇷🇪", // Reunion
  "263": "🇿🇼", // Zimbabwe
  "264": "🇳🇦", // Namibia
  "265": "🇲🇼", // Malawi
  "266": "🇱🇸", // Lesotho
  "267": "🇧🇼", // Botswana
  "268": "🇸🇿", // Eswatini
  "269": "🇰🇲", // Comoros
  "290": "🇸🇭", // Saint Helena
  "291": "🇪🇷", // Eritrea
  "297": "🇦🇼", // Aruba
  "298": "🇫🇴", // Faroe Islands
  "299": "🇬🇱", // Greenland
  "350": "🇬🇮", // Gibraltar
  "351": "🇵🇹", // Portugal
  "352": "🇱🇺", // Luxembourg
  "353": "🇮🇪", // Ireland
  "354": "🇮🇸", // Iceland
  "355": "🇦🇱", // Albania
  "356": "🇲🇹", // Malta
  "357": "🇨🇾", // Cyprus
  "358": "🇫🇮", // Finland
  "359": "🇧🇬", // Bulgaria
  "370": "🇱🇹", // Lithuania
  "371": "🇱🇻", // Latvia
  "372": "🇪🇪", // Estonia
  "373": "🇲🇩", // Moldova
  "374": "🇦🇲", // Armenia
  "375": "🇧🇾", // Belarus
  "376": "🇦🇩", // Andorra
  "377": "🇲🇨", // Monaco
  "378": "🇸🇲", // San Marino
  "379": "🇻🇦", // Vatican City
  "380": "🇺🇦", // Ukraine
  "381": "🇷🇸", // Serbia
  "382": "🇲🇪", // Montenegro
  "383": "🇽🇰", // Kosovo
  "385": "🇭🇷", // Croatia
  "386": "🇸🇮", // Slovenia
  "387": "🇧🇦", // Bosnia and Herzegovina
  "389": "🇲🇰", // North Macedonia
  "420": "🇨🇿", // Czech Republic
  "421": "🇸🇰", // Slovakia
  "423": "🇱🇮", // Liechtenstein
};


String? getFlagByPrefix(String prefix) {
  return phonePrefixToFlag[prefix];
}