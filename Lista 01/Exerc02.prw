#include 'TOTVS.CH'

USER FUNCTION EXERC02()
    lOCAL nBase := 0
    LOCAL nAlt  := 0
    LOCAL nArea := 0

    nBase := Val(FWInputbox("Digite a base: "))
    nAlt  := Val(FWInputbox("Digite a altura: "))

    nArea := nBase * nAlt

    FwAlertSuccess( "A �rea do retangulo informado � de: " + ALLTRIM(STR(nArea)) + " cm", "Resutlado")

RETURN
