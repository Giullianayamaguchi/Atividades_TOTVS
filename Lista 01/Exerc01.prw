#include 'protheus.ch'

USER FUNCTION EXERC01()

    Local nNum := 0

    nNum := Val(FWInputbox("Digite um número: ", ""))

    MsgAlert("O antesessor de: " + ALLTRIM(STR(nNum)) + " é: " + ALLTRIM(STR(nNum -1)), "Resultado")

RETURN
