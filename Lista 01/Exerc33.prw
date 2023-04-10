#include "protheus.ch"

USER FUNCTION EXERC33()
    Local aNumeros [20]
    Local nCont := 0
    LOCAL nCon := 0
    Local cComp := ''

    for nCont := 1 to 20
        aNumeros[nCont] := FWInputBox('Insira o ' +alltrim(str(nCont)) + '� n�mero para o array: ') 
    next

    for nCont := 1 to 20
        for nCon := nCont + 1 to 20
            if aNumeros[nCont] == aNumeros[nCon]          
                cComp += 'O n�mero ' + aNumeros[nCont] + ' se encontra nas posi��es ' + ALLTRIM(STR(nCont)) + ' e '+ ALLTRIM(STR(nCon)) + CRLF
            endif
        next
    next

    MSGINFO(cComp)

RETURN
