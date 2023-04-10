#INCLUDE 'TOTVS.CH'

User Function L3_E19()
  Local cFrase := ""
  Local nEspaço:= 0
  Local nA := 0
  Local nE := 0
  Local nI := 0
  Local nO := 0
  Local nU := 0
  Local nCel := 0

  cFrase := Upper(FwInputBox("Escreva uma frase: "))

  For nCel := 1 to Len(cFrase)
    If ASC(Substr(cFrase, ncel, 1)) == 32
      nEspaço++
    EndIf 

    If Substr(cFrase, nCel, 1) == "A"
      nA++
    EndIf

    IF Substr(cFrase, nCel, 1) == "E"
      nE++
    EndIf

    IF Substr(cFrase, nCel, 1) == "I"
      nI++
    EndIf

    IF Substr(cFrase, nCel, 1) == "O"
      nO++
    EndIf

    IF Substr(cFrase, nCel, 1) == "U"
      nU++
    ENDIF
  NEXT

  FwAlertInfo(Str(nEspaço) + " espaços, "+CRLF+Str(nA) + " vogais A; "+CRLF+Str(nE) + " vogais E; "+CRLF+Str(nI) + " vogais I; "+CRLF+Str(nO) + " vogais O; "+CRLF+Str(nU) + " vogais U; "+CRLF,"A frase digitada possui: ")

Return
