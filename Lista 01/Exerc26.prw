#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC26()

    LOCAL nCont:= 15
    LOCAL nArmazena := 0

    nTabu := val(fwinputbox("Digite a tabuada: ", "de 1 a 10"))

        for nCont := 15 to 100

            nArmazena += ( nCont) 
            nCont++
        next 
        
        nArmazena:= nArmazena/2
    FwAlertInfo(str(nArmazena), 'Resultado')
  
 Return
