#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E10
    – Faça um programa para o cálculo de uma folha
de pagamento, sabendo que os descontos são do
imposto de Renda, que depende do salário bruto
(conforme tabela abaixo) e 10% para o INSS. Além
disso, existe o FGTS que corresponde a 11% do
salário bruto, mas não é descontado (é a empresa
que deposita).
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

USER FUNCTION L4_E10()

    LOCAL nHora   := Space(20)
    LOCAL nQuant  := Space(20)
    Local cPerg1  := 'Digite o valor da hora: '
    LOCAL cPerg2  := 'Digite a quantidade de horas trabalhadas:  '
    LOCAL cTitle  := 'Calculadora TMB'
    LOCAL cResul  := ' Ver Salário '
    LOCAL cSair   := '    Sair     '
    LOCAL oDlg
    LOCAL nOpcao := 0
    Private oDlgPvt  := NIL
    Private nJanLarg := 200
    Private nJanAltu := 300

    DEFINE MSDIALOG oDlg  TITLE cTitle from 000, 000 to nJanLarg, nJanAltu PIXEL
    @ 010, 010 SAY cPerg1  SIZE 55, 77 OF oDLG PIXEL
    @ 034, 010 SAY cPerg2  SIZE 55, 77 OF oDlg PIXEL


    @ 010, 065 MSGET nHora  SIZE 55, 11 OF oDlg PIXEL
    @ 034, 065 MSGET nQuant SIZE 55, 11 OF oDlg PIXEL 

    @ 010, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

     if nOpcao == 1
         Salario(nHora, nQuant)

    else
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
    endif
Return


Static FUNCTION Salario(nHora, nQuant)
    Local nSalario :=0 
    Local nIR      :=0
    LOCAL nSalIR   := 0
    LOCAL nInss    := 0
    LOCAL nFGTS    := 0
    LOCAL nFinal   := 0
    LOCAL nDesc    := 0

    nSalario := Val(nHora) * Val(nQuant)

    if nSalario <= 1200
        nIR := 0
    Elseif nSalario >= 1201 .and. nSalario <1800
        nIR := 0.05

    Elseif nSalario >= 1801 .and. nSalario <2500
        nIR := 0.10
    
    Elseif nSalario >= 2500
        nIR := 0.20

    ENDIF

    nSalIR := nSalario * nIR
    nInss  := nSalario * 0.10
    nFGTS  := nSalario * 0.11
    nDesc  := nSalIR + nInss
    nFinal := nSalario - nDesc


    FwAlertSucess("Salario Bruto (" + ALLTRIM(nHora) + " * " + ALLTRIM(nQuant) + ") R$ " + (STR(nSalario)) + CRLF +;
    "(-) ir (" + Alltrim(str(nIR*100)) + "%) R$ " +  (STR(nSalIR)) + CRLF +;
    "( – ) INSS ( 10% ) : R$ " + alltrim(str(nInss))  + CRLF +; 
    "FGTS ( 11%) : R$ " + ALLTRIM(STR(nFGTS))  + CRLF +;
    "Total de descontos : R$ " + ALLTRIM(STR(nFinal)))
    


RETURN
