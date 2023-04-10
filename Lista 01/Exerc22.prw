#include 'protheus.ch'

USER FUNCTION EXERC22()
    LOCAL nCont :=0
    LOCAL nMult := 0
    LOCAL nNum  := 0
    LOCAL cArmazena :=""

    nNum := val(fwinputbox("Digite um número", " de 1 a 10"))
    
    while nNum<1 .or. nNum>10
        FwAlertInfo("o número deve ser entre 1 e 10, tente novamente")
        LOOP
    ENDDO

    for nCont:= 0 to 10
        nMult := nCont * nNum
    
        cArmazena += cValtoChar(nCont) + " * " + cValtoChar( nNum ) + " = " + cValtoChar(nMult) + CRLF 
    Next   

    FwAlertSucess(cArmazena, "Resultado")
RETURN
