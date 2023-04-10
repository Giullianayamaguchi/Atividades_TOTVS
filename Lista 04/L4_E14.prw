#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} L4_E14
    14 – Altere a rotina do exercício anterior,
permitindo que o usuário selecione um dos
produtos que já estão cadastrados do Protheus.
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

USER FUNCTION L4_E14()
    Local cTitle   := 'BUSCA PEDIDO'
    Local cProd    := 'Código do produto: '
    LOCAL cBuscar  := '  Buscar '
    LOCAL cResul   := 'Consultar'
    LOCAL cSair    := '  Sair   '
    Local cPro     := Space(15)
    Local oDlg     := NIL
    Private oDlgPvt  := NIL
    Private nJanLarg := 150
    Private nJanAltu := 400

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanLarg, nJanAltu PIXEL
    @ 014, 010 SAY cProd  SIZE 55, 07 OF oDlg PIXEL
    @ 014, 070 MSGET cPro SIZE 55, 07 OF oDlg PIXEL 

    @ 030, 010 BUTTON oBtnConf PROMPT cBuscar   SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (Busca_SQL(cPro)) PIXEL
    @ 030, 070 BUTTON oBtnConf PROMPT cResul    SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (Consul_Sql()) PIXEL
    @ 030, 130 BUTTON oBtnConf PROMPT cSair     SIZE (nJanLarg/2)-19, 010 OF oDlgPvt ACTION (oDlg:End()) PIXEL
    ACTIVATE MSDIALOG oDlg CENTERED

RETURN

STATIC FUNCTION Busca_SQL(cPro)
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

STATIC FUNCTION Consul_Sql()


    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    Local cMsg   := ''
    Local nCont  := 0

    rpcsetenv('99', '01')

    cQuery := 'SELECT C6_PRODUTO, C6_DESCRI' + CRLF + "FROM " + RetSqlName('SC6')

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())

        cMsg += 'Código: '     + &(cAlias)->(C6_PRODUTO) + CRLF +; 
                'Descrição: '  + &(cAlias)->(C6_DESCRI) + CRLF +;
                '_______________________' + CRLF + CRLF

        &(cAlias)->(DbSkip())

        nCont++
		
		if nCont == 10
			FwAlertInfo(cMsg, 'Produtos Cadastrados')
			cMsg := ''; nCont := 0
		endif
    END
        FwAlertInfo(cMsg, 'Dados do Produto')
        &(cAlias)->(DbCloseArea())
        RestArea(aArea)

RETURN
