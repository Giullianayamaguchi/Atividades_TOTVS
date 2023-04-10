#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} CadAlu
    17 – Desenvolva uma rotina que permita realizar
cadastros de alunos.
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


User Function CadAlu()
  Local cAlias  := 'ZZE'
  Local cTitulo := 'Cadastro de Alunos'

  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, .F., NIL)
Return
