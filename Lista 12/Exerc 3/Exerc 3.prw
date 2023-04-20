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
    3 – Lembra da rotina que desenvolvemos em aula para
  cadastrar cursos e alunos dos cursos?
  Adicione um novo botão a essa rotina. Ao acionar esse
  botão deverá ser gerada uma planilha com todos os
  cursos e seus respectivos alunos.
  Cada curso cadastrado deverá ser apresentado em
  uma aba e dentro dessa aba deverão conter os alunos do
  respectivo curso. Em cada aba devem ser apresentados
  os Códigos, Nomes e Idades dos alunos.
  @type  Function
  @author Giulliana Yamaguchi
  @since 20/04/2023
  /*/

User Function L12_Ex3()
  Local oExcel  := FwMsExcelEx():New() //? Instanciando a classe para criaÃ§Ã£o da planilha
  Local cPath   := 'C:\PROTHEUS1212210\estudos\Lista 12\Exerc 3\' //? Local onde quer salvar o arquivo
  local cArq    := 'Rel_Exer3.xls' //? nome do arquivo
  Local cQuery  := ''
  Local cAlias  := GetNextAlias()
  Local aArea   := GetArea()
  Local cCurso  := ''

  //? Alterando estilos da linha 1
  oExcel:SetLineFont('Times New Roman')
  oExcel:SetLineSizeFont(10)
  
  rpcsetenv('99', '01')

    cQuery := 'SELECT ZZC_COD, ZZC_CURSO ,ZZB_COD, ZZE_ALUNO, ZZE_IDADE' + CRLF
    cQuery += "FROM ZZB990" + CRLF
    cQuery += "INNER JOIN ZZC990 ON ZZB_CURSO = ZZC_COD" + CRLF
    cQuery += "INNER JOIN ZZE990 ON ZZE_CODIGO = ZZB_COD" + CRLF

    TCQUERY cQuery ALIAS &(cAlias) NEW
    
    while &(cAlias)->(!EOF())
        If cCurso != (cAlias)->(ZZC_CURSO)
          cCurso := (cAlias)->(ZZC_CURSO)

          oExcel:AddworkSheet(cCurso)
  
          oExcel:AddTable(cCurso, 'Cadastro de Alunos')
          
          //? Adicionando colunas
          oExcel:AddColumn(cCurso, 'Cadastro de Alunos', 'Código'  , LEFT  , GERAL)
          oExcel:AddColumn(cCurso, 'Cadastro de Alunos', 'Nome'    , LEFT  , GERAL)
          oExcel:AddColumn(cCurso, 'Cadastro de Alunos', 'Idade'   , CENTER, GERAL)

        ENDIF
        
        oExcel:ADDROW(cCurso, 'Cadastro de Alunos', {(cAlias)->(ZZB_COD), (cAlias)->(ZZE_ALUNO), (cAlias)->(ZZE_IDADE)})
        (cAlias)->(DbSkip())
  

    enddo

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
