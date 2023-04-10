#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E2
    2 – Desenvolva um programa que converta Dólar
(US$) para Real (R$). O programa deverá solicitar
ao usuário o valor do Dólar e a quantidade de
dólares que deseja converter. No final,
apresentar o valor total convertido para reais.
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

USER FUNCTION L4_E2()
    LOCAL cTitle := "Converter"
    LOCAL cText  := 'Digite a Cotação atual'
    LOCAL cText2 := 'Digite a quantidade de dolar'
    LOCAL cResul    := 'Ver Conversão'
    LOCAL cSair     := '    Sair     '
    LOCAL nDolar := Space(20)
    LOCAL nQuant := Space(20)
    LOCAL oDlg   := NIL
    LOCAL nOpcao := 0
    Private oDlgPvt
    Private nJanLarg := 150
    Private nJanAltu := 400


    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanLarg, nJanAltu PIXEL
    @ 014, 010 SAY   cText  SIZE 55, 07 OF oDlg PIXEL
    @ 030, 010 SAY   cText2 SIZE 55, 07 OF oDlg PIXEL

    @ 014, 065 MSGET nDolar SIZE 55, 11 OF oDlg PIXEL 
    @ 030, 065 MSGET nQuant SIZE 55, 11 OF oDlg PIXEL 

    @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        CONVERTER(nQuant, nDolar)
    
    else 
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN
    ENDIF

RETURN

STATIC FUNCTION CONVERTER(nQuant, nDolar)

    LOCAL nConve := 0

    nConve := (Val(nQuant)) * (Val(nDolar))

    FwAlertSucess("com a cotação do dólar em: " + (CVALTOCHAR(nDolar)) + CRLF +;
    "e a quantidade de: " + (CVALTOCHAR(nQuant)) + CRLF + "convertido fica em: ";
    + (CVALTOCHAR(nConve)))


RETURN
