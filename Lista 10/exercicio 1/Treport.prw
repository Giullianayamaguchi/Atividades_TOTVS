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
	
	//? Exibindo a tela de configura��o para a impress�o do relat�rio
 	oReport:PrintDialog()
Return

Static Function GeraReport()
	Local cAlias	:= GetNextAlias()

	//? Instanciando a classe de impress�o.
	Local oReport	:= TReport():New('TREPORT', 'Relat�rio de Produtos',,{|oReport| Imprime(oReport, cAlias)}, 'Esse relat�rio imprimir� todos os cadastros de Produtos',.F.,,,, .T., .T.)	
	//? Instanciando a classe de sess�o (Ficar� dentro da impress�o)
	Local oSection1	:= TRSection():New(oReport, "Produtos Novos por Codigo",,,.F.,.T.)	

	//TRCell():New(oSection1, 'campo', 'tabela', 'nome', /*Picture*/, tamanho, /*Pixel*/, /*Code-Block*/,centraliza��o , .T.,centraliza��o , /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
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
	//? Define o t�tulo do Relat�rio
	oReport:SetTitle('Relat�rio de Produtos')
	//? Inicializa uma nova p�gina para impress�o
	oReport:StartPage()
	oSection1:Init()  
	(cAlias)->(DBGoTop())

	while !(cAlias)->(EoF())
		//? Se cancelar a opera��o
		if oReport:Cancel() //! Cancela o loop, ou seja, o processo.
			Exit
		endif

		//? Setando o conte�do do registro posicionado na coluna "C�digo" da se��o
		oSection1:Cell('CODIGO'):SetValue((cAlias)->B1_COD)

		//? Setando o conte�do do registro posicionado na coluna "DESCRICAO" da se��o
		oSection1:Cell('DESCRICAO'):SetValue((cAlias)->B1_DESC)
	
		//? Setando o conte�do do registro posicionado na coluna "UN. MEDIDA" da se��o
		oSection1:Cell('UN. MEDIDA'):SetValue((cAlias)->B1_UM)
		
		//? Setando o conte�do do registro posicionado na coluna "PRECO" da se��o
		oSection1:Cell('PRECO'):SetValue((cAlias)->B1_PRV1)
		
		//? Setando o conte�do do registro posicionado na coluna "ARMAZEM" da se��o
		oSection1:Cell('ARMAZEM'):SetValue((cAlias)->B1_LOCPAD)
		
		//? Imprimindo (gerando) a linha
		oSection1:PrintLine()
		//? Imprimindo uma linha fina
		oReport:ThinLine()
		//? Imcrementando a barra de progress�o
		oReport:IncMeter()
		(cAlias)->(DBSkip())
	enddo   
	
	(cAlias)->(DBCloseArea())
	//? Finalizando a impress�o da se��o
	oSection1:Finish()			
	//? Finalizando a p�gina na impress�o
	oReport:EndPage()
Return

Static Function GeraQuery()
	Local cQuery := ''
	cQuery += 'SELECT B1_COD, B1_DESC, B1_UM,B1_PRV1, B1_LOCPAD' + CRLF
	cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
Return cQuery
