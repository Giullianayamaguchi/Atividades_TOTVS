#INCLUDE "PROTHEUS.CH"

USER FUNCTION L1_E2()
    LOCAL nDist := 0
    LOCAL nVel  := 0
    LOCAL ntemp := 0
    Local nGaso := 0

    nVel := Val(FWInputbox("Digite a velocidade média:"))
    ntemp:= Val(FWInputbox("Digite o tempo gasto na viagem:"))

    nDist := ntemp * nVel
    nGaso:= nDist / 12

    FWAlertSucess("A velocidade média foi de: " +alltrim(str(noRound(nVel))) +CRLF+ ;
                  "O Tempo gasto na viagem foi de: " +alltrim(str(noRound(ntemp))) +CRLF+;
                  "A distância percorrida foi de: " +alltrim(str(noRound(nDist))) +CRLF+;
                  "A quantidade de litros de galosina gastos foi de: " + alltrim(str(noRound(nGaso,2))))
RETURN
