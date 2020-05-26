***Settings***
Documentation       DELETE /products
...                 Apaga de produtos consumindo a API

Resource     ../../resources/helpers.robot
Resource    ../../resources/services.robot

Suite Setup     Set Suite Var Auth Token  ${user_email}    ${user_password}

**Test Cases***
Delete Product
  [tags]    success
  ${product}=   Get Data From Json File     delete.json
  ${unique}=    Post Product    ${product}    before_remove

  ${id}=        Convert To String     ${unique.json()['id']}

  ${resp}=      Delete Product     ${id}

  Status Should Be    204    ${resp}

Product Not Found
  [Tags]    not_found

  ${resp}=    Delete Product    1500
  Status Should Be    404    ${resp}
