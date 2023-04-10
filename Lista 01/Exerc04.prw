#include "protheus.ch"

USER FUNCTION EXERC04()
    Local nSalario := 0
    Local nPercent := 0
    Local nSalAjus := 0
    Local nPerSal  := 0

    nSalario := Val(FWInputbox("Digite o sálario atual", "Sem o ajuste"))
    nPercent := Val(FWInputbox("Digite o o Percentural de reajuste", "somente número"))

    nPerSal := nSalario / nPercent
    nSalAjus := nSalario + nPerSal

    MSGALERT( "O salario reajustado é de: " + ALLTRIM(STR(nSalAjus)),"Resultado" )


RETURN
