#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#iNCLUDE 'FWPRINTSETUP.CH'

#DEFINE PRETO RGB(000, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE 770

/*/{Protheus.doc} User Function SPrinter
    Desenvolva uma rotina para reproduzir o relatório
    de venda disponibilizado juntamente com a
    atividade.
    Você pode colocar outro logo.
    Os dados da empresa serão os que estão no
    cadastro do Protheus (TESTE).
    Os campos “Vendedor” e “Validade” não precisam
    ser adicionados.
    @type  Function
    @author user
    @since 17/04/2023
    /*/
User Function SPrinter()
    Local cAlias := GeraQuery()
    Private cString  := ''
    Private nCor   := 0

    if !Empty(cAlias)
        //? Régua de processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Gerando relatório...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return

Static Function GeraQuery()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''

    cQuery += 'SELECT A1_COD, A1_NOME, A1_EMAIL, A1_END, A1_MUN, A1_DDD, A1_TEL, A1_CGC, A1_IPWEB, A1_CONTATO, A1_BAIRRO, A1_CEP, A1_FAX, A1_INSCR,' + CRLF  
	cQuery += 'C5_NUM, C5_FRETE, C5_DESPESA, C5_MENNOTA, C5_ESPECI1, C5_VOLUME1, C5_TPFRETE, C5_DESC1, C5_DESC2, C5_DESC3, C5_DESC4, C5_VEND1,' + CRLF 
    cQuery += ' C6_ITEM, C6_PRODUTO,C6_DESCRI, C6_UM, C6_QTDVEN, C6_PRCVEN, C6_VALDESC, C6_IPITRF, C6_ENTREG, C6_DTVALID,' + CRLF
    cQuery += ' E4_COND, E4_DESCRI' + CRLF
    cQuery += 'FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
    cQuery += 'INNER JOIN SC5990 AS SC5 ON SA1.A1_COD = SC5.C5_CLIENT AND SA1.A1_LOJA = SC5.C5_LOJAENT ' + CRLF
    cQuery += 'INNER JOIN SC6990 AS SC6 ON SC6.C6_NUM = SC5.C5_NUM' + CRLF
    cQuery += 'INNER JOIN SE4990 AS SE4 ON SE4.E4_CODIGO = SC5.C5_CONDPAG ' + CRLF
    cQuery += 'INNER JOIN SA4990 AS SA4 ON SA4.A4_COD = SC5.C5_TRANSP' + CRLF
	cQuery += "WHERE SC5.D_E_L_E_T_ = ''" + CRLF
    cQuery += "AND SC6.D_E_L_E_T_ = ''"   + CRLF
    cQuery += "AND SA1.D_E_L_E_T_ = ''"   + CRLF
    cQuery += "AND SA4.D_E_L_E_T_ = ''"   + CRLF
    cQuery += "ORDER BY SA1.A1_NOME"      + CRLF

    TCQUERY cQuery ALIAS (cAlias) NEW
    (cAlias)->(DbGoTop())
    if (cAlias)->(EOF())
       cAlias := '' 
    endif

      RestArea(aArea)
Return cAlias

//? Função principal (Criação do Relatório)
Static Function MontaRel(cAlias)
    Local cCamPDF  := 'C:\PROTHEUS1212210\estudos\Lista 11\Exerc 6\'
    LocaL cNomePDF := 'Rel_Ex6.pdf'

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
    IMPORTADADOS(cAlias)
    //? finalizamdo a impressão
    oPrint:endPage()
    //? Mostrando o relatório
    oPrint:Preview()

RETURN

Static Function Cabecalho(cAlias)

    Local cLogo := ('C:\PROTHEUS1212210\protheus_data\system\LGMID.png') 

    oPrint:SayBitMap(20, 20, cLogo, 70, 65)

    oPrint:Say(15, 450, AllTrim(SA2->(A2_NOME)), oFont14,, PRETO)
    oPrint:Say(25, 350, AllTrim(SA2->(A2_END)) + '/' +AllTrim(SA2->(A2_NR_END)) +'/'+ AllTrim(SA2->(A2_MUN)) + '/'+ AllTrim(SA2->(A2_EST))+ '/' + AllTrim(SA2->(A2_CEP)), oFont12,, PRETO)
    oPrint:Say(55, 350, 'Email: ' + AllTrim(SA2->(A2_EMAIL)), oFont12,, PRETO)
    oPrint:Say(975, 110, 'Fone: ' + AllTrim(SA2->(A2_TELRE)) + " " + Alltrim(SA2->(A2_FAX)) , oFont12,, PRETO)
    oPrint:Say(115, 110, 'CNPJ: ' + AllTrim(SA2->(A2_CGC)) + ' - ' + 'IE: ' + Alltrim(SA2->(A2_INSCR)), oFont14,, PRETO)

    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')
     oPrint:Say(nLinha, 20, 'Pedido de venda',       oFont12, /*Width*/, PRETO)

RETURN

Static Function IMPORTADADOS(cAlias)
    
    DbSelectArea(cAlias)
    (cAlias)->(DbGoTop())
    while (cAlias)->(!EOF())
        
     oPrint:Say(nLinha, 020, AllTrim((cAlias)->(C5_NUM)), oFont10,, nCor)   

    nLinha += 30    
        (cALias)->(DbSkip())
    enddo
    (cAlias)->(DbCloseArea())
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
