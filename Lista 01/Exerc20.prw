#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC20()

    LOCAL nCont:= 10
    LOCAL cArmazena := ""

    for nCont := 100 to 110
        cArmazena += cValtoChar(nCont) + CRLF 
    next 

    FwAlertInfo(cArmazena, 'Resultado') 
  
 Return
