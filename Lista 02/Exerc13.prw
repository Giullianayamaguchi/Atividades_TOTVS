#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E13()

    Local nMult := 0
    Local cMsg  := ''
    Local nLim  := 0
    Local nDiv  := 0

    nLim := Val(FwInputBox("Digite o limite: "))
    nDiv := Val(FwInputBox("Digite o valor que de ver multiplo"))
    for nMult := 1 to nLim
        if nMult % nDiv == 0
            
            cMsg += ALLTRIM(STR(nMult) )+ " "
        ENDIF

    NEXT

    MSGALERT(cMsg )
RETURN 
