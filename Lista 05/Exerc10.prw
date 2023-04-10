/*–Ler dois arrays: A com 10 elementos e B com 15
elementos. Construir um array C, sendo este, a
junção dos outros dois arrays. Desta forma, C
deverá ter a capacidade de armazenar 25
elementos. Apresentar o array C. */


#INCLUDE 'PROTHEUS.CH'

User Function L5_E10()

    Local aA := {}
    Local aB := {}
    Local aC := {}
    Local nCont := 0
    Local cMsg  := ''

    for nCont := 1 TO 10
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        AADD( aA, nNum)
        AADD(aC, (aA[nCont]))
    Next

    for nCont := 1 TO 15
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 2 array:  "))
        AADD(aB, nNum)
        AADD(aC, (aB[nCont]))
    Next

    
    For nCont := 1 to 25
        cMsg += 'Numero: ' + ALLTRIM(STR(aC[nCont])) +CRLF
    Next 

    FwAlertInfo(cMsg)

Return


RETURN
