#include 'protheus.ch'

/*/{Protheus.doc} MA020ROT
     7 � Utilize um PE para adicionar uma nova op��o ao
bot�o �Outras A��es� do cadastro de
fornecedores. Essa op��o dever� ter o nome
�Cad. Produtos� e quando clicar nela, dever� abrir
o browse do cadastro de produtos, permitindo
realizar qualquer uma das opera��es padr�o
(Incluir, Alterar, Visualizar, Excluir...) 
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return aRotUser, Array, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function MA020ROT()
Local aRotUser := {}
    
AAdd( aRotUser, {'Cad. Produtos', 'u_Cadas', 0, 6 } )

Return (aRotUser)
