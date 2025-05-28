*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Log    Minha palavra aleatória: ${palavra_aleatoria}@emailteste.com
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}

Cadastrar o usuário criado na ServeRest
    ${body}    Create Dictionary
    ...    nome=cliente
    ...    email=${EMAIL_TESTE}
    ...    password=1234
    ...    administrador=true
    Log    ${body}
    Criar sessão na ServeRest
    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}

    Log    ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Criar sessão na ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id
