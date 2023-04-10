#INCLUDE 'TOTVS.CH'

USER FUNCTION EXERC03()
 
    Local nAnos:= 0
    Local nMeses := 0
    Local nDias:= 0
    Local nDias_Totais:=0

    
    nAnos  := FwInputBox('Informe a sua idade em anos: ') 
    nMeses := FwInputBox('Informe a quantidade de meses da sua idade: ') 
    nDias  := FwInputBox('Informe a quantidade de dias da sua idade: ') 

    nDias_Totais := VAL(nAnos)*365 + VAL(nMeses)*30 + VAL(nDias) 
    
    FwAlertInfo('A sua idade total em dias é: ' + ALLTRIM(STR(nDias_Totais)), 'Idade total em dias')

Return

RETURN
