#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

#DEFINE LEFT      1
#DEFINE CENTER    2
#DEFINE RIGHT     3
#DEFINE GERAL     1
#DEFINE NUMERO    2
#DEFINE MONETARIO 3
#DEFINE DATETIME  4

/*/{Protheus.doc} User Function PlanXlsx
    2 – Crie uma função que gerará uma planilha com todos os
    cadastros de produtos existentes no banco de dados,
    incluindo os excluídos. A planilha deve conter os
    seguintes dados:
    o Código
    o Descrição
    o Tipo
    o Unidade de Medida
    o Preço de Venda
    • Obs: A fonte dos cadastros excluídos deve estar com a
    cor vermelha.
  @type  Function
  @author Giulliana Yamaguchi
  @since 20/04/2023
  /*/

User Function Rel_Exer2()
  Local oExcel  := FwMsExcelEx():New() //? Instanciando a classe para criaÃ§Ã£o da planilha
  Local cPath   := 'C:\PROTHEUS1212210\estudos\Lista 12\Exerc 2\' //? Local onde quer salvar o arquivo
  local cArq    := 'Rel_Exer2.xls' //? nome do arquivo
  Local cQuery  := ''
  Local aArea   := GetArea()
  Local cAlias  := GetNextAlias()
  Local cCod    := ''
  Local cDesc   := ''
  Local nTipo   := ''
  Local cUn     := ''
  Local nvalor  := ''
  Local cDelet  := ''
  Local aForn   := {}
  Local nI      := 0

  //? Criando nova aba
  oExcel:AddworkSheet('Produtos')
  
  //? Adicionando nova tabela
  oExcel:AddTable('Produtos', 'Cadastro de Produtos')
  
  //? Adicionando colunas
  oExcel:AddColumn('Produtos', 'Cadastro de Produtos', 'Código'         , LEFT  , GERAL)
  oExcel:AddColumn('Produtos', 'Cadastro de Produtos', 'Descrição'      , LEFT  , GERAL)
  oExcel:AddColumn('Produtos', 'Cadastro de Produtos', 'Tipo'           , CENTER, GERAL)
  oExcel:AddColumn('Produtos', 'Cadastro de Produtos', 'Unid. Medida'   , CENTER, GERAL)
  oExcel:AddColumn('Produtos', 'Cadastro de Produtos', 'Preço'          , LEFT  , MONETARIO)

  //? Alterando estilos da linha 1
  oExcel:SetLineFont('Times New Roman')
  oExcel:SetLineSizeFont(10)
  
  rpcsetenv('99', '01')

    cQuery := 'SELECT B1_COD, B1_DESC, B1_TIPO, B1_UM, B1_PRV1, D_E_L_E_T_ as deletado' + CRLF
    cQuery += "FROM SB1990 SB1" + CRLF

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())
        cCod    := &(cAlias)->(B1_COD)
        cDesc   := &(cAlias)->(B1_DESC)
        nTipo   := &(cAlias)->(B1_TIPO)
        cUn     := &(cAlias)->(B1_UM)
        nvalor  := &(cAlias)->(B1_PRV1)
        cDelet  := &(cAlias)->(deletado)

        AADD(aForn, {cCod, cDesc, nTipo, cUn, nvalor})
        &(cAlias)->(DbSkip())

        if cDelet != ' '
          
          oExcel:SetLineBgColor('#FF0000')
        ENDIF
    end

  for nI := 1 to Len(aForn)

        oExcel:ADDROW('Produtos', 'Cadastro de Produtos', {aForn[nI][1], aForn[nI][2],aForn[nI][3],aForn[nI][4],aForn[nI][5]})
    
  NEXT

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)
   //? Ativando a classe
  oExcel:Activate()
  //? Gerando arquivo fÃ­sico
  oExcel:GetXMLFile(cPath + cArq)
  //? Verifica se tem o Excel instalado no PC
  if ApOleClient('MsExcel')
    oExec := MsExcel():New()
    oExec:WorkBooks:Open(cPath + cArq)
    oExec:SetVisible(.T.)
    oExec:Destroy()
    cMsgTitle := 'Planilha gerada com sucesso!'
    cMsg      := 'Arquivo salvo em: ' + cPath + cArq
    FwAlertSuccess(cMsg, 'Tudo certo!')
  else
    cMsg := 'Microsoft Excel não encontrado!' + CRLF
    cMsg += 'Arquivo salvo em: ' + cPath + cArq
    FwAlertError(cMsg, 'Atenção!')
  endif
  //? Desativando a classe
  oExcel:DeActivate()
Return
