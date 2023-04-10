#Include "Protheus.ch"
 
/*/{Protheus.doc} MBlkColor
    8 – Utilizando um Ponto de Entrada, faça com que
os registros bloqueados de qualquer tabela sejam
apresentados com uma cor diferente, como no
exemplo abaixo (o produto “TESTE 02” está
bloqueado): 
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return aRet, array, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/


#Define CLR_RGB_BRANCO        RGB(254,254,254)    //Cor Branca em RGB
#Define CLR_RGB_VERMELHO        RGB(255,000,000)    //Cor Vermelha em RGB
#Define CLR_RGB_PRETO        RGB(000,000,000)    //Cor Preta em RGB
 
User Function MBlkColor()
    Local aRet := {}    //Se deixar assim tem o retorno padrão
 
    //Adicionando as cores
    aAdd(aRet, (CLR_RGB_PRETO)   ) //Cor do texto
    aAdd(aRet, (CLR_RGB_VERMELHO)) //Cor de fundo
 
Return aRet
