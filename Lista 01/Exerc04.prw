#include "protheus.ch"

USER FUNCTION EXERC04()
    Local nSalario := 0
    Local nPercent := 0
    Local nSalAjus := 0
    Local nPerSal  := 0

    nSalario := Val(FWInputbox("Digite o s�lario atual", "Sem o ajuste"))
    nPercent := Val(FWInputbox("Digite o o Percentural de reajuste", "somente n�mero"))

    nPerSal := nSalario / nPercent
    nSalAjus := nSalario + nPerSal

    MSGALERT( "O salario reajustado � de: " + ALLTRIM(STR(nSalAjus)),"Resultado" )


RETURN
