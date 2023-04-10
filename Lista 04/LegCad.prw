#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} LegCad
    • 20 – Altere a rotina do exercício 17 para que no
browse do cadastro de alunos sejam
apresentadas legendas da seguinte forma:
o Alunos com mais de 18 anos:
? Legenda Verde
o Alunos com menos de 18 anos:
? Legenda Vermelha
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


User Function LegCad()

    Local cAlias := 'ZZC',  cFiltro   := ''

    Local aCores := { { 'ZZC->ZZC_DATNAS < Date()-6570' , 'ENABLE' },; // 6570 dias = 8 anos
                      { 'ZZC->ZZC_DATNAS > Date()-6570' , 'DISABLE' } }

    Private cCadastro := 'Cadastro de alunos '
    Private aRotina := {{ 'Pesquisar' ,    'AxPesqui' ,     0, 1 },;
                        { 'Visualizar' ,   'AxVisual' ,     0, 2 },;
                        { 'Incluir' ,      'AxInclui' ,     0, 3 },;
                        { 'Alterar' ,      'AxAltera' ,     0, 4 },;
                        { 'Excluir' ,      'AxDeleta' ,     0, 5 },;
                        { 'Alunos' ,       'U_CadZZ2' ,     0, 6 }}

    DbSelectArea('ZZC')
    DbSetOrder(1)

    MBrowse(,,,,cAlias,,,,,,aCores,,,,,,,,cFiltro)     

    DbCloseArea()

Return
