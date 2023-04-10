#include 'protheus.ch'

USER FUNCTION EXERC12()
    LOCAL aTim1  := {"",0 }
    LOCAL aTim2  := {"",0 }
    LOCAL nOpcao := 1

    aTim1[1] := FWInputBox("Digite o nome do 1º time: ")
    aTim2[1] := FWInputBox("Digite o nome do 2º time: ")

    while nOpcao <> 0
        MSGINFO("Para adicionar um gol ao time " + aTim1[1] + " Digite 1" + CRLF +"Para adicionar um gol ao time " + aTim2[1] + " Digite 2" + CRLF + "Para parar a contagem, Digite: 0")
        nOpcao := Val(FWInputBox("Digite a opção"))
        
        Do case 
            case nOpcao == 0
            
                exit

            case nOpcao == 1

                aTim1[2] := aTim1[2] + 1

            case nOpcao == 2 
                aTim2[2] := aTim2[2] + 1

            OTHERWISE   
                MSGALERT( "Opção incorreta, tente novamente")
                LOOP
        ENDCASE

        MSGALERT( "time " + aTim1[1] + " Com " + str(aTim1[2]) + " gols", "Placar" )
        MSGALERT( "time " + aTim2[1] + " Com " + str(aTim2[2]) + " gols", "Placar" )


    ENDDO
        if aTim1[2] > aTim2[2]
            FWAlertSucess("Time " + ALLTRIM(aTim1[1]) + " Ganhou")

        elseif aTim2[2] > aTim1[2]
             FWAlertSucess("Time " + ALLTRIM(aTim2[1]) + " Ganhou")

        else
             FWAlertSucess("o Time " + ALLTRIM(aTim1[1]) + " e " +  ALLTRIM(aTim2[1]) + " empataram")

        ENDif
            

RETURN
