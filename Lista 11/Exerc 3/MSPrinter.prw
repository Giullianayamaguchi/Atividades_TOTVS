#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#iNCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO RGB(000, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE 770

/*/{Protheus.doc} User Function MSPrinter
   4 � Adicione um totalizador ao relat�rio gerado no
    exerc�cio anterior. Esse totalizador deve conter
    o valor total da compra, ou seja, a soma do valor
    total de cada item.
    
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/04/2023
    /*/
User Function SPrinter()
    Local cAlias := GeraQuery()
    Private cString  := ''
    Private nCor   := 0

    if !Empty(cAlias)
        //? R�gua de processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Gerando relat�rio...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Aten��o')
    endif
Return

//? Fun��o que gera e executa a consulta no BD.
Static Function GeraQuery()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''

    cQuery += 'SELECT C7_NUM, C7_EMISSAO, C7_FORNECE, C7_LOJA, C7_COND, ' + CRLF  // query cabe�alho
	cQuery += '       C7_PRODUTO, C7_DESCRI, C7_QUANT, C7_PRECO, C7_TOTAL' + CRLF // queru corpo/ itens
    cQuery += 'FROM ' + RetSqlName('SC7') + ' SC7' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF

    TCQUERY cQuery ALIAS (cAlias) NEW
    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
       cAlias := '' 
    endif
    
    RestArea(aArea)
Return cAlias

//? Fun��o principal (Cria��o do Relat�rio)
Static Function MontaRel(cAlias)
    Local cCamPDF  := 'C:\PROTHEUS1212210\estudos\Lista 11\Exerc 4\'
    LocaL cNomePDF := 'Rel_Ex4.pdf'

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
    oPrint := FWMSPrinter():New(cNomePDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
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
    IMPDADOSCABE(cAlias)
    
    //? finalizamdo a impress�o
    oPrint:endPage()
    //? Mostrando o relat�rio
    oPrint:Preview()

RETURN

Static Function Cabecalho(cAlias)

     Local cLogo := ('C:\PROTHEUS1212210\protheus_data\system\LGMID.png') //? Para que o logo seja impresso, � necess�rio coloc�-lo na pasta system (dentro da protheus_data).
    //? Criando caixa para colocar texto
    oPrint:Box(5, 15, 85, 580, '-8')
    //? Adicionando uma linha horizontal
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')
    oPrint:SayBitMap(20, 20, cLogo, 70, 65)
    //? Adicionando uma linha vertical
    oPrint:Line(15, 100, 85, 100)
    //? Imprimindo texto do cabe�alho
    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Clientes', oFont16,, PRETO)

    //? CABE�ALHO 
    oPrint:Say(nLinha, 20, 'N�M PEDIDO',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 100,  'EMISS�O',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 220, 'COD FORNE',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 320, 'LOJA FORNE',       oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 400, 'COND PAGAM',       oFont12, /*Width*/, PRETO)

    oPrint:Line(140, 15, 140, 580, /*Cor*/, '-6')
    nLinha += 5
    nLinha += 50 

    oPrint:Say(nLinha, 20, 'C�D PROD',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'DESCRI��O',      oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 260, 'QUANT',       oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 360, 'VALOR UNI',   oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 450, 'VALOR TOTAL', oFont12, /*Width*/, PRETO)
    nLinha += 5
 
Return

Static Function IMPDADOSCABE(cAlias)
    Local cUltProd := AllTrim((cAlias)->(C7_NUM))
    
    DbSelectArea(cAlias)
    (cAlias)->(DbGoTop())
    while (cAlias)->(!EOF())
        //? Verificando se atingiu o n�mero m�ximo de linhas para uma p�gina (770)
        VeriQuebPg(MAX_LINE)

            nLinha := 130
            oPrint:Say(nLinha, 020, AllTrim((cAlias)->(C7_NUM)), oFont10,, nCor)
                //? Copiando o NOME DO CLIENTE para a vari�vel cString
            cString  := AllTrim((cAlias)->(C7_EMISSAO))
                //? Chamando fun��o que verifica se h� a necessidade de quebrar a linha
            VeriQuebLn(cString, 20, 100)
                //? Copiando o ENDERE�O para a vari�vel cString
            cString  := AllTrim((cAlias)->(C7_FORNECE))
            VeriQuebLn(cString, 20, 220)
                //? Copiando a CIDADE para a vari�vel cString
            cString  := AllTrim((cAlias)->(C7_LOJA))
            VeriQuebLn(cString, 20, 320)
            
            cString  := AllTrim((cAlias)->(C7_COND))
            VeriQuebLn(cString, 20, 400)

            nLinha += 50
            
            cUltProd := AllTrim((cAlias)->(C7_NUM))

        while AllTrim(cUltProd) == AllTrim((cAlias)->(C7_NUM))

            oPrint:Say(nLinha, 020, AllTrim((cAlias)->(C7_PRODUTO)), oFont10,, nCor)
                //? Copiando o NOME DO CLIENTE para a vari�vel cString
            cString  := AllTrim((cAlias)->(C7_DESCRI))
                //? Chamando fun��o que verifica se h� a necessidade de quebrar a linha
            VeriQuebLn(cString, 20, 80)
                //? Copiando o ENDERE�O para a vari�vel cString
            cString  := AllTrim(str((cAlias)->(C7_QUANT)))
            VeriQuebLn(cString, 20, 260)
                //? Copiando a CIDADE para a vari�vel cString
            cString  := AllTrim(str((cAlias)->(C7_PRECO)))
            VeriQuebLn(cString, 20, 360)
            
            cString  := AllTrim(str((cAlias)->(C7_TOTAL)))
            VeriQuebLn(cString, 20, 450)

            nLinha += 20
            (cALias)->(DbSkip())

        ENDDO

       oPrint:EndPage()
        //? Iniciando uma nova p�gina
        oPrint:StartPage()
        nLinha := 105
        
        //? Imprimindo o cabe�alho
        Cabecalho()
 
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
