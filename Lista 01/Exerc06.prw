#include 'PROTHEUS.CH'

USER fUNCTION EXERC06()
    LOCAL nFahren  := 0
    LOCAL nConver  := 0

    nFahren := Val(FWInputBox("Digite a temperatura em Fahrenheit"))
    nConver := (nFahren - 32) * 5/9

    MSGALERT( "A temperatura em Celsius é de: " + ALLTRIM(STR(nConver)), "Resultado" )
RETURN
