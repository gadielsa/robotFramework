*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.amazon.com.br
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${TXT_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia
${ELETRONICOS}               //span[@class='nav-a-content'][contains(.,'Eletrônicos')]
${BARRA_DE_PESQUISA}         twotabsearchtextbox
${BOTAO_DE_PESQUISA}         nav-search-submit-button
${IMG_XBOX}                  //img[contains(@alt,'Console Xbox Series S')]
${ADICIONAR_AO_CARRINHO}     //input[contains(@name,'submit.add-to-cart')]
${VALOR_CARRINHO}            sw-subtotal-item-count
${ACESSAR_CARRINHO}          //a[@id='nav-cart']
${TITULO_CARRINHO}           //title[@dir='ltr'][contains(.,'Carrinho de compras da Amazon.com')]
${SELECIONAR_QUANTIDADE}     //span[@class='a-button-text a-declarative'][contains(.,'Qtd:1')]
${EXCLUIR}                   //a[@tabindex='-1'][contains(@id,'0')][contains(.,'0 (Excluir)')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

#Caso de teste 01

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "Eletrônicos e Tecnologia"
    Wait Until Page Contains    text=${TXT_HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece Eletrônicos
    Element Should Be Visible    locator=${ELETRONICOS}

#Caso de teste 02

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=${BARRA_DE_PESQUISA}    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=${BOTAO_DE_PESQUISA}

Verificar o resultado da pesquisa se está listando "${PRODUTO}"
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')]

#Caso de teste 03

Adicionar o produto "Console Xbox Series S" no carrinho
    Click Element    locator=${IMG_XBOX}
    Click Element    locator=${ADICIONAR_AO_CARRINHO}

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=${VALOR_CARRINHO}
    Element Should Be Visible    locator=//span[@class='a-size-base'][contains(.,'${PRODUTO}')]

    #Caso de teste 04

Remover o produto "${PRODUTO}" do carrinho
    Click Element    locator=${ACESSAR_CARRINHO}
    Wait Until Element Is Visible    locator=${TITULO_CARRINHO}
    Click Element    locator=${SELECIONAR_QUANTIDADE}
    Click Element    locator=${EXCLUIR}

Verificar se o carrinho fica vazio
    Element Should Be Visible    locator=//h2[@class='a-size-extra-large a-spacing-mini a-spacing-top-base a-text-normal'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

#Gherkin Steps
#Caso de teste 01

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E eletrônicos deve ser exibida na página
    Verificar se aparece Eletrônicos

#Caso de teste 02

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"
        
E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando "Xbox Series S"

#Caso de teste 03

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

#Caso de teste 04

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
