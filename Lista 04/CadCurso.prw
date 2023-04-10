#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} CadCurso
    18 – Desenvolva uma rotina que permita realizar
cadastros de cursos.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function CadCurso()
  Local cAlias  := 'ZZC'
  Local cTitulo := 'Cadastro de Curso'

  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, .F., NIL)
Return
