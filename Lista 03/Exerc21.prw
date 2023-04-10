#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function L321()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ""
    Local cGat := ""
    Local cGrp := ""

    rpcsetenv("99", "01")

    cQuery := "SELECT *" + "FROM " + RetSqlName('SB1') + " WHERE " + " B1_ZZGRP = ''"

    TCQUERY cQuery ALIAS &(cAlias) NEW

      &(cAlias)->(DbGoTop())
      DbSelectArea("SB1")
      DbSetOrder(2)

      While &(cAlias)->(!EOF())
        cGrp := &(cAlias)->(B1_TIPO)

        If cGrp == "PA"
          cGat := "PRODUTO PARA COMERCIALIZACAO"

        Elseif cGrp == "MP"
          cGat := "MATERIA PRIMA PRODUCAO"

        Else
          cGat := "OUTROS PRODUTOS"
        endif

        If DbSeek(&(cAlias)->(B1_Filial) + &(cAlias)->(B1_COD))
          RecLock("SB1", .F.)
          SB1->B1_ZZGRP := cGat
        MsUnlock()
      endif

        &(cAlias)->(DbSKIP())
      End Do

      &(cAlias)->(DbCloseArea())
      RestArea(aArea)

    Return
