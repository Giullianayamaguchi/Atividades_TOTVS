#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

User Function L3_E3()
    Local aArea := GetArea(), cAlias := GetNextAlias()
    Local cMsg  := '', cQuery   := ''

    rpcsetenv('99', '01')
    
    cQuery := "SELECT C5.C5_NUM, C6.C6_PRODUTO, C6.C6_DESCRI, C6.C6_QTDVEN, C6.C6_PRCVEN, C6.C6_VALOR" + CRLF
    cQuery += "FROM " + RetSqlName('SC5') + " C5" + CRLF
    cQuery += "INNER JOIN " + RetSqlName('SC6') +  " C6 ON C5.C5_NUM = C6.C6_NUM WHERE C5_NUM = 'PV0008'" + CRLF

    TCQUERY cQuery ALIAS &(cAlias)

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
 
        cMsg += 'Pedido : '+ &(cAlias)->(C6_PRODUTO) + CRLF +;
                'Descrição : ' + cValToChar(&(cAlias)->(C6_DESCRI))+ CRLF +;
                'Quantidade : ' + cValToChar(&(cAlias)->(C6_QTDVEN)) + CRLF +;
                'Valor unitário : R$' + cValToChar(&(cAlias)->(C6_PRCVEN)) + CRLF +;
                'Valor total : R$'    + cValToChar(&(cAlias)->(C6VALOR))  + CRLF +;
                '__' + CRLF + CRLF
        &(cAlias)->(DbSkip())
    end

    FwAlertInfo(cMsg, 'Produtos no pedido de venda - PV0008')

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return
