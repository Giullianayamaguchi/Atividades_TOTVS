#include 'protheus.ch'

USER FUNCTION EXERC038()
    LOCAL nCont := 0
    LOCAL nIdade  := 0
    LOCAL nInt  := 0
    LOCAL cArmazena := ""
    
    while nCont <10

        nIdade :=  Val(fwinputbox("Digite uma idade: "))

        if nIdade >=18
            nInt++

        ENDIF

        nCont++
    ENDDO
    cArmazena += "são : " + cValtoChar(nInt) + " pessoas com mais de 18 anos "
    FwAlertSucess(cArmazena, "Resultado")
RETURN
