*** Settings ***
Resource    ../../base.resource

*** Variables ***
${input_email}            //*[@id="E-mail"]
${input_senha}            //input[@name='Password']
${btn_enter}              //button[contains(.,'ENTRAR')]
${input_emnail_invalido}  //p[contains(.,'Email / senha inválidos')]

*** Keywords ***
Inserir email e senha cadastrados
    browser.click          ${input_email}
    Fill Text              ${input_email}    txt=${email}
    browser.click          ${input_senha}
    Fill Secret            ${input_senha}    secret=$password
    
    # browser.click     ${input_email}
    # Fill Text        ${input_email}    text=${email}
    # browser.click     ${input_senha}
    # Fill Secret    ${input_senha}    password=${password}  
Acionar o botão enter para autenticar no sistema
   browser.click          ${btn_enter}
Login realizado
    builtin.Sleep    3s

# Login inválido
Inserir email e senha cadastrados errados
    Fill Text        ${input_email}     txt=${email_invalido}
    Fill Secret      ${input_senha}       secret=${password}  

login invalido      
   Wait For Elements State    ${input_emnail_invalido}
   