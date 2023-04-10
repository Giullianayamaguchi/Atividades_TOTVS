#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC21()

    LOCAL nCont:= 1
    LOCAL cArmazena := ""
    LOCAL nCo  := 0

    nCo := val(fwinputbox("Digite a quantidade de numeros: ", "a partir de 1"))

    for nCont := 1 to nCo
        cArmazena += cValtoChar(nCont) + CRLF 
    next 

    FwAlertInfo(cArmazena, 'Resultado') 
  
 Return
