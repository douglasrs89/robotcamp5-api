***Settings***
Documentation     Post /products
...               Testes do cadastro de produtos consumindo a API

Library     RequestsLibrary

Resource     ../../resources/helpers.robot
Resource    ../../resources/services.robot

Suite Setup    Set Suite Var Auth Token    ${user_email}    ${user_password}

***Test Cases***
# Criar novo produto
  # Dado que o usuário submeteu o formulário de cadastro    dk2.json
  # Quando eu solicito uma requisição POST para o serviço /products
  # Então o código de resposta deve ser    200

Criar Novo Produto
  ${payload}=    Get Data From Json File    dk2.json
  ${resp}=       Post Product    ${payload}    before_remove

  Status Should Be    200    ${resp}

Duplicate Product
  ${payload}=    Get Data From Json File    duplicate.json
  Post Product    ${payload}    before_remove
  ${resp}=       Post Product    ${payload}

  Status Should Be    409    ${resp}

Empty Title
  ${payload}=    Get Data From Json File    empty_title.json
  ${resp}=       Post Product    ${payload}
     
  Status Should Be    400    ${resp}

Empty Category
  ${payload}=    Get Data From Json File    empty_title.json
  ${resp}=       Post Product    ${payload}

  Status Should Be    400    ${resp}

Empty Price
  ${payload}=    Get Data From Json File     empty_title.json
  ${resp}=       Post Product  ${payload}

  Status Should Be    400    ${resp}