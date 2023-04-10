#include 'protheus.ch'

USER FUNCTION EXERC24()
    LOCAL nCont := 0
    LOCAL nNum  := 0
    LOCAL nInt  := 0
    LOCAL nFor  := 0
    LOCAL cArmazena := ""
    
    while nCont <10

        nNum :=  Val(fwinputbox("Digite um número: "))

        if nNum >=10 .and. nNum<=20
            nInt++

        elseif nNum >0
            nFor++
        ENDIF

        nCont++
    ENDDO
    cArmazena += "entre 10 e 20: " + cValtoChar(nInt) + CRLF + "fora do intevalo: " + cValtoChar(nFor)
    FwAlertSucess(cArmazena, "Resultado")
RETURN
