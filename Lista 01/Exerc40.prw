
#INCLUDE "PROTHEUS.CH"
User Function EXERC40() 
    
    Local nSalarioBruto:= 0
    Local nIR:= 0
    Local nINSS:= 0
    Local nFGTS:= 0
    Local nTotalDescontos:= 0
    Local nSalarioLiquido:= 0 
    Local nHora := 0
    Local nQtdHoras := 0
    Local cIR := ''

    nHora      := VAL(FWInputBox('Informe o valor da hora: '))
    nQtdHoras  := VAL(FWInputBox('Informe a quantidade de horas: '))

    nSalarioBruto := nHora*nQtdHoras 

    if nSalarioBruto > 1200 .and. nSalarioBruto <= 1800  
        nIR := 0.05 * nSalarioBruto
        cIR := '5%'
    elseif nSalarioBruto > 1800 .and. nSalarioBruto <= 2500 
        nIR := 0.10 * nSalarioBruto 
        cIR := '10%'
    elseif nSalarioBruto > 2500 
        nIR := 0.20 * nSalarioBruto 
        cIR := '20%'
    else
        FwAlertInfo('O valor informado não tem desconto IR!')
        nIR := 1 * nSalarioBruto
    endif

    nINSS := 0.10 * nSalarioBruto 
    nFGTS := 0.11 * nSalarioBruto 
    nTotalDescontos := nIR + nINSS
    nSalarioLiquido := nSalarioBruto-nTotalDescontos 

    FwAlertInfo('Salário bruto (' + ALLTRIM(STR(nHora)) + '*' + ALLTRIM(STR(nQtdHoras)) + ')_______: R$ ' + ALLTRIM(StrZero(nSalarioBruto,7,2))+CRLF+;
                '( – ) IR ('+ALLTRIM(cIR)+')_______________: R$ '+ALLTRIM(StrZero(nIR,5,2))+CRLF+;
                '( – ) INSS (10%)____________: R$ '+ALLTRIM(StrZero(nINSS,6,2))+CRLF+;
                'FGTS (11%)_______________: R$ '+ALLTRIM(StrZero(nFGTS,6,2))+CRLF+;
                'Total de descontos__________: R$ '+ALLTRIM(StrZero(nTotalDescontos,6,2))+CRLF+;
                'Salário Líquido_____________: R$ '+ALLTRIM(StrZero(nSalarioLiquido,7,2)))


Return
