#INCLUDE 'protheus.ch'

user Function L2_Desafio2()
    Local nNum   := 0
    Local nChute := 0
    Local nCont  := 0
    Local nTent  := 0

    nNum := RANDOMIZE( 0, 100 )

    while nCont != 00
        nChute := Val(FwInputBox("Digite um chute ou 00 para parar o programa: "))

        if nChute > nNum
            MSGALERT( "Numero inserido � maior que o sorteado")
            nTent++
        elseif nChute < nNum
            MSGALERT( "Numero inserido � menor que o sorteado")
            nTent++
        elseif nChute == nNum
            MSGALERT( "Numero inserido � igual que o sorteado")
            if nTent < 5
                MSGALERT( "Voc� � muito bom, acertou em " + alltrim(str(nTent)) + "tentativas.")
            elseif nTent > 5 .and. nTent <9
                MSGALERT( "Voc� � bom, acertou em" + alltrim(str(nTent)) + "tentativas")
            elseif nTent > 9 .and. nTent <13
                MSGALERT( "Voc� � mediano, acertou em " + alltrim(str(nTent)) + "tentativas")
            elseif nTent >13
                MSGALERT( "Voc� � muito fraco, acertou em "+ alltrim(str(nTent)) +" tentativas")
            
            ENDIF
        ENDIF
    ENDDO

RETURN
