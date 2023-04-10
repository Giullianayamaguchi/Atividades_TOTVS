#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} L4_E3
    3 - Escreva um algoritmo para ler o salário mensal
atual de um funcionário e o percentual de
reajuste. Calcular e escrever o valor do novo
salário.
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

USER FUNCTION L4_E3()
    LOCAL cTitle     := "Converter"
    LOCAL cText      := 'Digite o salario'
    LOCAL cText2     := 'Digite o percentual'
    LOCAL cResul     := ' Ver reajuste'
    LOCAL cSair      := '    Sair     '
    LOCAL nSala      := Space(20)
    LOCAL nPerc      := Space(20)
    LOCAL oDlg       := NIL
    LOCAL nOpcao     := 0
    Private oDlgPvt  := NIL
    Private nJanLarg := 150
    Private nJanAltu := 370


    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanLarg, nJanAltu PIXEL
    @ 014, 010 SAY cText  SIZE 55, 07 OF oDlg PIXEL
    @ 030, 010 SAY cText2 SIZE 55, 07 OF oDlg PIXEL

    @ 014, 060 MSGET nSala SIZE 55, 11 OF oDlg PIXEL 
    @ 030, 060 MSGET nPerc SIZE 55, 11 OF oDlg PIXEL 

    @ 014, 120 BUTTON oBtnConf PROMPT cResul SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 1, oDlg:End()) PIXEL
    @ 030, 120 BUTTON oBtnConf PROMPT cSair  SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (nOpcao := 2, oDlg:End()) PIXEL
    
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        REAJSUTE(nSala, nPerc)
    
    else 
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN

    ENDIF
RETURN

STATIC FUNCTION REAJSUTE(nSala, nPerc)

    LOCAL nReajuste := 0

    nReajuste := (Val(nSala)) + ((Val(nSala)) * (Val(nPerc)/100))

    FwAlertSucess("Reajuste do Sal[ario] " + (CVALTOCHAR(nReajuste)))

RETURN
