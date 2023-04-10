#INCLUDE "PROTHEUS.CH"

USER FUNCTION L1_E3()
    LOCAL nDist := 0
    LOCAL nVel  := 0
    LOCAL ntemp := 0
    LOCAL nGaso := 0
    LOCAL NkM   := 0 

    nVel := Val(FWInputbox("Digite a velocidade média:"))
    ntemp:= Val(FWInputbox("Digite o tempo gasto na viagem:"))
    NkM  := Val(FWInputbox("Digite o consumo padrão:", "por Km"))


    nDist := ntemp * nVel
    nGaso:= nDist / NkM

    FWAlertSucess("A velocidade média foi de: " +alltrim(str(noRound(nVel))) +CRLF+ ;
                  "O Tempo gasto na viagem foi de: " +alltrim(str(noRound(ntemp))) +CRLF+;
                  "o consumo por Km de gasolina foi de: " +alltrim(str(noRound(NkM))) +;
                  "A distância percorrida foi de: " +alltrim(str(noRound(nDist))) +CRLF+;
                  "A quantidade de litros de galosina gastos foi de: " + alltrim(str(noRound(nGaso,2))))
RETURN
