#include "PROTHEUS.CH"

USER FUNCTION L2_E10()
    Local nA :=0
    Local nB :=0
    Local nC :=0
    Local nD :=0
    Local nE := 0

    Local nM_1 :=0
    Local nM_2 :=0
    Local nM_3 :=0
    Local nM_4 :=0
    
    Local nN_1 :=0
    Local nN_2 :=0
    Local nN_3 :=0
    Local nN_4 :=0
    

    nA := Val(FWInputbox("Informe o dado a: "))
    nB := Val(FWInputbox("Informe o dado b: "))
    nC := Val(FWInputbox("Informe o dado c: "))
    nD := Val(FWInputbox("Informe o dado d: "))
    nE := Val(FWInputbox("Informe o dado e: "))

    nM_1 := MAX(nA, nB)
    nM_2 := MAX(nM_1, nC)
    nM_3 := MAX(nM_2, nD)
    nM_4 := MAX(nM_3, nE)

    nN_1:= MIN(nA, nB)
    nN_2 := MIN(nN_1, nC)
    nN_3 := MIN(nN_2, nD)
    nN_4 := MIN(nN_3, nE)

    FwAlertSucess("Maior: " + alltrim(str(nM_4)))
    FwAlertSucess("Menor: " + alltrim(str(nN_4)))

RETURN NIL
