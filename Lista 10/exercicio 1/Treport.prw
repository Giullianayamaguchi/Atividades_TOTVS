#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'


/*/{Protheus.doc} User Function TReport
	exerc 1
	@type  Function
	@author user
	@since 05/04/2023
	/*/
User Function TReport()
	Local oReport := GeraReport() 
	
	//? Exibindo a tela de configuração para a impressão do relatório
 	oReport:PrintDialog()
Return

Static Function GeraReport()
	Local cAlias	:= GetNextAlias()

	//? Instanciando a classe de impressão.
	Local oReport	:= TReport():New('TREPORT', 'Relatório de Produtos',,{|oReport| Imprime(oReport, cAlias)}, 'Esse relatório imprimirá todos os cadastros de Produtos',.F.,,,, .T., .T.)	
	//? Instanciando a classe de sessão (Ficará dentro da impressão)
	Local oSection1	:= TRSection():New(oReport, "Produtos Novos por Codigo",,,.F.,.T.)	

	//TRCell():New(oSection1, 'campo', 'tabela', 'nome', /*Picture*/, tamanho, /*Pixel*/, /*Code-Block*/,centralização , .T.,centralização , /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	TRCell():New(oSection1, 'B1_COD', 'SB1', 'CODIGO',,8,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'B1_DESC', 'SB1', 'DESCRICAO',,20,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'B1_UM', 'SB1', 'UN. MEDIDA',,10,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'B1_PRV1', 'SB1', 'PRECO','@E 999,999,999.99',10,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'B1_LOCPAD', 'SB1', 'ARMAZEM',,10,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)

Return oReport

Static Function Imprime(oReport, cAlias)
	Local oSection1 := oReport:Section(1)
	Local nTotReg		:= 0
	Local cQuery		:= GeraQuery()	

	DBUseArea(.T., 'TOPCONN', TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)	

	Count TO nTotReg
	oReport:SetMeter(nTotReg)
	//? Define o título do Relatório
	oReport:SetTitle('Relatório de Produtos')
	//? Inicializa uma nova página para impressão
	oReport:StartPage()
	oSection1:Init()  
	(cAlias)->(DBGoTop())

	while !(cAlias)->(EoF())
		//? Se cancelar a operação
		if oReport:Cancel() //! Cancela o loop, ou seja, o processo.
			Exit
		endif

		//? Setando o conteúdo do registro posicionado na coluna "Código" da seção
		oSection1:Cell('CODIGO'):SetValue((cAlias)->B1_COD)

		//? Setando o conteúdo do registro posicionado na coluna "DESCRICAO" da seção
		oSection1:Cell('DESCRICAO'):SetValue((cAlias)->B1_DESC)
	
		//? Setando o conteúdo do registro posicionado na coluna "UN. MEDIDA" da seção
		oSection1:Cell('UN. MEDIDA'):SetValue((cAlias)->B1_UM)
		
		//? Setando o conteúdo do registro posicionado na coluna "PRECO" da seção
		oSection1:Cell('PRECO'):SetValue((cAlias)->B1_PRV1)
		
		//? Setando o conteúdo do registro posicionado na coluna "ARMAZEM" da seção
		oSection1:Cell('ARMAZEM'):SetValue((cAlias)->B1_LOCPAD)
		
		//? Imprimindo (gerando) a linha
		oSection1:PrintLine()
		//? Imprimindo uma linha fina
		oReport:ThinLine()
		//? Imcrementando a barra de progressão
		oReport:IncMeter()
		(cAlias)->(DBSkip())
	enddo   
	
	(cAlias)->(DBCloseArea())
	//? Finalizando a impressão da seção
	oSection1:Finish()			
	//? Finalizando a página na impressão
	oReport:EndPage()
Return

Static Function GeraQuery()
	Local cQuery := ''
	cQuery += 'SELECT B1_COD, B1_DESC, B1_UM,B1_PRV1, B1_LOCPAD' + CRLF
	cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
Return cQuery
