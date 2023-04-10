#INCLUDE 'TOTVS.CH'

User Function L3_E29()

  Local cGat := "", cGrp := M->B1_TIPO

  Do Case
  Case cGrp == "MP"
    cGat := "MATERIA PRIMA PRODUCAO"

  Case cGrp == "PA"
    cGat := "PRODUTO PARA COMERCIALIZACAO"

  Otherwise
    cGat := "OUTROS PRODUTOS"

  EndCASE

Return cGat
