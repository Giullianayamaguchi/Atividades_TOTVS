#INCLUDE "PROTHEUS.CH"

USER FUNCTION EXERC36()

    LOCAL nCont := 0
    local nFato := 0

    nFato := Val(FWInputbox("Digite o n�mero para fatorar: "))

    for nCont := (nFato-1) to 1 step -1
        nFato *= nCont
    NEXT

    FWAlertSucess("o Fatoral � de: " + alltrim(str(nFato)))

RETURN
