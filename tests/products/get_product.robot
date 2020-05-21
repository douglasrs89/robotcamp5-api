***Settings***
Documentation       GET /products
...                 Consulta de produtos consumindo a API

Resource     ../../resources/helpers.robot
Resource    ../../resources/services.robot

Suite Setup     Set Suite Var Auth Token  ${user_email}    ${user_password}

**Test Cases***
Get Unique Product
  [tags]    success
  ${product}=   Get Data From Json File     unique_product.json
  ${unique}=    Post Product    ${product}    before_remove

  ${id}=        Convert To String     ${unique.json()['id']}

  ${resp}=      Get Product     ${id}

  Status Should Be    200    ${resp}
  Should Be Equal     ${resp.json()['title']}    ${product['title']}

Product Not Found
  [Tags]    not_found

  ${resp}=    Get Product    1500
  Status Should Be    404    ${resp}
