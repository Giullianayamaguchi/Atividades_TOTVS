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
  1 – Desenvolva uma rotina que, ao ser
  executada, gere uma planilha com todos os
  cadastros de fornecedores. Essa planilha deve
  conter os seguintes dados:
  o Código
  o Nome
  o Loja
  o CNPJ
  o Endereço
  o Bairro
  o Cidade
  o UF
  @type  Function
  @author Giulliana Yamaguchi
  @since 20/04/2023
  /*/

User Function PlanXlsx()
  Local oExcel  := FwMsExcelEx():New() //? Instanciando a classe para criaÃ§Ã£o da planilha
  Local cPath   := 'C:\PROTHEUS1212210\estudos\Lista 12\Exerc 1\' //? Local onde quer salvar o arquivo
  local cArq    := 'Rel_Exer1.xls' //? nome do arquivo
  Local cQuery  := ''
  Local aArea   := GetArea()
  Local cAlias  := GetNextAlias()
  Local cCod    := ''
  Local cNome   := ''
  Local nLoja   := ''
  Local nCnpj   := ''
  Local cEnd    := ''
  Local cBairro := ''
  Local  cCidade:= ''
  Local cUf     := ''
  Local aForn   := {}
  Local nI      := 0

  //? Criando nova aba
  oExcel:AddworkSheet('Fornecedores')
  
  //? Adicionando nova tabela
  oExcel:AddTable('Fornecedores', 'Dados Cadastrais')
  
  //? Adicionando colunas
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Código'      , LEFT  , GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Nome'        , LEFT  , GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Loja'        , CENTER, GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'CNPJ'        , CENTER, GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Endereço'    , LEFT  , GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Bairro'      , LEFT  , GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'Cidade'      , LEFT  , GERAL)
  oExcel:AddColumn('Fornecedores', 'Dados Cadastrais', 'UF'          , CENTER, GERAL)

  //? Alterando estilos da linha 1
  oExcel:SetLineFont('Times New Roman')
  oExcel:SetLineSizeFont(10)
  
  rpcsetenv('99', '01')

    cQuery := 'SELECT A2_COD, A2_NOME, A2_LOJA, A2_CGC, A2_END, A2_BAIRRO,A2_MUN, A2_EST ' + CRLF
    cQuery += "FROM SA2990 SA2" + CRLF

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias)->(!EOF())
        cCod    := &(cAlias)->(A2_COD)
        cNome   := &(cAlias)->(A2_NOME)
        nLoja   := &(cAlias)->(A2_LOJA)
        nCnpj   := &(cAlias)->(A2_CGC)
        cEnd    := &(cAlias)->(A2_END)
        cBairro := &(cAlias)->(A2_BAIRRO)
        cCidade := &(cAlias)->(A2_MUN)
        cUf     := &(cAlias)->(A2_EST)

       AADD(aForn, {cCod, cNome, nLoja, nCnpj, cEnd, cBairro, cCidade, cUf})

        &(cAlias)->(DbSkip())
    end

  for nI := 1 to Len(aForn)
    oExcel:ADDROW('Fornecedores', 'Dados Cadastrais', {aForn[nI][1], aForn[nI][2],aForn[nI][3],aForn[nI][4],aForn[nI][5],aForn[nI][6],aForn[nI][7],aForn[nI][8]})
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
