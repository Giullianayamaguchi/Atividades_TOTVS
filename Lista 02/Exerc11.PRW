#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E11()
    
    Local nI := 0
    Local nValor := 0
    Local cMsg := ""
    
    MSGINFO("--- Para ---" )

    for nI := 1 TO 50
        nValor := RANDOMIZE( 10, 99 )

            cMsg += strZero(nValor,3) + " "

    NEXT

    FwAlertSucess("Numeros: " + cMsg)

    nI :=1
    nValor := 0

    MSGINFO("--- Enquanto ---")
    while (nI <= 50)
        nValor := RANDOMIZE( 10, 99 )

        cMsg += strZero(nValor,3) + " "
        
        nI ++
    ENDDO
    
    FwAlertSucess("Numeros: " + cMsg)

RETURN NIL
