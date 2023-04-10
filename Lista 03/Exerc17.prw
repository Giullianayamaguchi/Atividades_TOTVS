#INCLUDE 'TOTVS.CH'

User Function L3_E17()
  Local cNome := ""
  Local nNum  := 0
  Local cMsg := ""

  cNome := FwInputBox("Informe seu nome: ")

  For nNum := 1 to Len(cNome)
    cMsg+=SUBSTR(cNome, nNum, 1)+CRLF
  Next
MsgInfo(cMsg, "Seu Nome na Vertical!")

Return
