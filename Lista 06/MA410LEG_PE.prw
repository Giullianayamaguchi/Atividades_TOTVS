#include 'protheus.ch'

/*/{Protheus.doc} MA410LEG
    4 – Você acabou de mudar a legenda no browse dos
pedidos de venda, agora, utilizando outro PE,
altere as imagens da janela onde é possível
identificar o que cada legenda representa. Deve
ficar desse jeito:
    @type  Function
    @author Giulliana Yamaguchi
    @since 14/03/2023
    @version version
    @param 
    @return aLeg, array, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
    
user function MA410LEG()

Local aLeg := { {'CHECKOK' ,"Pedido de Venda em aberto"},;
{'BR_CANCEL' ,"Pedido de Venda encerrado"},;
{'GCTPIMSE',"Pedido de Venda liberado" },;
{'BR_AZUL' ,"Pedido de Venda com Bloqueio de Regra"},;
{'BR_LARANJA',"Pedido de Venda com Bloqueio de Verba" }}

Return aLeg
