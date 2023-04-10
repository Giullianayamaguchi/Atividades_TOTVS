#INCLUDE 'protheus.ch'

user Function L1_Desafio1()
    Local nNum   := 0
    Local nChute := 0

    nNum := RANDOMIZE( 0, 100 )

    nChute := Val(FwInputBox("Digite um chute: "))

    if nChute > nNum
        MSGALERT( "Numero inserido é maior que o sorteado")
    elseif nChute < nNum
         MSGALERT( "Numero inserido é menor que o sorteado")
    elseif nChute == nNum
         MSGALERT( "Numero inserido é igual que o sorteado")
    ENDIF
RETURN
