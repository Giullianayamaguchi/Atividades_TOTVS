
#INCLUDE 'PROTHEUS.CH'

USER Function L1_E7()

    Local nInicio := 0 
    Local nFim := 0 
    Local ntempo

    nInicio = Val(FWINPUTBOX("Digite o horario que foi iniciado o jogo: ", "Colocar horário em formato 24 horas"))
    nFim    = Val(FWINPUTBOX("Digite o horário que foi fimalizado o jogo: ", ""))

    if(nInicio > nFim)
        ntempo := (nInicio - nFim) + 24
        MSGALERT( "O jogo durou: " + Alltrim(str(ntempo))+ "Horas" )
        
    else
        ntempo := (nInicio + nFim) + 24
        MSGALERT( "O jogo durou: " + Alltrim(str(ntempo))+ "Horas" )
    ENDIF


RETURN
