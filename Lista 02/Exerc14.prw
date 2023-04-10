#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E14()

    Local nCont  :=0
    Local nValor :=0
    Local nLim   :=0
    Local cTipo  :=""

    nLim := Val(FwInputBox( "Digite a quantidade de numeros: " ))
    cTipo := FwInputBox( "Digite se gostaria de fazer a conta com: ", "número impares (I) ou pares (P)" )
    cTipo = UPPER(cTipo)

    for nCont := 1 to nLim

        if cTipo =="P" .and. (nCont % 2) ==0
            nValor := nValor + nCont
           

        elseif cTipo =="I" .and. (nCont % 2) !=0
            nValor := nValor + nCont
            
        ENDIF
    end
    MSGINFO( alltrim(str(nValor)) )

RETURN
