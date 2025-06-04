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
    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary
    ...    nome=cliente
    ...    email=${email}
    ...    password=1234
    ...    administrador=true
    Log    ${body}

    Criar sessão na ServeRest

    ${resposta}    POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=${status_code_desejado}

    Log    ${resposta.json()}
    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}    
    END
    
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Criar sessão na ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Repetir o cadastro do usuário
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}    status_code_desejado=400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}
    Set Test Variable    ${RESPOSTA_CONSULTA}    ${resposta_consulta.json()}

Conferir os dados retornados
    Log    ${RESPOSTA_CONSULTA}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    nome    cliente
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    email    ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    password    1234
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    administrador    true
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id    ${ID_USUARIO}
