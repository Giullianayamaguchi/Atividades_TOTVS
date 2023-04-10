#include "PROTHEUS.CH"

USER FUNCTION EXERC08()

    LOCAL nSala  := 0
    LOCAL nHora  := 0
    LOCAL nFinal := 0
    LOCAL nAcres := 0
    LOCAL nCont  := 1
    LOCAL nHor   := 0

    while nCont <=4
    nHora := Val(FWInputBox("Digite a quantidade de horas trabalhadas na " + ALLTRIM(STR(nCont)) +"semana: "))
    nHor += nHora
    nCont++
    
    ENDDO
    msgalert(nHor)

    nSala := Val(FWInputBox("Digite o valor da hora: ", "Sem horas extra"))
    
    if nHor > 160
        nHora := nHor - 160
        nAcres := nSala/2
        nFinal := (nHora * nAcres) + (160 * nSala)
        MSGALERT("O salário ajustado é de: "+ ALLTRIM(STR(nFinal)) )

    else 
        nFinal := nHora * nSala
        MSGALERT( "O salário é de: " + ALLTRIM(STR(nFinal)) )

    endif


RETURN
