#include 'PROTHEUS.CH'

USER FUNCTION EXERC07()

    LOCAL nMaca  := 0
    LOCAL nTotal := 0

    nMaca := Val(FWInputBox("Digite a quantidade de maçãs compradas: "))

    if nMaca >= 0 .and. nMaca < 12
        nTotal := nMaca * 1.30
        FwAlertSuccess( "O valor final foi de: R$ " + ALLTRIM(STR(nTotal)), "Nota" )

    elseif nMaca > 12
        nTotal := nMaca * 1.00
        FwAlertSuccess( "O valor final foi de: R$ " + ALLTRIM(STR(nTotal)), "Nota" )

    ENDIF

RETURN
