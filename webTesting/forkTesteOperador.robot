*** Settings ***
Resource    ../../../base.resource
Resource    ../../../data/DadosLogin.resource
Resource    ../../login/LoginPage.resource

# Library    OperatingSystem

*** Variables ***
${operador}                     //span[@class='MuiTab-wrapper'][contains(.,'Operador')]
${inserir_novos_registros}      //span[contains(.,'Inserir Novos Registros')]
${btn_importar_planilha}        //span[contains(.,'Importar Planilha')]
${planilha_novos_registros}      C:\\Fast2mine - miningcontrol\\fast2_mine_main\\fast2mine\\resources\\data\\template_operators.xlsx    #
${planilha_editar_registros}     C:\\Fast2mine - miningcontrol\\fast2_mine_main\\fast2mine\\resources\\data\\operators.xlsx
${btn_editar_registros}         //span[contains(.,'Editar Registros')]

*** Keywords ***
Acionar a opção operador
    Verificar se estou na página inicial
    Inserir email e senha cadastrados
    Acionar o botão enter para autenticar no sistema
    Login realizado
    Acessar modulo Gerenciamento da Plataforma Mining Control
    browser.click    ${operador} 
Download da Planilha para Inserir Novos Registros Operador
    ${dl_promise}    Promise To Wait For Download    ${planilha_novos_registros}
    browser.click    ${inserir_novos_registros}
    ${arquivo}    Wait For  ${dl_promise}
    File Should Exist   ${planilha_novos_registros}
    
Arquivo salvo na pasta do projeto Operador
    builtin.Sleep    3

Importar Planilha com os novos registros Operador
   browser.click    ${btn_importar_planilha}
   builtin.Sleep    2
   pyautogui.Write    message=${planilha_novos_registros}
   Press    enter
   builtin.Sleep    2

remove o arquivo da pasta Operador
    Log    Verificando se o arquivo está na pasta
    File Should Exist  ${planilha_novos_registros}

    Log    Excluindo o arquivo da pasta
    Remove File        ${planilha_novos_registros}

    Log    Verificando se o arquivo foi excluído da pasta
    File Should Not Exist  ${planilha_novos_registros}  
Editar Registros Operador
    ${dl_promise}    Promise To Wait For Download    ${planilha_editar_registros}
    browser.click    ${btn_editar_registros}
    ${arquivo}    Wait For  ${dl_promise}
    File Should Exist   ${planilha_editar_registros}
    builtin.Sleep    2