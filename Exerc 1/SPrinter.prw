#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

//? Cores
#DEFINE PRETO    RGB(000, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE  770

/*/{Protheus.doc} SPrinter
    1 � Desenvolva um relat�rio de produtos utilizando
    FwMSPrinter.
    O relat�rio deve ser acessado trav�s de uma
    op��o no menu do Protheus e deve conter os
    seguintes dados:
    o C�digo
    o Descri��o
    o Unidade de Medida
    o Pre�o de Venda
    ? Obs: Se n�o houver pre�o cadastrado,
    deve ser apresentado �R$0,00�

o Armaz�m
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/04/2023
    /*/

USER Function SPrinter()
     Local cAlias := GeraCons()
    if !Empty(cAlias)
        //? R�gua de processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relat�rio...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Aten��o')
    endif
Return 

Static Function GeraCons()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    
    cQuery += 'select B1_COD, B1_DESC, B1_UM, B1_PRV1, B1_LOCPAD ' + CRLF
	cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
    cQuery += "ORDER BY B1_COD" + CRLF
    TCQUERY cQuery ALIAS (cAlias) NEW
    (cAlias)->(DbGoTop())
    if (cAlias)->(EOF())
       cAlias := '' 
    endif
    
    RestArea(aArea)
Return cAlias

//? Fun��o principal (Cria��o do Relat�rio)
Static Function MontaRel(cAlias)
    Local cCamPDF    := 'C:\PROTHEUS1212210\estudos\Lista 11\Exerc�cio 1\'
    Local cArqPDF    := 'Rel_ex1.pdf'
    // Local cArqReport := 'Relatorio_FwMsPrinter'
    //? Local aFonts:= GetFontList() - A fun��o GetFontList retorna um array com todos os nomes de ontes dispon�veis. Obs: Nem todas funcionar�o corretamente no Protheus.
    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private nColIni  := 020
    Private nColFim  := 820
    Private oPrint
    //? Criando padr�es de fontes
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*It�lico*/)
    //? Criando objeto de impress�o
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
    oPrint:cPathPDF := cCamPDF
    //? Inicializando p�gina de configura��o da impress�o.
    // oPrint:Setup()
    //? Definindo que a orienta��o da p�gina ser� "Retrato"
    oPrint:SetPortrait()
    //? Definindo o tamanho da impress�o como A4
    oPrint:setPaperSize(9)
    //? Criando nova P�gina
    oPrint:StartPage()
    //? Imprime o cabe�alho
    Cabecalho()
    ImpDados(cAlias)
    //? finalizamdo a impress�o
    oPrint:endPage()
    //? Mostrando o relat�rio
    oPrint:Preview()
Return
//? Fun��o para imprimir o cabe�alho
Static Function Cabecalho(cAlias)
    //? Criando caixa para colocar texto
    oPrint:Box(015, 015, 085, 580, '-8')
    //? Adicionando uma linha horizontal
    oPrint:Line(050, 015, 050, 580, /*Cor*/, '-6')
    //? Adicionando uma linha vertical
    // oPrint:Line( 050, 100, 085, 100)
    //? Imprimindo texto do cabe�alho
    oPrint:Say(035, 020, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(070, 220, 'Relat�rio de Produtos', oFont16,, PRETO)
    
    //? Imprimindo T�tulo das colunas
    oPrint:Say(nLinha, 20, 'C�DIGO',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'DESCRI��O',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 200, 'UN. MEDIDA',    oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 320, 'PRE�O',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 400, 'ARMAZ�M',       oFont12, /*Width*/, PRETO)
    
    nLinha += 5
    //? Adicionando uma linha horizontal
    oPrint:Line(nLinha, 015, nLinha, 580, /*Cor*/, '-6')
    nLinha += 20 
Return

Static Function ImpDados(cAlias)
    Local cString  := ''
    Private nCor   := 0
    
    DbSelectArea(cAlias)
    (cAlias)->(DbGoTop())
    while (cAlias)->(!EOF())
        //? Verificando se atingiu o n�mero m�ximo de linhas para uma p�gina (770)
        VeriQuebPg(MAX_LINE)

        IF (cAlias)->(B1_PRV1) == 0
            cPreco := 'R$' + Alltrim(STR(B1_PRV1)) + ',00'
        ELSE 
            cPreco := 'R$' + Alltrim(STR(B1_PRV1))

        ENDIF
        //? Imprimindo C�DIGO DO CLIENTE
        oPrint:Say(nLinha, 020, AllTrim((cAlias)->(B1_COD)), oFont10,, nCor)
        //? Copiando o NOME DO CLIENTE para a vari�vel cString
        cString  := AllTrim((cAlias)->(B1_DESC))
        //? Chamando fun��o que verifica se h� a necessidade de quebrar a linha
        VeriQuebLn(cString, 20, 80)
        //? Copiando o ENDERE�O para a vari�vel cString
        cString  := AllTrim((cAlias)->(B1_UM))
        VeriQuebLn(cString, 20, 200)
        //? Copiando o BAIRRO para a vari�vel cString
        cString  := (Alltrim(cPreco))
        VeriQuebLn(cString, 20, 320)
        //? Copiando a CIDADE para a vari�vel cString
        cString  := AllTrim((cAlias)->(B1_LOCPAD))
        VeriQuebLn(cString, 20, 400)
        
        //? Aumentando em 30 a posi��o da linha.
        nLinha += 30
        (cALias)->(DbSkip())
    enddo
    (cAlias)->(DbCloseArea())
Return

//? Fun��o para fazer quebra de Linha
//? Par�metros: 1 - String que ser� verificada, 2 - Quantidade de caracteres por linha, 3 - Coluna em que o texto ser� impresso 
Static Function VeriQuebLn(cString, nLineTam, nCol)
    Local cLinha   := ''
    Local lTemQbra := .F.
    Local nQtdLine := MLCount(cString, nLineTam, /*Tab. Size*/, .F.) //? Conta quantas linhas s�o necess�rias para escrever o texto com baso no tamanho de linha estipulado em "nLineTam"
    Local nI       := 1
    if nQtdLine > 1
        lTemQbra := .T.
        for nI := 1 to nQtdLine
            //? A fun��o MemoLine copia a quantidade de caracteres de acordo com o tamanho definido em "nLineTam" e atribui o valor em "cLinha", fazendo isso para cada linha.
            //? Obs: A quantidade de linhas necess�rias foi definida pela fun��o MLCount
            cLinha := MemoLine(cString, nLineTam, nI) 
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, nCor)
            //? Aumentando em 10 a posi��o da linha.
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, nCor)
    endif
    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return

//? Fun��o para fazer a quebra de p�gina
Static Function VeriQuebPg(nMax)
    if nLinha > nMax
        //? Encerrando a p�gina atual
        oPrint:EndPage()
        //? Iniciando uma nova p�gina
        oPrint:StartPage()
        nLinha := 105
        
        //? Imprimindo o cabe�alho
        Cabecalho()
    endif
Return

