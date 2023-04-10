#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E4()

    LOCAL nA   := 0
    LOCAL nB   := 0
    LOCAL nCon := 0

    nA := Val(FWInputbox("Digite o valor para A: "))
    nB := Val(FWInputbox("Digite o valor para B: "))

    nCon := (nA -nB)**2

    FWAlertSucess("O valor final fica: " + alltrim(str(nCon)))
RETURN
