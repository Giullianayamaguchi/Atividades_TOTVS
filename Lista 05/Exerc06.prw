#INCLUDE 'TOTVS.CH'

/*� 6 � Ler dois arrays, A e B de 10 elementos cada e
calcular um array C onde seu primeiro elemento � o
primeiro elemento de A, seu segundo elemento � o
primeiro de B, seu terceiro elemento � o segundo
de A, e assim sucessivamente. Note que o array C
dever� ter 20 elementos. Exibir o conte�do do
array C.*/


User Function L5_E6()

    Local aA := {}
    Local aB := {}
    Local aC := {}
    Local nCont := 0
    Local cMsg  := ''

    for nCont := 1 TO 10
        nNum :=VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "� n�mero do 1 array:  "))
        AADD( aA, nNum)

        nNum := VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "� n�mero do 2 array:  "))
        AADD(aB, nNum)
    Next
    
    For nCont := 1 to 10
        AADD(aC, (aA[nCont]))
        AADD(aC, (aB[nCont]))
    Next
    
    For nCont := 1 to 20
        cMsg += 'Numero: ' + ALLTRIM(STR(aC[nCont])) +CRLF
    Next 

    FwAlertInfo(cMsg)

Return
