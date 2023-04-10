#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L3_E15()

    Local aTemp  := {}
    Local aMes   :={"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}
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
        cMsg += aMes[nCont] + ": " + alltrim(str(aTemp[nCont])) + " Cº" + CRLF
    NEXT

    cMsg += "média: " + Alltrim(str(nMedia/12)) + " Cº" 
    fwAlertSucess(cMsg)

RETURN
