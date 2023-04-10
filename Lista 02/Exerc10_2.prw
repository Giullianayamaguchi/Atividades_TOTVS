#include "PROTHEUS.CH"

USER FUNCTION L2_E10_2()
    Local aArray :={}
    Local nCont  :=0
    Local nVal   := 0
    
    For nCont := 1 to 5
        nVal := Val(FwInputBox("Digite o " + alltrim(str(nCont)) + "° Numero: "))
        aadd(aArray, nVal )
    NEXT

    For nCont := 1 to 5
        ASORT( aArray, 1, 5)
    NEXT


    FwAlertSucess("Maior: " + alltrim(str(aArray[5])))
    FwAlertSucess("Menor: " + alltrim(str(aArray[1])))

RETURN 
