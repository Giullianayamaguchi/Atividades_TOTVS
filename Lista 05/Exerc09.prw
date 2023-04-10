/* 9 – Ler 8 elementos em um array A tipo vetor.
Construir um array B de mesma dimensão onde cada
elemento é o triplo do elemento correspondente
do array A.*/


#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E9()

    LOCAL aNum  := {}
    LOCAL aNum2 := {}
    Local nCont := 0
    LOCAL nNum  := 0 
    LOCAL cMsg  := ''


    for nCont := 1 to 8
        nNum :=VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        AADD(aNum, nNum)
    NEXT

    for nCont := 1 to 8
        nNum := aNum[nCont] * 3
        aadd(aNum2, nNum)

        cMsg += 'Numero: ' + ALLTRIM(STR(aNum2[nCont])) +CRLF
    NEXT
    FWAlertSucess(cMsg)

RETURN
