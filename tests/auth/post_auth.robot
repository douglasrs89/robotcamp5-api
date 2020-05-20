***Settings***
Documentation     Post /auth
...               Testes do serviço de autorização

Library     RequestsLibrary

Resource    ../../resources/services.robot

Suite Setup    Auth Token    ${user_email}    ${user_password}

***Test Cases***

Successfuly Login
  ${resp}=       Post Auth    douglas@ninjapixel.com    q1w2E3R4@!

  Status Should Be    200    ${resp}

Incorrect Password
  ${resp}=       Post Auth    douglas@ninjapixel.com    q1w2E3R4@

  Status Should Be    401    ${resp}