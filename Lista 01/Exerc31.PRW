#INCLUDE 'PROTHEUS.CH'

USER FUNCTION EXERC31()
    lOCAL aArray1 := ARRAY(10)
    LOCAL nCont := 0
    LOCAL cArmazena :=""

    for nCont :=1 to 10 
        aArray1[nCont] := Val(fwinputbox("Digite um numero: "))

    NEXT

    for nCont := 1 TO 10 
        ASORT(aArray1 , 1, 10)
        cArmazena += alltrim(str(aArray1[nCont])) + CRLF
    NEXT

    fwalertsucess(cArmazena)



RETURN
