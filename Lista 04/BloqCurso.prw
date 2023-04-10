#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} BloqCurso
    19 – Altere a rotina do exercício anterior para que
não seja possível excluir um curso cadastrado.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return lRet, Logico, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function  BloqCurso()
  Local cAlias  := 'ZZE'
  Local cTitulo := 'Cadastro de Alunos'
  Local lFun    := BloqueiaExcluir

  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, lFun, NIL)
Return

User Function BloqueiaExcluir()
    
    Local lRet := .F.

    FwAlertError('Não é possível excluir cursos cadastrados!')
    lRet := .F.

Return lRet
