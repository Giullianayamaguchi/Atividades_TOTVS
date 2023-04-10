#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function L3_E11()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cForn  := ''
    Local cEstado := 'SP'
    Local cMsg := ''
    Local cQuery := ''

    rpcsetenv('99', '01')

    cQuery := 'SELECT A2_NOME' + CRLF
    cQuery += "FROM " + RetSqlName('SA2') + " SA2" + CRLF
    cQuery += "WHERE A2_EST = '" + cEstado + "' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())
        cForn := &(cAlias)->(A2_NOME)
        cMsg += cForn + CRLF + '__' + CRLF + CRLF
        &(cAlias)->(DbSkip())
    end

    FwAlertInfo(cMsg, 'FORNECEDORES DE SÃO PAULO')

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
Return
