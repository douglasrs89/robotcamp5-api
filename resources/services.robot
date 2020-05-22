***Settings***
Documentation       Aqui nós vamos encapsular algumas chamadas de serviços

Library     RequestsLibrary
Library    libs/database.py

***Variables***
${base_url}         http://localhost:3333
${user_email}       douglas@ninjapixel.com
${user_password}    q1w2E3R4@!

***Keywords***
Set Suite Var Auth Token
  [Arguments]    ${email}    ${password}
  Create Session    pixel    ${base_url}

  &{header}=        Create Dictionary   Content-Type=application/json
  &{payload}=       Create Dictionary   email=${email}    password=${password}

  ${resp}=          Post Request    pixel    /auth    data=${payload}    headers=${header}
  ${token}=         Convert To String     JWT ${resp.json()['token']}

  Set Suite Variable    ${token}

Post Product
  [Arguments]    ${payload}    ${remove}=dont_remove
  Run Keyword If    "${remove}" == "before_remove"
  ...               Remove Product By Title    ${payload['title']}

  Create Session    pixel    ${base_url}

  &{headers}=       Create Dictionary    Authorization=${token}     Content-Type=application/json
  ${resp}=          Post Request    pixel    /products    data=${payload}    headers=${headers}
  
  [Return]    ${resp}

Post Auth
  [Arguments]    ${email}    ${password}
  Create Session    pixel    ${base_url}

  &{header}=        Create Dictionary   Content-Type=application/json
  &{payload}=       Create Dictionary   email=${email}    password=${password}

  ${resp}=          Post Request    pixel    /auth    data=${payload}    headers=${header}

  [Return]    ${resp}

Get Product
  [Arguments]    ${id}
  Create Session    pixel    ${base_url}

  &{headers}=       Create Dictionary    Authorization=${token}     Content-Type=application/json
  ${resp}=          Get Request    pixel    /products/${id}    headers=${headers}
  
  [Return]    ${resp}

Get Products
  Create Session    pixel    ${base_url}

  &{headers}=       Create Dictionary    Authorization=${token}     Content-Type=application/json
  ${resp}=          Get Request    pixel    /products    headers=${headers}
  
  [Return]    ${resp}

Delete Product
  [Arguments]    ${id}
  Create Session    pixel    ${base_url}

  &{headers}=       Create Dictionary    Authorization=${token}     Content-Type=application/json
  ${resp}=          Delete Request    pixel    /products/${id}    headers=${headers}
  
  [Return]    ${resp}

Put Product
  [Arguments]    ${id}    ${payload}    ${remove}=dont_remove
  Run Keyword If    "${remove}" == "before_remove"
  ...               Remove Product By Title    ${payload['title']}
  
  Create Session    pixel    ${base_url}

  &{headers}=       Create Dictionary    Authorization=${token}     Content-Type=application/json
  ${resp}=          Put Request    pixel    /products/${id}    data=${payload}    headers=${headers}
  
  [Return]    ${resp}