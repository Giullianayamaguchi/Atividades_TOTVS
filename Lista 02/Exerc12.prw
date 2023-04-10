#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E12()

    Local nMult := 0
    Local cMsg  := ''

    for nMult := 1 to 100
        if nMult % 3 == 0
            
            cMsg += ALLTRIM(STR(nMult) )+ " "
        ENDIF

    NEXT

    MSGALERT(cMsg )
RETURN 
