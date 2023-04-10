#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} L4_E11
    11 � Fa�a um programa em que o usu�rio possa
digitar um c�digo de produto e saber se esse
c�digo existe no sistema ou n�o. Caso exista,
apresente o C�digo, Descri��o e o Pre�o de Venda,
caso contr�rio, apresente uma mensagem
informando que n�o existe.
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

User Function L4_E11()

    Local cTitle := 'BUSCA PRODUTO'
    Local cTexto := 'Insira o c�digo do produto: '
    LOCAL cResul  := 'Consultar'
    LOCAL cSair   := '  Sair   '
    Local cCod := Space(15)
    Local nOpcao := 0
    Local oDlg       := NIL
    Private oDlgPvt  := NIL
    Private nJanLarg := 100
    Private nJanAltu := 300

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000,000 TO nJanLarg, nJanAltu PIXEL
    
    @ 010, 010 SAY    cTexto     SIZE 120, 12 OF oDlg PIXEL
    @ 010, 090 MSGET  cCod       SIZE 55, 11 OF oDlg PIXEL
    
    @ 025, 010 BUTTON cResul     SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 1, oDlg:End())
    @ 025, 090 BUTTON cSair      SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 2, oDlg:End())
    ACTIVATE MSDIALOG oDlg CENTERED

    
    if nOpcao == 1
        BusProdSQL(cCod)
    
    else 
        FwAlertError('Cancelado pelo usu�rio!', 'Cancelado!')
        RETURN

    ENDIF
Return



STATIC Function BusProdSQL(cCod)
    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ''
    Local cCodigo := ""
    Local cDescri := ''
    Local nValor  := 0

    rpcsetenv("99", "01")
    cCodigo := cCod

    cQuery := 'SELECT B1_COD as Codigo, B1_DESC, B1_PRV1' + CRLF
    cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1'  + CRLF
    cQuery += "WHERE B1_COD = '" + cCodigo + "'" + "and D_E_L_E_T_ <> '*'" + CRLF
    cQuery += " ORDER BY B1_DESC ASC "
    
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    if ALLTRIM(&(cAlias)->(Codigo)) == ''
       FwAlertInfo("n�o possui itens com este c�digo no sistema") 
       RETURN
    ENDIF

    while &(cAlias)->(!EOF())
        cDescri := &(cAlias)->(B1_DESC)
        nValor  := &(cAlias)->(B1_PRV1)
        &(cAlias)->(DbSkip())
    end

        FwAlertInfo('C�digo: ' + cCodigo + CRLF + 'Descri��o: ' + cDescri + CRLF + 'Pre�o de venda: ' + ALLTRIM(STR(nValor)), 'Dados do Produto')
        &(cAlias)->(DbCloseArea())
        RestArea(aArea)
Return 

