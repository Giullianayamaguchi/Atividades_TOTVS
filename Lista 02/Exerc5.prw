#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L1_E5()
    LOCAL nConta := 0
    LOCAL nDolar := 0
    LOCAL nConver:= 0

    nConta := Val(FWInputbox("Digite o valor da Cotação do dolar atualmente"))
    nDolar := Val(FWInputbox("Digite a quantidade do dólar: "))

    nConver := nConta * nDolar
    FwAlertSucess("O valor convertido foi de: " + alltrim(str(nConver)))

RETURN
