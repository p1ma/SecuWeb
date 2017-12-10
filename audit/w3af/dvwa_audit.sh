#! /bin/bash

if [ -z "$1" ]
  then
    echo "usage : dvwa_audit <PHPSESSID>"
    exit 1
fi

WA3F_SCRIPT=/tmp/w3af_script
HEADERS_FILE=/tmp/w3af_headers

echo "Cookie: security=low;PHPSESSID=${1}" > ${HEADERS_FILE}

echo > ${WA3F_SCRIPT}
echo target >> ${WA3F_SCRIPT}
echo set target http://localhost/dvwa >> ${WA3F_SCRIPT}
echo set targetOS unix >> ${WA3F_SCRIPT}
echo set targetFramework php >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
echo plugins >> ${WA3F_SCRIPT}

echo discovery webSpider >> ${WA3F_SCRIPT}
echo discovery config webSpider >> ${WA3F_SCRIPT}
echo set ignoreRegex .*logout.* >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
#echo discovery dir_bruter >> ${WA3F_SCRIPT}
#echo discovery urlFuzzer >> ${WA3F_SCRIPT}

echo audit blindSqli >> ${WA3F_SCRIPT}
echo audit eval >> ${WA3F_SCRIPT}
echo audit fileUpload >> ${WA3F_SCRIPT}
echo audit formatString >> ${WA3F_SCRIPT}
echo audit generic >> ${WA3F_SCRIPT}
echo audit localFileInclude >> ${WA3F_SCRIPT}
echo audit osCommanding >> ${WA3F_SCRIPT}
#echo audit remoteFileInclude >> ${WA3F_SCRIPT}
echo audit responseSplitting >> ${WA3F_SCRIPT}
echo audit sqli >> ${WA3F_SCRIPT}
echo audit xss >> ${WA3F_SCRIPT}

echo output htmlFile >> ${WA3F_SCRIPT}
echo output config htmlFile >> ${WA3F_SCRIPT}
echo set fileName $(pwd)/report.html >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
echo output csv_file >> ${WA3F_SCRIPT}
echo output config csv_file >> ${WA3F_SCRIPT}
echo set output_file $(pwd)/report.csv >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
echo output xmlFile >> ${WA3F_SCRIPT}
echo output config xmlFile >> ${WA3F_SCRIPT}
echo set fileName $(pwd)/report.xml >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}

echo back >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
echo http-settings >> ${WA3F_SCRIPT}
echo set headersFile ${HEADERS_FILE} >> ${WA3F_SCRIPT}
echo back >> ${WA3F_SCRIPT}
echo start >> ${WA3F_SCRIPT}
echo exit  >> ${WA3F_SCRIPT}

w3af_console -s ${WA3F_SCRIPT}
