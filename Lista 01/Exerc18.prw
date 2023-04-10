#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC18()

    LOCAL nCont:= 0 
    LOCAL cArmazena := ""
    
    for nCont := 1 to 10
        cArmazena += cValtoChar(nCont) + CRLF 
    next 

    FwAlertInfo(cArmazena, 'Resultado') 
  
 Return
