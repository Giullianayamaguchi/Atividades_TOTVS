#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function TREPORT2
	2 � Adicione um bot�o � tela de Cadastro de
	Fornecedores. A fun��o desse bot�o ser� imprimir
	os dados do fornecedor selecionado.
	Voc� mesmo determinar� quais s�o os campos que
	devem ser impressos.
	@type  Function
	@author Giulliana Yamaguchi 
	@since 06/04/2023
	/*/
User Function TReport2()
	Local oReport := CriaReport()

	// Exibe na tela configura��es de impress�o
	oReport:PrintDialog()
Return 

Static Function CriaReport()
	Local cAlias := GetNextAlias()
	Local oReport := TReport():NEW('TREPORT', 'Relat�rio de Fornecedores',, {|oReport| Imprime(oReport, cAlias)}, 'Esse relat�rio imprimir� todos os cadastros de Fornecedores',.F.,,,, .T., .T.)
	
	Local oSection1 := TRSection():New(oReport, "Fornecedores Novos por Codigo",,,.F.,.T.)	

	TRCell():New(oSection1, 'A2_COD', 'SA2', 'Codigo',,8,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_LOJA', 'SA2', 'Loja',,8,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_NOME', 'SA2', 'Nome',,30,,,'LEFT',.T.,'LEFT',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_NREDUZ', 'SA2', 'Nome REDUZ',,20,,,'LEFT',.T.,'LEFT',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_END', 'SA2', 'Endereco',,30,,,'LEFT',.T.,'LEFT',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_BAIRRO', 'SA2', 'Bairro',,20,,,'LEFT',.T.,'LEFT',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_EST', 'SA2', 'Estado',,10,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_MUN', 'SA2', 'Municipio',,15,,,'LEFT',.T.,'LEFT',,,.T.,,,.T.)
	TRCell():New(oSection1, 'A2_TIPO', 'SA2', 'Tipo',,8,,,'CENTER',.T.,'CENTER',,,.T.,,,.T.)
	
RETURN oReport

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

		//? Setando o conte�do do registro posicionado nas colunas da se��o
		oSection1:Cell('CODIGO'):SetValue((cAlias)->A2_COD)
		oSection1:Cell('LOJA'):SetValue((cAlias)->A2_LOJA)
		oSection1:Cell('NOME'):SetValue((cAlias)->A2_NOME)
		oSection1:Cell('NOME REDUZ'):SetValue((cAlias)->A2_NREDUZ)
		oSection1:Cell('Endereco'):SetValue((cAlias)->A2_END)
		oSection1:Cell('Bairro'):SetValue((cAlias)->A2_BAIRRO)
		oSection1:Cell('Estado'):SetValue((cAlias)->A2_EST)
		oSection1:Cell('Municipio'):SetValue((cAlias)->A2_MUN)
		oSection1:Cell('Tipo'):SetValue((cAlias)->A2_TIPO)
		
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

	cQuery += 'SELECT A2_COD, A2_LOJA, A2_NOME, A2_NREDUZ, A2_END, A2_BAIRRO, A2_EST, A2_MUN, A2_TIPO' + CRLF
	cQuery += 'FROM ' + RetSqlName('SA2') + ' SA2' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF

Return cQuery
