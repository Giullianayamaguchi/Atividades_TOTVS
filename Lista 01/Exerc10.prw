#include 'protheus.ch'

USER FUNCTION EXERC10()

    Local nPrimeiro:= 0
    Local nSegundo := 0
    Local nTerceiro:= 0

    nPrimeiro := VAL(FwInputBox('Digite o primeiro valor: ')) 
    nSegundo  := VAL(FwInputBox('Digite o segundo valor: ')) 
    nTerceiro := VAL(FwInputBox('Digite o terceiro valor: '))

    if nPrimeiro < nSegundo  .and. nPrimeiro < nTerceiro
        if nSegundo  < nTerceiro
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nPrimeiro)) + ', ' + ALLTRIM(STR(nSegundo)) + ' e ' + ALLTRIM(STR(nTerceiro)), 'Resultado') // Exibindo o resultado
        else
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nPrimeiro)) + ', ' + ALLTRIM(STR(nTerceiro)) + ' e ' + ALLTRIM(STR(nSegundo)), 'Resultado') // Exibindo o resultado
        endif

    elseif nSegundo < nPrimeiro .and. nSegundo < nTerceiro 
        if nPrimeiro < nTerceiro
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nSegundo)) + ', ' + ALLTRIM(STR(nPrimeiro)) + ' e ' + ALLTRIM(STR(nTerceiro)), 'Resultado') // Exibindo o resultado
        else
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nSegundo)) + ', ' + ALLTRIM(STR(nTerceiro)) + ' e ' + ALLTRIM(STR(nPrimeiro)), 'Resultado') // Exibindo o resultado
        endif
    
    else
        if nPrimeiro < nSegundo                           
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nTerceiro)) + ', ' + ALLTRIM(STR(nPrimeiro)) + ' e ' + ALLTRIM(STR(nSegundo)), 'Resultado') // Exibindo o resultado
        else
            FwAlertInfo('A ordem crescente é: ' + ALLTRIM(STR(nTerceiro)) + ', ' + ALLTRIM(STR(nSegundo)) + ' e ' + ALLTRIM(STR(nPrimeiro)), 'Resultado') // Exibindo o resultado
        endif 
    endif

RETURN
