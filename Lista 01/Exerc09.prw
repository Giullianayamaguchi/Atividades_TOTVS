#include 'protheus.ch'

USER FUNCTION EXERC09()
    LOCAL nNum

    nNum := FWInputBox("Digite um número: ")

    if Val(nNum) > 0
        MSGALERT("numero positivo ")

    elseif Val(nNum) <0
        MSGALERT("numero negativo ") 
    
    elseif Val(nNum) = 0
        MSGALERT( "Numero 0" )
        
    else 
        MSGALERT( "valor incorreto")
    ENDIF


RETURN
