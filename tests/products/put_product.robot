
***Settings***
Documentation    PUT /products
...              Testes de atualização de produtos consumindo a API

Library    RequestsLibrary

Resource    ../../resources/helpers.robot
Resource    ../../resources/services.robot

Suite Setup    Set Suite Var Auth Token    ${user_email}    ${user_password}

***Test Cases***

Update Product
  ${product}=           Get Data From Json File    product_to_update.json
  ${product_update}=    Get Data From Json File    update_product.json

  ${post_resp}=    Post Product    ${product}    before_remove
  ${id}=           Convert To String    ${post_resp.json()['id']}

  ${put_resp}=     Put Product    ${id}    ${product_update}    before_remove
  Status Should Be    204    ${put_resp}
  
  ${resp_product}=    Get Product  ${id}
  Should Be Equal    ${resp_product.json()['title']}    ${product_update['title']}

Conflict To Update Product
  ${list_products}=    Get Data From Json File    products_to_conflict.json
  ${conflict_product}=    Get Data From Json File    conflict_product.json

  ${products}=    Set Variable    ${list_products['data']}

  FOR    ${product}    IN    @{products}
      ${post_resp}    Post Product    ${product}    before_remove
  END

  ${id}=    Convert To String    ${post_resp.json()['id']}

  ${put_resp}=     Put Product    ${id}    ${conflict_product}

  Status Should Be    409    ${put_resp}
  Should Be True    "title must be unique" == "${put_resp.json()['msg']}"