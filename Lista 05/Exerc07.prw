/* 7 – Ler um array A de 15 elementos e a partir dele
construir um array B de mesmo tamanho, sendo o
inverso de A, ou seja, o primeiro elemento de B
deverá receber o último de A o segundo de B
deverá receber o penúltimo de A e assim por
diante.*/


#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E7()

    LOCAL aNum  := {}
    LOCAL aNum2 := {}
    Local nCont := 0
    LOCAL nNum  := 0 
    LOCAL cMsg  := ''


    for nCont := 1 to 5
        nNum :=VAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        AADD(aNum, nNum)
    NEXT

    for nCont := 5 to 1 step -1
        nNum := aNum[nCont]
        aadd(aNum2, nNum)

        cMsg += alltrim(str(aNum2[nCont]))
    NEXT
    fWAlertSucess(cMsg)

RETURN
