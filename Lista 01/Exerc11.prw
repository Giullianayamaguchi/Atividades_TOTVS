#include 'protheus.ch'

USER FUNCTION Exerc11()

    Local nA:= 0
    Local nB := 0
    Local nC:= 0
    
    nA := VAL(FwInputBox('Digite o primeiro valor: ')) 
    nB := VAL(FwInputBox('Digite o segundo valor: ')) 
    nC := VAL(FwInputBox('Digite o terceiro valor: '))

    if (nA + nB > nC) .and. (nA + nC > nB) .and. (nB + nC > nA) 
        FwAlertSuccess('Os lados formam um triângulo!', 'Forma triângulo') 

    else
        FWAlertError('Os lados NÃO formam um triângulo!', 'Forma triângulo') 
    endif

Return



RETURN
