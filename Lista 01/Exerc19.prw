#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC19()

    LOCAL nCont:= 10
    LOCAL cArmazena := ""

    for nCont := 10 to 1 STEP -1
        cArmazena += cValtoChar(nCont) + CRLF 
    next 

    FwAlertInfo(cArmazena, 'Resultado') 
  
 Return
