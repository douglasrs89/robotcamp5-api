***Settings***
Documentation       Aqui teremos todas as  palavras chaves de ajuda

Library    OperatingSystem

***Keywords***
Get Data From Json File
  [Arguments]    ${json_file}
    ${string_file}=      Get File    ${EXECDIR}/resources/fixtures/${json_file}
    ${data_json}=     Evaluate    json.loads($string_file)    json
    [Return]  ${data_json}