/* 12 - Ler um array A com 5 elementos. Construir um
array B com a mesma dimensão, onde cada elemento
do array B deverá ser o valor inverso (sinal
trocado) do elemento correspondente do array A.
Apresentar os elementos do array B.*/


#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E12()

    LOCAL aNum  := {}
    LOCAL aNum2 := {}
    Local nCont := 0
    LOCAL nNum  := 0 
    LOCAL cMsg  := ''


    for nCont := 1 to 5
        nNum :=VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do array:  "))
        AADD(aNum, nNum)
    NEXT

    for nCont := 1 to 5
        nNum := aNum[nCont] * -1
        aadd(aNum2, nNum)

        cMsg += 'Numero: ' + ALLTRIM(STR(aNum2[nCont])) +CRLF
    NEXT
    FWAlertSucess(cMsg)

RETURN
