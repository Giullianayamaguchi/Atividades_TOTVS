#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E8
    8 – Desenvolva um programa que calcule o IMC
(Índice de Massa Corporal) de um indivíduo. Para
descobrir o valor do IMC, basta dividir o peso pela
altura ao quadrado. O usuário deve informar seu
peso e sua altura. Após o usuário inserir os
dados, o programa deve informar qual o valor do
IMC e a classificação, que segue as seguintes
regras:
o Menor que 18,5: Magreza – Obesidade (Grau): 0
o Entre 18,5 e 24,9: Normal – Obesidade (Grau): 0
o Entre 25,0 e 29,9: Sobrepeso – Obes. (Grau): I
o Entre 30,0 e 39,9: Obesidade – Obes. (Grau): II
o Maior que 40,0: Obes. Grave - Obes. (Grau): III
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/

USER FUNCTION L4_E8()
    LOCAL nPeso   := Space(20)
    LOCAL nAltura := Space(20)
    LOCAL cPerg1  := 'Digite o peso: '
    LOCAL cPerg2  := 'Digite a altura: '
    LOCAL cResul  := ' Ver Resultado'
    LOCAL cSair   := '    Sair     '
    LOCAL cTitle  := 'Calculadora IMC'
    LOCAL oDlg    := NIL
    LOCAL nOpcao  := 0
    Private oDlgPvt  := NIL
    Private nJanLarg := 150
    Private nJanAltu := 370


    DEFINE MSDIALOG oDlg  TITLE cTitle from 000, 000 to nJanLarg, nJanAltu PIXEL
    @ 010, 010 SAY   cPerg1  SIZE 55, 77 OF oDLG PIXEL
    @ 030, 010 SAY   cPerg2  SIZE 55, 77 OF oDlg PIXEL

    @ 010, 060 MSGET nPeso   SIZE 55, 11 OF oDlg PIXEL
    @ 030, 060 MSGET nAltura SIZE 55, 11 OF oDlg PIXEL 

    @ 010, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        IMC(nAltura, nPeso)

    else
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
    endif

Return


STATIC FUNCTION IMC(nAltura, nPeso)
    LOCAL nImc := 0
    LOCAL cMsg := ''

    nImc := Val(nPeso) / Val(nAltura)
    cMsg := "o peso do usuário é de: " + alltrim(str(nImc)) + CRLF

    if nIMC < 18.5 
        cMsg += "e se classifica com op grau: Magreza – Obesidade (Grau): 0"    

    Elseif nIMC > 18.5 .and. nImc < 24.9 
        cMsg += "e se classifica com op grau: Normal – Obesidade (Grau): 0"    

    Elseif nIMC > 25.0 .and. nImc < 29.9 
        cMsg += "e se classifica com op grau: Sobrepeso – Obes. (Grau): I"  


    Elseif nIMC > 30.0 .and. nImc < 39.9 
        cMsg += "e se classifica com op grau: Obesidade – Obes. (Grau): II"  
    
    Elseif nIMC > 40.0
        cMsg += "e se classifica com op grau: Obes. Grave - Obes. (Grau): III"
        
    ENDIF

    FwAlertSucess(cMsg)

RETURN
