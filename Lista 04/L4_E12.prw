#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} L4_E12
    12 – Faça um programa em que o usuário possa
digitar um período (data início / data fim) e saber
quais são os pedidos de compra existentes no
período informado.
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

USER FUNCTION L4_E12()
    Local cTitle := 'BUSCA PEDIDO'
    Local cIni   := 'Insira a data de início: '
    Local cFim   := 'Insira a data final: '
    LOCAL cResul  := 'Consultar'
    LOCAL cSair   := '  Sair   '
    Local cDtFn   := Space(15)
    Local cDtIn  := Space(15)
    Local nOpcao := 0
    Local oDlg := NIL    
    Private nJanLarg := 100
    Private nJanAltu := 400


    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO nJanLarg, nJanAltu PIXEL
    
    @ 010, 010 SAY    cIni     SIZE 120, 12 OF oDlg PIXEL
    @ 030, 010 SAY    cFim     SIZE 120, 12 OF oDlg PIXEL
    
    @ 010, 070 MSGET  cDtIn    SIZE 55, 11 OF oDlg PIXEL
    @ 030, 070 MSGET  cDtFn    SIZE 55, 11 OF oDlg PIXEL

    @ 010, 130 BUTTON cResul   SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 1, oDlg:End())
    @ 030, 130 BUTTON cSair    SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 2, oDlg:End())
    ACTIVATE MSDIALOG oDlg CENTERED

    
    if nOpcao == 1
        BuscaSQL(cDtIn, cDtFn)
    
    else 
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN

    ENDIF

RETURN


Static Function BuscaSQL(cDtIn, cDtFn)
    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ''
    Local cDataIni := ''
    Local cDataFim := ''
    Local cCod    := ''

    cDataIni := alltriM(cDtIn)
    cDataFim := alltrim(cDtFn)
    rpcsetenv("99", "01")

    cQuery := 'SELECT C5_NUM' + CRLF
    cQuery += 'FROM ' + RetSqlName('SC5') + ' SC5'  + CRLF
    cQuery += "WHERE C5_EMISSAO  BETWEEN '" + cDataIni + "' AND '" +  cDataFim + "' and D_E_L_E_T_ <> '*'" 
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cCod +='Código do pedido: ' + &(cAlias)->(C5_NUM) + CRLF
        &(cAlias)->(DbSkip())
    end

        FwAlertInfo(cCod, 'Dados do Produto')
        &(cAlias)->(DbCloseArea())
        RestArea(aArea)
Return 
