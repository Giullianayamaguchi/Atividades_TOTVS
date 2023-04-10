#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} L4_E13
    13 – Desenvolva uma rotina em que, com base em um
código de produto informado pelo usuário, retorne
todos os pedidos de venda em que esse produto
está sendo usado.
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

USER FUNCTION L4_E13()
    Local cTitle := 'BUSCA PEDIDO'
    Local cProd   := 'Código do produto: '
    Local cResul  := 'Consultar'
    Local cSair   := '  Sair   '
    Local cPro   := Space(15)
    Local nOpcao := 0
    Local oDlg := NIL
    Private nJanLarg := 100
    Private nJanAltu := 450

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO 100, 450 PIXEL
    
    @ 014, 010 SAY    cProd   SIZE 120, 12 OF oDlg PIXEL
    @ 010, 090 MSGET  cPro    SIZE 55, 11 OF oDlg PIXEL

    @ 010, 160 BUTTON cResul  SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 1, oDlg:End())
    @ 034, 160 BUTTON cSair   SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 2, oDlg:End())
    
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        BuscaSQ(cPro)
    
    else 
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
        RETURN

    ENDIF

RETURN



STATIC FUNCTION BuscaSQ(cPro)
 Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    Local cMsg   := ''
    Local cPed   := ''
    rpcsetenv("99", "01")

    cPed := alltrim(cPro)

    cQuery := "SELECT SB1.B1_COD, CONCAT(SC6.C6_NUM, ', ') AS NUMPED_CODPROD" + CRLF
    cQuery +="FROM " + RetSqlName('SB1') + " SB1"  + CRLF
    cQuery += "INNER JOIN SC6990 AS SC6 ON SC6.C6_PRODUTO = SB1.B1_COD" + CRLF
    cQuery += "WHERE SB1.B1_COD = '" + cPed+ "'" 

    TCQUERY cQuery ALIAS &(cAlias) new 
    &(cAlias)->(dbGoTop())

    if ALLTRIM(&(cAlias)->(NUMPED_CODPROD)) == ''
       FwAlertInfo("não possui itens com este código no sistema") 
       RETURN
    ENDIF

    while &(cAlias)->(!EOF())
        cMsg := "O produto " + ALLTRIM( cPed ) 
        cMsg += " se encontra nos itens " + alltrim((&(cAlias)->(NUMPED_CODPROD)))
        &(cAlias)->(DbSkip())
       
    END

    FwAlertInfo(cMsg, 'Dados do Produto')
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

RETURN
