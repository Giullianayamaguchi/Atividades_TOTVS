#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E15()

    local nNum := 0
    local nCount := 1
    local nI := 1
    local aFib := {}

    nNum := checaNum(nNum)

    aFib := calcFib(nNum)

    for nCount := 1 to nNum

        MSGALERT("Numero " + Alltrim(str(nI)) + " da sequencia Fibonacci: " + Alltrim(str(aFib[nI])))

        nI++

    next nCount

RETURN NIL

static function checaNum(nNum)

    local nVal := 0
    local lVal := .T.

    while lVal

        nNum := Val(FwinputBox( "Digite um numero a ser fatorado: "))
        nNum := ABS(nNum)

        nVal := ROUND(nNum, 0)

        if nNum <> nVal

            
            MSGALERT( "Digite um numero inteiro!", "erro")
            
            loop

        else
            
            lVal := .F.

        endif

    enddo

return nVal


static function calcFib(nNum)

    local nCount := 1
    local nFib := 2
    local nI := 2
    local aDado := {0, 1}

    for nCount := 1 to nNum

        nFib := aDado[nI] + aDado[nCount]
        Aadd(aDado, nFib)

        nI++

    next nCount

return aDado
