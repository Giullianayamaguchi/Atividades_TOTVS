#INCLUDE "PROTHEUS.CH"

USER FUNCTION L1_E1()
    LOCAL nNum1 := 0
    LOCAL nNum2 := 0
    LOCAL nSoma := 0
    LOCAL nDif  := 0
    LOCAL nProd := 0
    LOCAL nQuo  := 0


    nNum1 := Val(FWInputbox("Digite o 1° número"))
    nNum2 := Val(FWInputbox("Digite o 2° número"))

    if nNum1 > 0 .and. nNum2 > 0
        nSoma := nNum1 + nNum2
        nDif  := nNum1 - nNum2
        nProd := nNum1 * nNum2
        nQuo  := nNum1 / nNum2
        
        FWAlertSucess ("soma: " + alltrim(str(nSoma)) + CRLF +;
                       "diferença: " + alltrim(str(nDif)) + CRLF+;
                       "Produto: " + alltrim(str(nProd)) + CRLF +;
                       "quociente: " + alltrim(str(noRound(nQuo,2))) + CRLF )
    else 
        MSGALERT( "Valor incorreto, Favor tentar novamente ", "erro" )
    ENDIF

RETURN
