/* 16 – Elaborar um programa que permita o usuário
digitar o NOME e 3 NOTAS de 4 alunos, esses dados,
assim como a MÉDIA de cada aluno, devem ser
armazenados em um único array. No final, exibir os
dados (Nome, Notas e Média) de cada aluno.*/

#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E16()

    LOCAL aNota  := {}
    LOCAL nNota1  := 0
    Local nMedia := 0
    Local nNota2  := 0
    LOCAL nNota3 := 0
    LOCAL cNome  := ''
    LOCAL nCont  := 0

    for nCont := 1 to 1
        cNome := FwInputBox("Digite o nome do aluno: ")
        nNota1 := Val(FwInputBox("Digite a primeira nota: "))
        nNota2 := Val(FwInputBox("Digite a segunda nota: "))
        nNota3 := Val(FwInputBox("Digite a terceira nota: "))

        nMedia := (nNota1 + nNota2 + nNota3) / 3

        aadd(aNota,{ cNome, nNota1, nNota2, nNota3, nMedia} )

    NEXT
    
    for nCont := 1 TO LEN(aNota)
        FWAlertSucess("O aluno: " + alltrim(aNota[nCont,1]) + "obteve as seguintes notas: " + CRLF+;
        "Nota 1:  " +  alltrim(str(aNota[nCont,2])) + CRLF +;
        "Nota 2:  " +  alltrim(str(aNota[nCont,3])) + CRLF +;
        "Nota 3:  " +  alltrim(str(aNota[nCont,4])) + CRLF +;
        "MEDIA:   " +  alltrim(str(aNota[nCont,5])) + CRLF)

    NEXT
RETURN
