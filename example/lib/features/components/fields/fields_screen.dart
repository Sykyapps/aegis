import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../../core/navigation/navigation_service.dart';

class FieldsScreen extends HookWidget {
  const FieldsScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    var basicCtrl = useTextEditingController();
    var phoneCtrl = useTextEditingController();
    var tapCtrl = useTextEditingController();

    return SkScaffold(
      appBar: SkAppBar(
        title: 'Fields',
        onLeadingPressed: () => ns.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SkTextField(
                  controller: basicCtrl,
                  labelText: 'Text Field',
                ),
                SizedBox(height: 20.r),
                SkPhoneField(
                  controller: phoneCtrl,
                  phoneCodes: phoneCodes,
                ),
                SizedBox(height: 20.r),
                SkPhoneEmailField(
                  controller: basicCtrl,
                  phoneCodes: phoneCodes,
                ),
                SizedBox(height: 20.r),
                SkTapField(
                  controller: tapCtrl,
                  labelText: 'Target Tercapai',
                  hintText: 'Tentukan target tercapai',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SkButton(
                          label: 'Set Text',
                          onPressed: () => tapCtrl.text =
                              tapCtrl.text.isEmpty ? 'Sample Tap Field' : '',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.r),
                SkSearchField(controller: basicCtrl),
                SizedBox(height: 20.r),
                SkNominalField(
                  controller: basicCtrl,
                  hintText: 'Rp100.000',
                  labelText: 'Jumlah Investasi (Minimal Rp100.000)',
                  onChanged: (value) {},
                ),
                SizedBox(height: 20.r),
                SkNumberField(
                  labelText: 'Number field',
                  onChanged: (value) {},
                ),
                const SkCalculatorField(
                  label: 'Masukan Usia Anda',
                  suffixTitle: 'Tahun',
                  tooltipTitle: 'Nabung Reksadana',
                  tooltipContent: 'Mudah cepat dan tidak menyusahkan loh',
                  isDecimal: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> phoneCodes = [
  {
    "name": "Afghanistan",
    "phoneCode": "93",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/afghanistan.svg"
  },
  {
    "name": "Algeria",
    "phoneCode": "213",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/algeria.svg"
  },
  {
    "name": "American Samoa",
    "phoneCode": "1684",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/american-samoa.svg"
  },
  {
    "name": "Andorra",
    "phoneCode": "376",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/andorra.svg"
  },
  {
    "name": "Angola",
    "phoneCode": "244",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/angola.svg"
  },
  {
    "name": "Anguilla",
    "phoneCode": "1264",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/anguilla.svg"
  },
  {
    "name": "Antigua and Barbuda",
    "phoneCode": "1268",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/antigua-and-barbuda.svg"
  },
  {
    "name": "Argentina",
    "phoneCode": "54",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/argentina.svg"
  },
  {
    "name": "Aruba",
    "phoneCode": "297",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/aruba.svg"
  },
  {
    "name": "Australia",
    "phoneCode": "61",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/australia.svg"
  },
  {
    "name": "Austria",
    "phoneCode": "43",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/austria.svg"
  },
  {
    "name": "Azerbaijan",
    "phoneCode": "994",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/azerbaijan.svg"
  },
  {
    "name": "Bahamas",
    "phoneCode": "1242",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bahamas.svg"
  },
  {
    "name": "Bahrain",
    "phoneCode": "973",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bahrain.svg"
  },
  {
    "name": "Bangladesh",
    "phoneCode": "880",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bangladesh.svg"
  },
  {
    "name": "Barbados",
    "phoneCode": "1246",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/barbados.svg"
  },
  {
    "name": "Belgium",
    "phoneCode": "32",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/belgium.svg"
  },
  {
    "name": "Belize",
    "phoneCode": "501",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/belize.svg"
  },
  {
    "name": "Benin",
    "phoneCode": "229",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/benin.svg"
  },
  {
    "name": "Bermuda",
    "phoneCode": "1441",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bermuda.svg"
  },
  {
    "name": "Bhutan",
    "phoneCode": "975",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bhutan.svg"
  },
  {
    "name": "Bolivia",
    "phoneCode": "591",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bolivia.svg"
  },
  {
    "name": "Bosnia and Herzegovina",
    "phoneCode": "387",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bosnia-and-herzegovina.svg"
  },
  {
    "name": "Botswana",
    "phoneCode": "267",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/botswana.svg"
  },
  {
    "name": "Brazil",
    "phoneCode": "55",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/brazil.svg"
  },
  {
    "name": "British Virgin Islands",
    "phoneCode": "1284",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/british-virgin-islands.svg"
  },
  {
    "name": "Brunei",
    "phoneCode": "673",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/brunei.svg"
  },
  {
    "name": "Bulgaria",
    "phoneCode": "359",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/bulgaria.svg"
  },
  {
    "name": "Burkina Faso",
    "phoneCode": "226",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/burkina-faso.svg"
  },
  {
    "name": "Burundi",
    "phoneCode": "257",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/burundi.svg"
  },
  {
    "name": "Cambodia",
    "phoneCode": "855",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cambodia.svg"
  },
  {
    "name": "Cameroon",
    "phoneCode": "237",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cameroon.svg"
  },
  {
    "name": "Canada",
    "phoneCode": "1",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/canada.svg"
  },
  {
    "name": "Cape Verde",
    "phoneCode": "238",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cape-verde.svg"
  },
  {
    "name": "Cayman Islands",
    "phoneCode": "1345",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cayman-islands.svg"
  },
  {
    "name": "Central African Republic",
    "phoneCode": "236",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/central-african-republic.svg"
  },
  {
    "name": "Chad",
    "phoneCode": "235",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/chad.svg"
  },
  {
    "name": "Chile",
    "phoneCode": "56",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/chile.svg"
  },
  {
    "name": "China",
    "phoneCode": "86",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/china.svg"
  },
  {
    "name": "Colombia",
    "phoneCode": "57",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/colombia.svg"
  },
  {
    "name": "Comoros",
    "phoneCode": "269",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/comoros.svg"
  },
  {
    "name": "Cook Islands",
    "phoneCode": "682",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cook-islands.svg"
  },
  {
    "name": "Costa Rica",
    "phoneCode": "506",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/costa-rica.svg"
  },
  {
    "name": "Croatia",
    "phoneCode": "385",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/croatia.svg"
  },
  {
    "name": "Cyprus",
    "phoneCode": "357",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/cyprus.svg"
  },
  {
    "name": "Czech Republic",
    "phoneCode": "420",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/czech-republic.svg"
  },
  {
    "name": "Democratic Republic of the Congo",
    "phoneCode": "243",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/democratic-republic-of-the-congo.svg"
  },
  {
    "name": "Denmark",
    "phoneCode": "45",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/denmark.svg"
  },
  {
    "name": "Diego Garcia",
    "phoneCode": "246",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/diego-garcia.svg"
  },
  {
    "name": "Djibouti",
    "phoneCode": "253",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/djibouti.svg"
  },
  {
    "name": "Dominica",
    "phoneCode": "1767",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/dominica.svg"
  },
  {
    "name": "Dominican Republic",
    "phoneCode": "1809",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/dominican-republic.svg"
  },
  {
    "name": "Ecuador",
    "phoneCode": "593",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ecuador.svg"
  },
  {
    "name": "El Salvador",
    "phoneCode": "503",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/el-salvador.svg"
  },
  {
    "name": "Equatorial Guinea",
    "phoneCode": "240",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/equatorial-guinea.svg"
  },
  {
    "name": "Eritrea",
    "phoneCode": "291",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/eritrea.svg"
  },
  {
    "name": "Estonia",
    "phoneCode": "372",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/estonia.svg"
  },
  {
    "name": "Ethiopia",
    "phoneCode": "251",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ethiopia.svg"
  },
  {
    "name": "Falkland Islands",
    "phoneCode": "500",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/falkland-islands.svg"
  },
  {
    "name": "Faroe Islands",
    "phoneCode": "298",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/faroe-islands.svg"
  },
  {
    "name": "Fiji",
    "phoneCode": "679",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/fiji.svg"
  },
  {
    "name": "Finland",
    "phoneCode": "358",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/finland.svg"
  },
  {
    "name": "France",
    "phoneCode": "33",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/france.svg"
  },
  {
    "name": "French Guiana",
    "phoneCode": "594",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/french-guiana.svg"
  },
  {
    "name": "French Polynesia",
    "phoneCode": "689",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/french-polynesia.svg"
  },
  {
    "name": "Gabon",
    "phoneCode": "241",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/gabon.svg"
  },
  {
    "name": "Gambia",
    "phoneCode": "220",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/gambia.svg"
  },
  {
    "name": "Georgia",
    "phoneCode": "995",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/georgia.svg"
  },
  {
    "name": "Germany",
    "phoneCode": "49",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/germany.svg"
  },
  {
    "name": "Ghana",
    "phoneCode": "233",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ghana.svg"
  },
  {
    "name": "Gibraltar",
    "phoneCode": "350",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/gibraltar.svg"
  },
  {
    "name": "Greece",
    "phoneCode": "30",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/greece.svg"
  },
  {
    "name": "Greenland",
    "phoneCode": "299",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/greenland.svg"
  },
  {
    "name": "Grenada",
    "phoneCode": "1473",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/grenada.svg"
  },
  {
    "name": "Guadeloupe",
    "phoneCode": "596",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guadeloupe.svg"
  },
  {
    "name": "Guam",
    "phoneCode": "1671",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guam.svg"
  },
  {
    "name": "Guatemala",
    "phoneCode": "502",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guatemala.svg"
  },
  {
    "name": "Guinea",
    "phoneCode": "224",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guinea.svg"
  },
  {
    "name": "Guinea-Bissau",
    "phoneCode": "245",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guinea-bissau.svg"
  },
  {
    "name": "Guyana",
    "phoneCode": "592",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/guyana.svg"
  },
  {
    "name": "Haiti",
    "phoneCode": "509",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/haiti.svg"
  },
  {
    "name": "Honduras",
    "phoneCode": "504",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/honduras.svg"
  },
  {
    "name": "Hong Kong",
    "phoneCode": "852",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/hong-kong.svg"
  },
  {
    "name": "Hungary",
    "phoneCode": "36",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/hungary.svg"
  },
  {
    "name": "Iceland",
    "phoneCode": "354",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/iceland.svg"
  },
  {
    "name": "India",
    "phoneCode": "91",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/india.svg"
  },
  {
    "name": "Indonesia",
    "phoneCode": "62",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/indonesia.svg"
  },
  {
    "name": "Ireland",
    "phoneCode": "353",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ireland.svg"
  },
  {
    "name": "Israel",
    "phoneCode": "972",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/israel.svg"
  },
  {
    "name": "Italy",
    "phoneCode": "39",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/italy.svg"
  },
  {
    "name": "Ivory Coast",
    "phoneCode": "225",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ivory-coast.svg"
  },
  {
    "name": "Jamaica",
    "phoneCode": "1876",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/jamaica.svg"
  },
  {
    "name": "Japan",
    "phoneCode": "81",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/japan.svg"
  },
  {
    "name": "Kiribati",
    "phoneCode": "686",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/kiribati.svg"
  },
  {
    "name": "Kosovo",
    "phoneCode": "383",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/kosovo.svg"
  },
  {
    "name": "Kyrgyzstan",
    "phoneCode": "996",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/kyrgyzstan.svg"
  },
  {
    "name": "Laos",
    "phoneCode": "856",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/laos.svg"
  },
  {
    "name": "Latvia",
    "phoneCode": "371",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/latvia.svg"
  },
  {
    "name": "Lebanon",
    "phoneCode": "961",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/lebanon.svg"
  },
  {
    "name": "Lesotho",
    "phoneCode": "266",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/lesotho.svg"
  },
  {
    "name": "Liberia",
    "phoneCode": "231",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/liberia.svg"
  },
  {
    "name": "Libya",
    "phoneCode": "218",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/libya.svg"
  },
  {
    "name": "Liechtenstein",
    "phoneCode": "423",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/liechtenstein.svg"
  },
  {
    "name": "Lithuania",
    "phoneCode": "370",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/lithuania.svg"
  },
  {
    "name": "Luxembourg",
    "phoneCode": "352",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/luxembourg.svg"
  },
  {
    "name": "Macao",
    "phoneCode": "853",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/macao.svg"
  },
  {
    "name": "Madagascar",
    "phoneCode": "261",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/madagascar.svg"
  },
  {
    "name": "Malawi",
    "phoneCode": "265",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/malawi.svg"
  },
  {
    "name": "Malaysia",
    "phoneCode": "60",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/malaysia.svg"
  },
  {
    "name": "Maldives",
    "phoneCode": "960",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/maldives.svg"
  },
  {
    "name": "Mali",
    "phoneCode": "223",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/mali.svg"
  },
  {
    "name": "Malta",
    "phoneCode": "356",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/malta.svg"
  },
  {
    "name": "Marshall Islands",
    "phoneCode": "692",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/marshall-islands.svg"
  },
  {
    "name": "Mauritania",
    "phoneCode": "222",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/mauritania.svg"
  },
  {
    "name": "Mauritius",
    "phoneCode": "230",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/mauritius.svg"
  },
  {
    "name": "Mexico",
    "phoneCode": "52",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/mexico.svg"
  },
  {
    "name": "Micronesia",
    "phoneCode": "691",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/micronesia.svg"
  },
  {
    "name": "Moldova",
    "phoneCode": "373",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/moldova.svg"
  },
  {
    "name": "Monaco",
    "phoneCode": "377",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/monaco.svg"
  },
  {
    "name": "Mongolia",
    "phoneCode": "976",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/mongolia.svg"
  },
  {
    "name": "Montenegro",
    "phoneCode": "382",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/montenegro.svg"
  },
  {
    "name": "Montserrat",
    "phoneCode": "1664",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/montserrat.svg"
  },
  {
    "name": "Myanmar",
    "phoneCode": "95",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/myanmar.svg"
  },
  {
    "name": "Namibia",
    "phoneCode": "264",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/namibia.svg"
  },
  {
    "name": "Nauru",
    "phoneCode": "674",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/nauru.svg"
  },
  {
    "name": "Nepal",
    "phoneCode": "977",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/nepal.svg"
  },
  {
    "name": "Netherlands",
    "phoneCode": "31",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/netherlands.svg"
  },
  {
    "name": "New Caledonia",
    "phoneCode": "687",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/new-caledonia.svg"
  },
  {
    "name": "New Zealand",
    "phoneCode": "64",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/new-zealand.svg"
  },
  {
    "name": "Nicaragua",
    "phoneCode": "505",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/nicaragua.svg"
  },
  {
    "name": "Nigeria",
    "phoneCode": "234",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/nigeria.svg"
  },
  {
    "name": "Niue",
    "phoneCode": "683",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/niue.svg"
  },
  {
    "name": "North Macedonia",
    "phoneCode": "389",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/north-macedonia.svg"
  },
  {
    "name": "Norway",
    "phoneCode": "47",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/norway.svg"
  },
  {
    "name": "Pakistan",
    "phoneCode": "92",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/pakistan.svg"
  },
  {
    "name": "Palau",
    "phoneCode": "680",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/palau.svg"
  },
  {
    "name": "Panama",
    "phoneCode": "507",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/panama.svg"
  },
  {
    "name": "Papua New Guinea",
    "phoneCode": "675",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/papua-new-guinea.svg"
  },
  {
    "name": "Paraguay",
    "phoneCode": "595",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/paraguay.svg"
  },
  {
    "name": "Peru",
    "phoneCode": "51",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/peru.svg"
  },
  {
    "name": "Poland",
    "phoneCode": "48",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/poland.svg"
  },
  {
    "name": "Portugal",
    "phoneCode": "351",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/portugal.svg"
  },
  {
    "name": "Puerto Rico",
    "phoneCode": "1787",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/puerto-rico.svg"
  },
  {
    "name": "Republic of the Congo",
    "phoneCode": "242",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/republic-of-the-congo.svg"
  },
  {
    "name": "Reunion",
    "phoneCode": "262",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/reunion.svg"
  },
  {
    "name": "Romania",
    "phoneCode": "40",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/romania.svg"
  },
  {
    "name": "Russia",
    "phoneCode": "7",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/russia.svg"
  },
  {
    "name": "Rwanda",
    "phoneCode": "250",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/rwanda.svg"
  },
  {
    "name": "Saint Helena Ascension and Tristan",
    "phoneCode": "290",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/saint-helena-ascension-and-tristan.svg"
  },
  {
    "name": "Saint Kitts and Nevis",
    "phoneCode": "1869",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/saint-kitts-and-nevis.svg"
  },
  {
    "name": "Saint Lucia",
    "phoneCode": "1758",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/saint-lucia.svg"
  },
  {
    "name": "Saint Pierre and Miquelon",
    "phoneCode": "508",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/saint-pierre-and-miquelon.svg"
  },
  {
    "name": "Saint Vincent and the Grenadines",
    "phoneCode": "1748",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/saint-vincent-and-the-grenadines.svg"
  },
  {
    "name": "Samoa",
    "phoneCode": "685",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/samoa.svg"
  },
  {
    "name": "San Marino",
    "phoneCode": "378",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/san-marino.svg"
  },
  {
    "name": "Sao Tome and Principe",
    "phoneCode": "239",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/sao-tome-and-principe.svg"
  },
  {
    "name": "Senegal",
    "phoneCode": "221",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/senegal.svg"
  },
  {
    "name": "Seychelles",
    "phoneCode": "248",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/seychelles.svg"
  },
  {
    "name": "Sierra Leone",
    "phoneCode": "232",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/sierra-leone.svg"
  },
  {
    "name": "Singapore",
    "phoneCode": "65",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/singapore.svg"
  },
  {
    "name": "Slovakia",
    "phoneCode": "421",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/slovakia.svg"
  },
  {
    "name": "Slovenia",
    "phoneCode": "386",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/slovenia.svg"
  },
  {
    "name": "Solomon Islands",
    "phoneCode": "677",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/solomon-islands.svg"
  },
  {
    "name": "Somalia",
    "phoneCode": "252",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/somalia.svg"
  },
  {
    "name": "South Africa",
    "phoneCode": "27",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/south-africa.svg"
  },
  {
    "name": "South Korea",
    "phoneCode": "82",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/south-korea.svg"
  },
  {
    "name": "South Sudan",
    "phoneCode": "211",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/south-sudan.svg"
  },
  {
    "name": "Spain",
    "phoneCode": "34",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/spain.svg"
  },
  {
    "name": "Sudan",
    "phoneCode": "249",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/sudan.svg"
  },
  {
    "name": "Suriname",
    "phoneCode": "597",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/suriname.svg"
  },
  {
    "name": "Sweden",
    "phoneCode": "46",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/sweden.svg"
  },
  {
    "name": "Switzerland",
    "phoneCode": "41",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/switzerland.svg"
  },
  {
    "name": "Syria",
    "phoneCode": "963",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/syria.svg"
  },
  {
    "name": "Taiwan",
    "phoneCode": "886",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/taiwan.svg"
  },
  {
    "name": "Tajikistan",
    "phoneCode": "992",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/tajikistan.svg"
  },
  {
    "name": "Tanzania",
    "phoneCode": "255",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/tanzania.svg"
  },
  {
    "name": "Timor-Leste",
    "phoneCode": "670",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/timor-leste.svg"
  },
  {
    "name": "Togo",
    "phoneCode": "228",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/togo.svg"
  },
  {
    "name": "Tonga",
    "phoneCode": "676",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/tonga.svg"
  },
  {
    "name": "Trinidad and Tobago",
    "phoneCode": "1868",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/trinidad-and-tobago.svg"
  },
  {
    "name": "Tunisia",
    "phoneCode": "216",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/tunisia.svg"
  },
  {
    "name": "Turkmenistan",
    "phoneCode": "993",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/turkmenistan.svg"
  },
  {
    "name": "Turks and Caicos Islands",
    "phoneCode": "1649",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/turks-and-caicos-islands.svg"
  },
  {
    "name": "Tuvalu",
    "phoneCode": "688",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/tuvalu.svg"
  },
  {
    "name": "Uganda",
    "phoneCode": "256",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/uganda.svg"
  },
  {
    "name": "Ukraine",
    "phoneCode": "380",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/ukraine.svg"
  },
  {
    "name": "United Kingdom",
    "phoneCode": "44",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/united-kingdom.svg"
  },
  {
    "name": "Uruguay",
    "phoneCode": "598",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/uruguay.svg"
  },
  {
    "name": "Uzbekistan",
    "phoneCode": "998",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/uzbekistan.svg"
  },
  {
    "name": "Vanuatu",
    "phoneCode": "678",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/vanuatu.svg"
  },
  {
    "name": "Venezuela",
    "phoneCode": "58",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/venezuela.svg"
  },
  {
    "name": "Wallis and Futuna",
    "phoneCode": "681",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/wallis-and-futuna.svg"
  },
  {
    "name": "Yemen",
    "phoneCode": "967",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/yemen.svg"
  },
  {
    "name": "Zambia",
    "phoneCode": "260",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/zambia.svg"
  },
  {
    "name": "Zimbabwe",
    "phoneCode": "263",
    "flagUrl":
        "https://storage.googleapis.com/sayakaya-static/country_flags/zimbabwe.svg"
  }
];
