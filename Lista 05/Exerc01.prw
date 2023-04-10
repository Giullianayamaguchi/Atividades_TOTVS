#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E1()

    LOCAL aDia := { 'domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sabado'}
    LOCAL nCont := 0
    LOCAL nDia := 0
    nDia :=vAL(FwInputBox("Digite um dia da semana: "))

    for nCont := 1 TO LEN(aDia)
        if nDia == nCont
            FwAlertSucess("o Dia escolhido foi: " + aDia[nCont])
        ENDIF
    next
RETURN
