#include 'protheus.ch'

USER FUNCTION EXERC23()
    LOCAL nCont := 0
    LOCAL nNum  := 0
    LOCAL nPos  := 0
    LOCAL nNeg  := 0
    LOCAL cArmazena := ""
    
    while nCont <10

        nNum :=  Val(fwinputbox("Digite um número: "))

        if nNum <0
            nNeg++

        elseif nNum >0
            nPos++
        ENDIF

        nCont++
    ENDDO
    cArmazena += "Positivo: " + cValtoChar(nPos) + CRLF + "Negativo: " + cValtoChar(nNeg)
    FwAlertSucess(cArmazena, "Resultado")
RETURN
