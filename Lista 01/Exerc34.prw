#include 'PROTHEUS.CH'

USER FUNCTION EXERC34()
    LOCAL nIdade := 0
    LOCAL nCont  := 0
    LOCAL aPeso  := ARRAY(2)
    LOCAL nCon   := 0

    for nCont := 1 to 2
        nIdade += val(FWInputBox("Digite a idade"))
        aPeso[nCont]  := Val(FWInputBox("Digite o peso"))
    NEXT
    nIdade := nIdade/2

    for nCont := 1 to 2
        if aPeso[nCont] > 90 
            nCon++
        endif
    next

    FWAlertSucess("A quantidade de pessoas com mais de 90 kilos é de: " + alltrim(str(nCon)))
    FWAlertSucess("a média das idades é: " + alltrim(str(nIdade)))

RETURN
