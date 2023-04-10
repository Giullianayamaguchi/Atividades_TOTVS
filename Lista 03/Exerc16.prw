#INCLUDE 'TOTVS.CH'

User Function L3_E16()
  Local cNome := ""
  Local nNum  := 0
  Local cMsg := ""

  cNome := FwInputBox("Informe seu nome: ")

  For nNum := Len(cNome) to 1 step -1
    cMsg+=SUBSTR(cNome, nNum, 1)
  Next

  MsgInfo(cMsg, "Seu Nome de trás pra frente!")

Return
