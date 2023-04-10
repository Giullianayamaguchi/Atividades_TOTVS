/* 8 – Fazer um programa que carregue um array de 8
elementos e que inverta a ordem do seu conteúdo.
Apresente no final o array invertido.
Obs: Usar apenas um array.*/

#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E8()
    LOCAL aNum  := {}
    LOCAL nCont := 0
    LOCAL nNum  := 0
    LOCAL cMsg  := ''

    for nCont := 1 to 15
        nNum := VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        AADD(aNum, nNum)
        ASORT(aNum)
    NEXT

    FOR nCont := 15 to 1 step -1
        cMsg += 'Numero: ' + ALLTRIM(STR(aNum[nCont])) +CRLF

    NEXT
    FWAlertSucess(cMsg + " ")
RETURN
