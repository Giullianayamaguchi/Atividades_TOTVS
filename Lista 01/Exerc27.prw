#include 'protheus.ch'

USER FUNCTION EXERC27()
    LOCAL nCont := 1
    LOCAL aNum  := [1 2 3 4 5 6 7 8 9 10]
    LOCAL cArmazena := ""
    
    while nCont <=10

        cArmazena += cValtoChar(nCont) +" , " + cValtoChar(aNum) + CRLF
        nCont++
    ENDDO
    FwAlertSucess(cArmazena, "Resultado")
RETURN
