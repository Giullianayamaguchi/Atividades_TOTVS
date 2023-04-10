#include "protheus.ch"

USER FUNCTION EXERC37()
    LOCAL nCont := 0
    LOCAL nDesc := 0
    Local nComp := 0

    nComp := Val(FWInputbox("Digite o valor: "))

    IF nComp >= 500
    nCont := nComp - 400
    nCont:= nCont /100

    nDesc := nComp-(nCont * nComp)/100 
     
    ENDIF
    FWAlertSucess("Valor do item: " + ALLTRIM(STR(nComp)) + CRLF + "Valor desconto: " + Alltrim(str(nCont)) + "%"+ CRLF + "Valor final: " + Alltrim(str(nDesc)))
RETURN
