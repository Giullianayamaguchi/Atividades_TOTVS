#INCLUDE 'TOTVS.CH'

User Function L3_E18()
  Local cNome := ""
  Local nNum  := 0
  Local cMsg := ""

  cNome := FwInputBox("Informe seu nome: ")

  For nNum := 1 to Len(cNome)
    cMsg+=SUBSTR(cNome, 1, nNum)+CRLF
  Next

  MsgInfo(cMsg, "Nome em escada")

Return
