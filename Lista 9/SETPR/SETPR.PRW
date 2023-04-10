#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} User Function SETPR
    Relatório feito em SetPrint                                      
    @type  Function
    @author Giulliana Yamaguchi
    @since 03/04/2023
    /*/
User Function SETPR()
    Local cTitulo       := 'Cadastro de itens'
	Private cTamanho    := 'M'
	Private cNomeProg   := 'PSAY' //? Nome do programa para impressao no cabecalho
	Private aReturn     := {'Zebrado', 1, 'Administracao', 1, 2, '', '', 1}
	Private nLastKey    := 0
	Private cNomRel     := 'PSAY' //? Nome do arquivo usado para impressao em disco
	Private cAlias 	    := 'SB1'
	Private m_pag			  := 1
	//? Monta a interface padrao com o usuario...
	cNomRel := SetPrint(cAlias, cNomeProg, '', @cTitulo, '', '', '', .F.,, .T., cTamanho,, .F.)
	//? Se pressionar "ESC" encerra o programa
	if nLastKey == 27
		FwAlertError('Operação cancelada pelo usuário!', 'CANCELADO!')
		Return
	endif

	//? Prepara o ambiente para impressão
	SetDefault(aReturn, cAlias,, .T., 1)
	//? Processamento. RPTSTATUS monta janela com a regua de processamento.

	RptStatus({|| Imprime(cTitulo)}, cTitulo)
Return

Static Function Imprime(cTitulo)
	Local cCabec		 := '   CÓDIGO          DESCRIÇÃO                      UN. MED.    PREÇO   ARMAZÉM'
    Local cTraco		 := '---------------------------------------------------------------------------------------------------------------------------------'
	Local nLinha 		 := 8 //? Linha em que a impressão iniciará
	Local aColunas  	 := {}
    Local cPreco         := ''
	//? Colunas para impressão
	Aadd(aColunas, 001)
	Aadd(aColunas, 010)
	Aadd(aColunas, 050)
	Aadd(aColunas, 060)
	Aadd(aColunas, 075)
	DbSelectArea('SB1')
	SB1->(DbSetOrder(1))
	//? Cabeçalho do Relatório
	Cabec(cTitulo, cCabec, '',, cTamanho)
	//? Impressão dos dados de cada registro em linha
	while !Eof()

         IF SB1->B1_PRV1 == 0
            cPreco := 'R$' + Alltrim(STR(SB1->B1_PRV1)) + ',00'
        ELSE 
            cPreco := 'R$' + Alltrim(STR(SB1->B1_PRV1))

        ENDIF
        @ nLinha, aColunas[1] PSAY PADR(Alltrim(SB1->B1_COD), 10)
		@ nLinha, aColunas[2] PSAY PADR(Alltrim(SB1->B1_DESC), 40)
		@ nLinha, aColunas[3] PSAY PADR(Alltrim(SB1->B1_UM), 10)
		@ nLinha, aColunas[4] PSAY PADR(aLLTRIM(cPreco), 10)
		@ nLinha, aColunas[5] PSAY PADR(Alltrim(SB1->B1_LOCPAD), 10)
		nLinha++
//		@ nLinha,00 PSAY cTraco

		nLinha++

		SB1->(dbSkip())
  enddo

	//? Finaliza a execucao do relatorio...
	SET DEVICE TO SCREEN
	//? Se impressao em disco, chama o gerenciador de impressao...
	if aReturn[5] == 1
		SET PRINTER TO dbCommitAll()
		OurSpool(cNomRel) //? Gerenciador de impressão do Protheus
	endif
	//? Descarrega o spool de impressão
	MS_FLUSH()
Return 
