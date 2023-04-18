#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#iNCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO RGB(000, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE 770

/*/{Protheus.doc} User Function nomeFunction
    5 – Também na rotina de Pedidos de Compra,
    adicione um novo botão que possibilite gerar um
    relatório de todos os pedidos existentes
    juntamente com seus respectivos produtos e com
    o totalizador do pedido.
    Obs: Cada pedido deve ser impresso em uma página,
    independente da quantidade de itens. Toda vez
    que uma página for iniciada, antes dos dados do
    pedido, deve ser impresso o cabeçalho.
    Também adicionar o número da página impressa.
    @type  Function
    @author user
    @since 17/04/2023
    /*/
User Function SPrint5()

    Private cString  := ''
    Private nCor   := 0

    if !Empty(SC7->(C7_NUM))
        //? Régua de processamento
	    Processa({|| MontaRel()}, 'Aguarde...', 'Gerando relatório...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return


//? Função principal (Criação do Relatório)
Static Function MontaRel()
    Local cCamPDF  := 'C:\PROTHEUS1212210\estudos\Lista 11\Exerc 5\'
    LocaL cNomePDF := 'Rel_Ex5.pdf'

    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private Numpag   := 1
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
    oPrint := FWMSPrinter():New(cNomePDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)
    oPrint:cPathPDF := cCamPDF
    //? Inicializando página de configuração da impressão.

    //? Definindo que a orientação da página será "Retrato"
    oPrint:SetPortrait()
    //? Definindo o tamanho da impressão como A4
    oPrint:setPaperSize(9)
    //? Criando nova Página
    oPrint:StartPage()
    //? Imprime o cabeçalho
    Cabecalho()
    IMPDADOSCABE()
    
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
    oPrint:Say(20, 530,  str(Numpag), oFont10,, PRETO)
    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Clientes', oFont16,, PRETO)

    //? CABEÇALHO 
    oPrint:Say(nLinha, 20, 'NÚM PEDIDO',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 100,  'EMISSÃO',         oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 220, 'COD FORNE',        oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 320, 'LOJA FORNE',       oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 400, 'COND PAGAM',       oFont12, /*Width*/, PRETO)

    oPrint:Line(140, 15, 140, 580, /*Cor*/, '-6')
    nLinha += 5
    nLinha += 50 

    //?ITENS
    oPrint:Say(nLinha, 20, 'CÓD PROD',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'DESCRIÇÃO',      oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 260, 'QUANT',       oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 360, 'VALOR UNI',   oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 450, 'VALOR TOTAL', oFont12, /*Width*/, PRETO)
    nLinha += 5
    
Return

Static Function IMPDADOSCABE()
    Local cUltProd := AllTrim(SC7->(C7_NUM))
    Local cTotal   := 0
    
    DbSelectArea("SC7")
    SC7->(DbGoTop())
    while SC7->(!EOF())
        //? Verificando se atingiu o número máximo de linhas para uma página (770)
        VeriQuebPg(MAX_LINE)

            nLinha := 130
            oPrint:Say(nLinha, 020, AllTrim(SC7->(C7_NUM)), oFont10,, nCor)
                
            cString  := AllTrim(DTOC(SC7->C7_EMISSAO))
                
            VeriQuebLn(cString, 20, 100)
                
            cString  := AllTrim(SC7->(C7_FORNECE))
            VeriQuebLn(cString, 20, 220)
               
            cString  := AllTrim(SC7->(C7_LOJA))
            VeriQuebLn(cString, 20, 320)
            
            cString  := AllTrim(SC7->(C7_COND))
            VeriQuebLn(cString, 20, 400)

            nLinha += 50
            
            cUltProd := AllTrim(SC7->(C7_NUM))

        while AllTrim(cUltProd) == AllTrim(SC7->(C7_NUM))

            oPrint:Say(nLinha, 020, AllTrim(SC7->(C7_PRODUTO)), oFont10,, nCor)
                
            cString  := AllTrim(SC7->(C7_DESCRI))
            VeriQuebLn(cString, 20, 80)

            cString  := AllTrim(str(SC7->(C7_QUANT)))
            VeriQuebLn(cString, 20, 260)

            cString  := AllTrim(str(SC7->(C7_PRECO)))
            VeriQuebLn(cString, 20, 360)
            
            cString  := AllTrim(str(SC7->(C7_TOTAL)))
            VeriQuebLn(cString, 20, 450)

            cTotal += SC7->(C7_TOTAL)

            nLinha += 20
            SC7->(DbSkip())

        ENDDO

        
        nLinha += 10
        oPrint:Line(nLinha, 15, nLinha, 580, /*Cor*/, '-6')

        nLinha += 10
        oPrint:Say(nLinha, 020, AllTrim("TOTAL: " + str(cTotal)+ ',00'), oFont10,, nCor)

        cTotal := 0
       oPrint:EndPage()
        //? Iniciando uma nova página
        oPrint:StartPage()
        Numpag += 1
        
        nLinha := 105
        
        //? Imprimindo o cabeçalho
        Cabecalho()
 
        SC7->(DbSkip())
    enddo
    SC7->(DbCloseArea())
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
