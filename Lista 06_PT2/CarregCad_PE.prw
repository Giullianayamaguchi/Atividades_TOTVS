#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} CarregCad
    10 – Acrescente um botão à rotina de Cadastros de
Fornecedores, para que seja possível acessar os
Cadastros de Produtos.
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return aBotao, array, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/


User Function CarregCad()
  Local aBotao := {}
  Aadd(aBotao, {'Cad. Produtos', '', {||AxCadastro('SB1', 'Cadastro de Produtos')}, 'Cad. Produto'})
Return aBotao
