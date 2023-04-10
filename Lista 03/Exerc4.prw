#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


User Function L3_E4()
    Local aArea  := GetArea()
    Local cPod   := ''
    LOCAL cGrup  := ''
    Local cMsg   := ''
    Local nCont  := 0
    
    rpcsetenv('99', '01')

    DbSelectArea('SB1')
    DbSetOrder(1)
    DbGoTop()
    
    
    while SB1->(!EOF())
        cPod  := SB1->B1_cod
        cGrup := SB1->B1_Grupo
//        IF vAL(cNota) >= 000001
        IF cGrup == '2   '         
            cMsg += 'produto ' +Alltrim(str(nCont))+' : ' + cPod + CRLF
            cMsg += '------------------------------' + CRLF + CRLF
            nCont++
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
    ELSE
        MSGSTOP( "AA")
    endif
    DbCloseArea()
    RestArea(aArea)
Return
