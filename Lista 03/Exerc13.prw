#INCLUDE 'TOTVS.CH'

User Function Jsl3e13()
  Local cDia := ""
  Local nNum := 0
  Local aSemana := {"Domingo", "Segunda", "Ter�a", "Quarta", "Quinta", "Sexta", "S�bado"}

    while nNum <= 0 .or. nNum > 7

        nNum := Val(FwInputBox("Por favor informe um n�mero de 1 a 7: "))

        If nNum < 1 .or. nNum > 7
            MsgAlert("N�mero inv�lido!, Favor tetnar novamente ")
            LOOP 
        EndIf
       End

    cDia := cValtoChar(aSemana[nNum])

      FwAlertInfo("O dia da semana relacionado ao n�mero informado �: " + cDia )
Return
