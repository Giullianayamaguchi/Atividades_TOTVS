#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#iNCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO RGB(000, 000, 000)
#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE 770


/*/{Protheus.doc} User Function nomeFunction
    2 – Adicione um botão à tela de Cadastro de
    Fornecedores. A função desse botão será imprimir
    os dados do fornecedor selecionado.
    Você mesmo determinará quais são os campos que
    devem ser impressos.
    @type  Function
    @author user
    @since 17/04/2023
    /*/
User Function SPrint2()

    if !Empty(SA2->A2_COD)
        //? Régua de processamento
	    Processa({|| MontaRel()}, 'Aguarde...', 'Gerando relatório...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return



Static Function MontaRel()
    Local cCamPDF  := 'C:\PROTHEUS1212210\estudos\Lista 11\Exerc 2\'
    LocaL cNomePDF := 'Rel_Ex2.pdf'

    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private nColIni  := 020
    Private nColFim  := 820
    Private oPrint

    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*Itálico*/)
    //? Criando objeto de impressão
    oPrint := FWMSPrinter():New(cNomePDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
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
    ImpDados()
    //? finalizamdo a impressão
    oPrint:endPage()
    //? Mostrando o relatório
    oPrint:Preview()

RETURN

Static Function Cabecalho()

     Local cLogo := ('C:\PROTHEUS1212210\protheus_data\system\LGMID.png') //? Para que o logo seja impresso, é necessário colocá-lo na pasta system (dentro da protheus_data).
    //? Criando caixa para colocar texto
    oPrint:Box(5, 15, 85, 580, '-8')
    //? Adicionando uma linha horizontal
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')
    oPrint:SayBitMap(20, 20, cLogo, 70, 65)
    //? Adicionando uma linha vertical
    oPrint:Line(15, 100, 85, 100)
    //? Imprimindo texto do cabeçalho
    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Clientes', oFont16,, PRETO)


    oPrint:Say(nLinha, 20,  'CODIGO',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'LOJA',          oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 130, 'NOME',          oFont12, /*Width*/, PRETO)
     oPrint:Say(nLinha, 230, 'ENDEREÇO',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 330, 'BAIRRO',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 420, 'ESTADO',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 470, 'MUNICÍPIO',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 530, 'TIPO',          oFont12, /*Width*/, PRETO)

    nLinha += 5
    //? Adicionando uma linha horizontal
    oPrint:Line(nLinha, 015, nLinha, 580, /*Cor*/, '-6')
    nLinha += 20 
Return

Static Function ImpDados()
    Local cString  := ''
    Private nCor   := 0
    
        VeriQuebPg(MAX_LINE)

            //? Imprimindo CÓDIGO DO CLIENTE
        oPrint:Say(nLinha, 020, AllTrim(SA2->(A2_COD)), oFont10,, nCor)
            //? Copiando o NOME DO CLIENTE para a variável cString
        cString  := AllTrim(SA2->(A2_LOJA))
            //? Chamando função que verifica se há a necessidade de quebrar a linha
        VeriQuebLn(cString, 20, 80)
            //? Copiando o ENDEREÇO para a variável cString
        cString  := AllTrim(SA2->(A2_NOME))
        VeriQuebLn(cString, 20, 130)
            //? Copiando a CIDADE para a variável cString
        cString  := AllTrim(SA2->(A2_END))
        VeriQuebLn(cString, 20, 230)
        
        cString  := AllTrim(SA2->(A2_BAIRRO))
        VeriQuebLn(cString, 20, 330)

        cString  := AllTrim(SA2->(A2_EST))
        VeriQuebLn(cString, 20, 420)

        cString  := AllTrim(SA2->(A2_MUN))
        VeriQuebLn(cString, 20, 470)

        cString  := AllTrim(SA2->(A2_TIPO))
        VeriQuebLn(cString, 20, 530)
        
    nLinha += 30    
        SA2->(DbSkip())
    
Return

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

