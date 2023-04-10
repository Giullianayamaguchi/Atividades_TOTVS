#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} L4_E16
    16 – Crie uma rotina que retorne todos os
clientes situados em um estado/uf selecionado
pelo usuário.
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


USER FUNCTION L4_E16()

    LOCAL cCLi    := SPACE(2)
    LOCAL nOpcao  := 0
    LOCAL cTitle  := 'Pesquisando Cliente'
    local cPerg1  := 'Digite o Estado/UF para pesquisar'
    LOCAL cResul  := 'Consultar'
    LOCAL cSair   := '  Sair   '
    LOCAL oDlg    := NIL
    Private nJanLarg := 100
    Private nJanAltu := 300

    DEFINE MSDIALOG oDlg  TITLE cTitle from 000, 000 to nJanLarg, nJanAltu PIXEL
    @ 010, 010 SAY cPerg1 SIZE 55, 77 OF oDLG PIXEL 

    @ 010, 090 MSGET cCLi SIZE 55, 11 OF oDlg PIXEL

    @ 025, 010 BUTTON cResul     SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 1, oDlg:End())
    @ 025, 090 BUTTON cSair      SIZE 55, 11 OF oDlg PIXEL ACTION (nOpcao := 2, oDlg:End())
    ACTIVATE MSDIALOG oDlg CENTERED

    if nOpcao == 1
        PesqCli(cCLi)

    else
        FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
    endif
Return

Static Function PesqCli(cCLi)
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cForn  := ''
    Local cEstado := ''
    Local cMsg := ''
    Local cQuery := ''

    cEstado := upper(alltrim(cCLi))
    rpcsetenv('99', '01')

    cQuery := 'SELECT A2_NOME' + CRLF
    cQuery += "FROM " + RetSqlName('SA2') + " SA2" + CRLF
    cQuery += "WHERE A2_EST = '" + cEstado + "' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    if alltrim(cForn := &(cAlias)->(A2_NOME)) != ''
        while &(cAlias)->(!EOF())
            cForn := &(cAlias)->(A2_NOME)
            cMsg += cForn + CRLF + '__' + CRLF + CRLF
            &(cAlias)->(DbSkip())
        end

        FwAlertInfo(cMsg, 'FORNECEDORES DE ' + alltrim(cEstado))

        &(cAlias)->(DbCloseArea())
        RestArea(aArea)
    else 
        FwAlertError("ERRO, Estado/UF incorreto ou não foi encontrados fornecedores para o Estado inserido")
        RETURN
    ENDIF

Return
