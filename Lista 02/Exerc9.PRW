
#INCLUDE "PROTHEUS.CH"

USER Function L1_E9()
    
    Local nMes := 1

    nmes = FWINPUTBOX("Digite o número do mes: ", "DE 1 A 12")

    if(vAL(nMes) = 1) .or.(vAL(nMes) = 3) .or.(vAL(nMes) = 5).or.(vAL(nMes) = 7) .or.(vAL(nMes) = 8).or.(vAL(nMes) = 10).or.(vAL(nMes) = 12)
        MsgAlert(" o mes inserido tem 31 dias")
    elseif(vAL(nMes) = 2)
        MsgAlert(" o mes inserido tem 28 dias")
    
    elseif(vAL(nMes) = 4).or.(vAL(nMes) = 6).or.(vAL(nMes) = 9).or.(vAL(nMes) = 11)
        MsgAlert(" o mes inserido tem 30 dias")
    ENDIF


Return 
