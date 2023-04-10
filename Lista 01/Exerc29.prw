#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC29()

    lOCAL aArray1 := ARRAY(10)
    LOCAL aArray2 := ARRAY(10)
    LOCAL nNum    := 0
    LOCAL nCont   := 0
    LOCAL cArmazena :=""

    for nCont :=1 to 10 
        aArray1[nCont] := Val(fwinputbox("Digite um numero: "))

        
    NEXT
    
    nNum := Val(fwinputbox("Digite um número para multiplicar: "))

    for nCont :=1 to 10    
        aArray2[nCont] := nNum * aArray1[nCont]
        cArmazena += alltrim(str(aArray2[nCont])) + CRLF
    NEXT

    fwalertsucess(cArmazena)

RETURN
