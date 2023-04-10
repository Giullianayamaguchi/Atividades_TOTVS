#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


User Function Preco()

    Local aArea      := GetArea() // área atual da tabela
    Local cAlias     := GetNextAlias()
    Local cQuery     := ''
    Local cMsg       := ''

    //definir o ambiente de execução da consulta SQL.
    rpcsetenv("99", "01")

    cQuery := "SELECT TOP 1 MAX(C6_PRCVEN) AS MAIOR_VALOR, MIN(C6_PRCVEN) AS MENOR_VALOR " +CRLF
    cQuery += "FROM " + RetSqlName('SC6') + " SC6" 

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cMsg := "item com maior preço: " + alltrim(str(&(cAlias)->(MAIOR_VALOR))) + CRLF
        cMsg += "item com menor preço: " + alltrim(str(&(cAlias)->(MENOR_VALOR))) 
 
        &(cAlias)->(DbSkip())
    end

    FwAlertInfo(cMsg, 'Dados do Produto')
        &(cAlias)->(DbCloseArea())
        RestArea(aArea)
Return 
