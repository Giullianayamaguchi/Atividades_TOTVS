#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function TRep4_2
	5.2 � Tamb�m na rotina de Pedidos de Compra,
	adicione um novo bot�o que possibilite gerar um
	relat�rio de todos os pedidos existentes
	juntamente com seus respectivos produtos com valor final do pedido
	(mesma ideia do exerc�cio 3)
	@type  Function
	@author Giulliana Yamaguchi
	@since 06/04/2023
	/*/
User Function TRep4_2()
	Local cAlias 	:= GetNextAlias()

	//? Instanciando a classe de impress�o.
	Local oReport	:= TReport():New('TREPORT', 'Relat�rio de Compras por Produto',,{|oReport| Imprima(oReport)}, 'Esse relat�rio imprimir� todos os cadastros de clientes',.F.,,,, .T., .T.)	
	
	//? Instanciando a 1� classe de sess�o
	Local oSection1	:= TRSection():New(oReport, 'Pedido',,,,,,,,,, .T.)
	Local oSection2 := TRSection():New(oSection1, 'Produtos',,,,,,,,,, .T.)
	Local oBreak

	Private cCodPed	    := ''
	Private cDtEmi	    := ''
	Private cCodForn    := ''
	Private cLjForn     := ''
	Private cCnPagam    := ''
	Private cCodProd    := ''
	Private cDescProd   := ''
	Private cQuantVend  := ''
	Private cValorUnit  := ''
	Private cValorTotal := ''


	//* ------------------------------------------------------- C�lulas da se��o 1 -------------------------------------------------------
	
	TRCell():New(oSection1, 'PRODUTO', cAlias, 'PEDIDO',, 12,, {|| AllTrim(cCodPed)}, 'CENTER', .T., 'CENTER',,,,,, .T.)

	TRCell():New(oSection1, 'PRODUTO', cAlias, 'DATA PEDIDO',, 12,, {|| AllTrim(cDtEmi)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection1, 'PRODUTO', cAlias, 'COD FORN',, 20,, {|| AllTrim(cCodForn)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection1, 'PRODUTO', cAlias, 'LOJA FORN',, 10,, {|| AllTrim(cLjForn)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection1, 'PRODUTO', cAlias, 'COND. PAGAM.',, 15,, {|| AllTrim(cCnPagam)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	

	//* ------------------------------------------------------- C�lulas da se��o 2 -------------------------------------------------------
	TRCell():New(oSection2, 'COD PROD', cAlias, 'COD PEDIDO',, 8,, {|| AllTrim(cCodProd)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection2, 'DESC PROD', cAlias, 'DESC PROD',, 20,, {|| AllTrim(cDescProd)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection2, 'QUANT', cAlias, 'QUANT',, 10,, {|| AllTrim(cQuantVend)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection2, 'VAL. UNIT.', cAlias, 'VAL. UNIT.',, 15,, {|| AllTrim(cValorUnit)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	TRCell():New(oSection2, 'VAL. TOTAL', cAlias, 'VAL. TOTAL',, 15,, {|| AllTrim(cValorTotal)}, 'CENTER', .T., 'CENTER',,,,,, .T.)

	//* ----------------------------------------------------------------------------------------------------------------------------------

		//* ----------------------------------------------------------------------------------------------------------------------------------
	oBreak := TRBreak():New(oSection1, oSection1:Cell('PRODUTO'), '', .T.)

    //? Faz a soma de todos os valores da coluna 'TOTAL'
	TRFunction():New(oSection2:Cell('VAL. TOTAL'), 'VALTOT', 'SUM', oBreak, 'VALOR TOTAL',,, .F., .F., .F.) 

	//? Exibindo a tela de configura��o para a impress�o do relat�rio
 	oReport:PrintDialog()

Return

Static Function  Imprima(oReport)

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oSection1:Section(1)
	Local cUltProd  := ''
	Local nTotReg	:= 0

	Private cAlias	:= ""

	GeraQuery()	
//	SC7New->(DBSELECTAREA())

	Count to nTotReg

	oReport:SetMeter(nTotReg)
	oReport:StartPage()
	SC7New->(DBGOTOP())

	While SC7New->(!EOF())
		if oReport:Cancel()
			Exit //! Cancela o loop, ou seja, para o processo.
		endif

		if AllTrim(cUltProd) <> AllTrim(SC7New->C7_NUM)
			if !Empty(cUltProd)
				oSection2:Finish() //? Finalizando se��o 2
				oSection1:Finish() //? Finalizando se��o 1
				oReport:EndPage()  //? Finalizando P�gina
			endif
		
		//? Inicializando a se��o 1
		oSection1:Init()
		cCodPed  := AllTrim(SC7New->C7_NUM)
		cDtEmi   := DtoC(StoD(SC7New->C7_EMISSAO))
		cCodForn := cValToChar(SC7New->C7_FORNECE)
		cLjForn  := cValToChar(SC7New->C7_LOJA)
		cCnPagam := AllTrim(SC7New->COND)
		cUltProd  := cCodPed
		
	//? Imprimindo linha
			oSection1:PrintLine()
            
			//? Inicializando a se��o 2
			oSection2:Init()
		endif

		cCodProd   	:= AllTrim(SC7New->C7_PRODUTO)
		cDescProd   := AllTrim(SC7New->C7_DESCRI)
		cQuantVend  := cValToChar(SC7New->C7_QUANT)
		cValorUnit  := cValToChar(SC7New->C7_PRECO)
		cValorTotal := cValToChar(SC7New->C7_TOTAL)

		//? Imprimindo linha
		oSection2:PrintLine()
		//? Incrementa a barra de processamento
		oReport:IncMeter()
		SC7New->(DBSkip())
	ENDDO

	//? Finalizando se��o 1
		oSection1:Finish()	
	//? Finalizando se��o 2
		oSection2:Finish()	
	
	SC7New->(DBCloseArea())		
	//? Finalizando a p�gina na impress�o
	oReport:EndPage()

Return

Static Function GeraQuery()
	Local cQuery := ''

	cQuery := 'SELECT' + CRLF
	cQuery += '	c7_num, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND AS COND, ' + CRLF
	cQuery += '	C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL' + CRLF
	cQuery += ' FROM' + CRLF
	cQuery += '	 ' + RetSqlName('SC7') + ' C7' + CRLF
	cQuery += "WHERE D_E_L_E_T_ = ' '" + CRLF
    tcQuery cQuery ALIAS 'SC7New' new   

Return 
