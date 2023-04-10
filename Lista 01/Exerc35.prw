#INCLUDE 'PROTHEUS.CH'
    
USER FUNCTION EXERC35()
    LOCAL nIdade := 0
    Local nCont  := 0
    LOCAL nId    := 0
    LOCAL nDig   := 1

    while nDig !=0

        nIdade += val(FWInputBox("Digite uma idade: "))
        nDig:= val(FWInputBox( "Parar de somar, digite 0. Cotinuar, digite 1"))
        nCont++
    ENDDO
    nId := nIdade/nCont

    FWAlertSucess("a média das idades é de: " + alltrim(str(nId)))

RETURN


RETURN
