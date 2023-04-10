/* • 11 - Ler um array A com 10 elementos. Construir um
array B com a mesma dimensão, sendo que cada
elemento de B seja o somatório do primeiro até o
elemento correspondente de A. Apresentar os
elementos do array B.*/

#INCLUDE 'TOTVS.CH'


User Function L5_E11()

    Local aA := {}
    Local aB := {}
    Local nCont := 0
    LOCAL nSoma := 0
    Local cMsg  := ''

    for nCont := 1 TO 10
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        AADD( aA, nNum)
        nSoma += nNum
        AADD( aB, nSoma)
    Next
    
    For nCont := 1 to 10
        cMsg += 'Numero: ' + ALLTRIM(STR(aB[nCont])) +CRLF
    Next 

    FwAlertInfo(cMsg)

Return
