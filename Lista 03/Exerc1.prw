#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


User Function L3_E4()
    Local aArea  := GetArea()
    Local cPod   := ''
    LOCAL cForn  := ''
    Local cMsg   := ''
    Local cArma  := ''
    Local nCont  := 1
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'
    DbSelectArea('SC7')
    DbSetOrder(1)
    
    
    while SC7->(!EOF())
        cPod  := SC7->C7_NUM
        cForn := SC7 ->C7_FORNECE
        

        if cArma != C7_NUM .and. cForn == "00004 "
            cMsg += 'Pedido : ' + cPod + CRLF
            cMsg += '------------------------------' + CRLF + CRLF
            nCont++
            cArma := SC7->C7_NUM
            
        else 
            DbSkip()
        ENDIF
        if nCont == 10
        FwAlertInfo(cMsg, 'Dados dos Clientes')
        nCont := 0
        cMsg  := ''    
        endif
        DbSkip()
    end
    if nCont > 0
        FwAlertInfo(cMsg, 'Dados dos Clientes')
    endif
    DbCloseArea()
    RestArea(aArea)
Return
