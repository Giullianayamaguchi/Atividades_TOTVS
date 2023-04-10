#include 'protheus.ch'

USER FUNCTION EXERC13()
    LOCAL cNome  := ""
    LOCAL nQuant := 0
    LOCAL nValor := 0
    LOCAL nTotal := 0

        cNome := FWInputBox("Digite o nome do item: ")
        nQuant := Val(FWInputBox("Digite a quantidade do item " + cNome))
        nValor := Val(FWInputBox("Digite o valor unitário: "))
        nTotal += nQuant * nValor

        IF nQuant <=5
        nTotal :=nTotal - ( nTotal * (2/100))

        elseif nQuant >5 .and. nQuant <= 10
        nTotal := nTotal - ( nTotal * (3/100))
        
        elseif nQuant >10
        nTotal :=nTotal - ( nTotal * (5/100))

        ENDIF

    MSGINFO( "O total do item" + cNome + "é de: " + alltrim(str(nTotal)),"Fim" )

RETURN
