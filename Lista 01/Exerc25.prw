#include 'protheus.ch'

USER FUNCTION EXERC25()
    LOCAL nCont := 0
    LOCAL nNum  := 0
    LOCAL nSoma := 0
    LOCAL cArmazena := ""
    
    while nCont <10

        nNum :=  Val(fwinputbox("Digite um n�mero: "))

        nSoma += nNum 

        nCont++
    ENDDO
    cArmazena += "a Soma � de: " + cValtoChar(nSoma)
    FwAlertSucess(cArmazena, "Resultado")
RETURN
