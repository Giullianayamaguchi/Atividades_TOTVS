#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L3_E15()

    Local aTemp  := {}
    Local aMes   :={"Janeiro", "Fevereiro", "Mar�o", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
    Local nCont  := 0
    Local nMedia := 0
    Local cMsg   := ''
    Local nVal   := 0


    For nCont := 1 to 3 
        nVal := Val(FwInputBox('Digite a temperatura do mes ' + aMes[nCont] +': '))
        aadd(aTemp, nVal)
    NEXT
    for nCont := 1 to 3
        nMedia += aTemp[nCont]
        cMsg += aMes[nCont] + ": " + alltrim(str(aTemp[nCont])) + " C�" + CRLF
    NEXT

    cMsg += "m�dia: " + Alltrim(str(nMedia/12)) + " C�" 
    fwAlertSucess(cMsg)

RETURN
