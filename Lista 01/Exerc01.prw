#include 'protheus.ch'

USER FUNCTION EXERC01()

    Local nNum := 0

    nNum := Val(FWInputbox("Digite um n�mero: ", ""))

    MsgAlert("O antesessor de: " + ALLTRIM(STR(nNum)) + " �: " + ALLTRIM(STR(nNum -1)), "Resultado")

RETURN
