#Include 'protheus.ch'

USER FUNCTION EXERC14()
    Local nNum1 := 0
    Local nNum2 := 0
    Local nSoma := 0

    nNum1 := Val(FWInputBox("Digite o valor do 1� N�mero"))
    
    while nNum2 ==0
        nNum2 := Val(FWInputBox("Digite o valor do 2� N�mero"))
        fwalertinfo("Numero incorreto, favor adicionar novamente")
    
    ENDDO
    
    nSoma := nNum1 + nNum2

    MSGAlert("A soma deu: " + alltrim(str(nSoma)) , "Resultado" )

RETURN
