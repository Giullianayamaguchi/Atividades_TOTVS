#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC10_2()
    LOCAL aNum := ARRAY(3)
    LOCAL nCont := 0
    LOCAL cMens := ""

    for nCont := 1 to 3
        aNum[nCont] := Val(FWInputBox("Digiet um número"))
    NEXT

    for nCont := 1 to 3
        asort(aNum, 1, 3)
     //   asort(aNum, 1,3)
        cMens += alltrim(str(aNum[nCont])) + CRLF
    next

    FwAlertSucess(cMens)

RETURN
