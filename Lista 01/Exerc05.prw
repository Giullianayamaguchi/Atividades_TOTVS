#include 'protheus.ch'

USER FUNCTION EXERC05()

    lOCAL nFabric := 0
    LOCAL ndistri := 28
    LOCAL nImpost := 45
    LOCAL nFinal  := 0

    nFabric := Val(FWInputbox("Digite o valor de f�rica: "))
    nFinal := (nFabric+((nFabric*ndistri/100) + (nFabric*nImpost/100)))

    MSGALERT( "o Valor final do ve�culo �: " + ALLTRIM(STR(nFinal)), "Resultado" )


RETURN
