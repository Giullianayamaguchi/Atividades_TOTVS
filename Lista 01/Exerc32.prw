#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC32()
    LOCAL aARRAY1 [15]
    LOCAL aARRAY2 [15]
    LOCAL nCont := 0
    LOCAL nComp := 0

    MSGINFO( "Preenchendo 1� ARRAY" )

    for nCont := 1 to 15
        

        aArray1[nCont] := FWInputBox('Insira um n�mero para o primeiro array: ') 
        
    NEXT

    MSGINFO( "Preenchendo 2� ARRAY" )
    for nCont := 1 to 15
        

        aARRAY2[nCont] := FWInputBox('Insira um n�mero para o segundo array: ') 
        
    NEXT

    MSGINFO( "Comparando n�meros" )
    for nCont := 1 to 15
        
        if aArray1[nCont] == aArray2[nCont] 
            nComp += 1
        endif
    NEXT

    FwAlertSuccess('Os arrays possuem ' + ALLTRIM(STR(nComp)) + ' n�meros iguais nas mesmas posi��es.')

RETURN
