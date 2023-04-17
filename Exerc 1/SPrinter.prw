#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

//? Cores
#DEFINE PRETO    RGB(000, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE  770

/*/{Protheus.doc} SPrinter
    1 – Desenvolva um relatório de produtos utilizando
    FwMSPrinter.
    O relatório deve ser acessado través de uma
    opção no menu do Protheus e deve conter os
    seguintes dados:
    o Código
    o Descrição
    o Unidade de Medida
    o Preço de Venda
    ? Obs: Se não houver preço cadastrado,
    deve ser apresentado “R$0,00”

o Armazém
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/04/2023
    /*/

USER Function SPrinter()
     Local cAlias := GeraCons()
    if !Empty(cAlias)
        //? Régua de processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relatório...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
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

//? Função principal (Criação do Relatório)
Static Function MontaRel(cAlias)
    Local cCamPDF    := 'C:\PROTHEUS1212210\estudos\Lista 11\Exercício 1\'
    Local cArqPDF    := 'Rel_ex1.pdf'
    // Local cArqReport := 'Relatorio_FwMsPrinter'
    //? Local aFonts:= GetFontList() - A função GetFontList retorna um array com todos os nomes de ontes disponíveis. Obs: Nem todas funcionarão corretamente no Protheus.
    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private nColIni  := 020
    Private nColFim  := 820
    Private oPrint
    //? Criando padrões de fontes
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*Itálico*/)
    //? Criando objeto de impressão
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
    oPrint:cPathPDF := cCamPDF
    //? Inicializando página de configuração da impressão.
    // oPrint:Setup()
    //? Definindo que a orientação da página será "Retrato"
    oPrint:SetPortrait()
    //? Definindo o tamanho da impressão como A4
    oPrint:setPaperSize(9)
    //? Criando nova Página
    oPrint:StartPage()
    //? Imprime o cabeçalho
    Cabecalho()
    ImpDados(cAlias)
    //? finalizamdo a impressão
    oPrint:endPage()
    //? Mostrando o relatório
    oPrint:Preview()
Return
//? Função para imprimir o cabeçalho
Static Function Cabecalho(cAlias)
    //? Criando caixa para colocar texto
    oPrint:Box(015, 015, 085, 580, '-8')
    //? Adicionando uma linha horizontal
    oPrint:Line(050, 015, 050, 580, /*Cor*/, '-6')
    //? Adicionando uma linha vertical
    // oPrint:Line( 050, 100, 085, 100)
    //? Imprimindo texto do cabeçalho
    oPrint:Say(035, 020, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(070, 220, 'Relatório de Produtos', oFont16,, PRETO)
    
    //? Imprimindo Título das colunas
    oPrint:Say(nLinha, 20, 'CÓDIGO',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'DESCRIÇÃO',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 200, 'UN. MEDIDA',    oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 320, 'PREÇO',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 400, 'ARMAZÉM',       oFont12, /*Width*/, PRETO)
    
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
        //? Verificando se atingiu o número máximo de linhas para uma página (770)
        VeriQuebPg(MAX_LINE)

        IF (cAlias)->(B1_PRV1) == 0
            cPreco := 'R$' + Alltrim(STR(B1_PRV1)) + ',00'
        ELSE 
            cPreco := 'R$' + Alltrim(STR(B1_PRV1))

        ENDIF
        //? Imprimindo CÓDIGO DO CLIENTE
        oPrint:Say(nLinha, 020, AllTrim((cAlias)->(B1_COD)), oFont10,, nCor)
        //? Copiando o NOME DO CLIENTE para a variável cString
        cString  := AllTrim((cAlias)->(B1_DESC))
        //? Chamando função que verifica se há a necessidade de quebrar a linha
        VeriQuebLn(cString, 20, 80)
        //? Copiando o ENDEREÇO para a variável cString
        cString  := AllTrim((cAlias)->(B1_UM))
        VeriQuebLn(cString, 20, 200)
        //? Copiando o BAIRRO para a variável cString
        cString  := (Alltrim(cPreco))
        VeriQuebLn(cString, 20, 320)
        //? Copiando a CIDADE para a variável cString
        cString  := AllTrim((cAlias)->(B1_LOCPAD))
        VeriQuebLn(cString, 20, 400)
        
        //? Aumentando em 30 a posição da linha.
        nLinha += 30
        (cALias)->(DbSkip())
    enddo
    (cAlias)->(DbCloseArea())
Return

//? Função para fazer quebra de Linha
//? Parâmetros: 1 - String que será verificada, 2 - Quantidade de caracteres por linha, 3 - Coluna em que o texto será impresso 
Static Function VeriQuebLn(cString, nLineTam, nCol)
    Local cLinha   := ''
    Local lTemQbra := .F.
    Local nQtdLine := MLCount(cString, nLineTam, /*Tab. Size*/, .F.) //? Conta quantas linhas são necessárias para escrever o texto com baso no tamanho de linha estipulado em "nLineTam"
    Local nI       := 1
    if nQtdLine > 1
        lTemQbra := .T.
        for nI := 1 to nQtdLine
            //? A função MemoLine copia a quantidade de caracteres de acordo com o tamanho definido em "nLineTam" e atribui o valor em "cLinha", fazendo isso para cada linha.
            //? Obs: A quantidade de linhas necessárias foi definida pela função MLCount
            cLinha := MemoLine(cString, nLineTam, nI) 
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, nCor)
            //? Aumentando em 10 a posição da linha.
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, nCor)
    endif
    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return

//? Função para fazer a quebra de página
Static Function VeriQuebPg(nMax)
    if nLinha > nMax
        //? Encerrando a página atual
        oPrint:EndPage()
        //? Iniciando uma nova página
        oPrint:StartPage()
        nLinha := 105
        
        //? Imprimindo o cabeçalho
        Cabecalho()
    endif
Return

